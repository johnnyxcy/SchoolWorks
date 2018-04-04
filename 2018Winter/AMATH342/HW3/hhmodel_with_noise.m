function [firingrate, fano] = hhmodel_with_noise(I)
    vna=50;  %set the constants
    vk=-77;
    vl=-54.4;
    gna=120;
    gk=36;
    gl=.3;
    c=1;
    
    v_init=-65;  %the initial conditions
    m_init=.052;
    h_init=.596;
    n_init=.317;

    npoints=50000;  %number of timesteps to integrate
    dt=0.01;        %timestep


    m=zeros(npoints,1); %initialize everything to zero
    n=zeros(npoints,1);
    h=zeros(npoints,1);
    v=zeros(npoints,1);
    time=zeros(npoints,1);
    noise = zeros(npoints, 1);
    
    m(1)=m_init; %set the initial conditions to be the first entry in the vectors
    n(1)=n_init;
    h(1)=h_init;
    v(1)=v_init;
    time(1)=0.0;
    numpeak = 0;
    thresh = 0;
    epsilon = 2;
    omega = 4;
    
    tic
    for step=1:npoints-1
        % noise
        noise(step) = -0.05 * rand() + 0.05 * rand();
        % current with noise
        I = I + epsilon * sin(2*pi*time(step)*omega) + noise(step);
        v(step+1)=v(step)+((I - gna*h(step)*(v(step)-vna)*m(step)^3 ...
                   -gk*(v(step)-vk)*n(step)^4-gl*(v(step)-vl))/c)*dt;
        m(step+1)=m(step)+ (alpha_m(v(step))*(1-m(step))-beta_m(v(step))*m(step))*dt;
        h(step+1)=h(step)+ (alpha_h(v(step))*(1-h(step))-beta_h(v(step))*h(step))*dt;
        n(step+1)=n(step)+ (alpha_n(v(step))*(1-n(step))-beta_n(v(step))*n(step))*dt;
        time(step+1)=time(step)+dt;

        % spike detection: decreasing now and increasing before
         if ((step>1) && (v(step+1)<v(step)) && (v(step)>v(step-1))) && (v(step) > thresh)
            numpeak = numpeak + 1;
            peaktime(numpeak) = time(step+1);
         end
    end
    toc
    
    firingrate = numpeak / (npoints * dt);
    fano = var(noise) / mean(noise);
    
end