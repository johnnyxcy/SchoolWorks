% 
% This code will generate a spiking response to an input based on a tuning
% curve and assuming (inhomogeneous) Poisson firing. The response adapts
% over time, with a time constant of tau
%
function spiketrain = generate_noisy_data_cockroach(stimDir, cell_num, ntrials)

    rand('state',sum(100*clock));
    
    %{
    stimDir = input('Input the direction of your stimulus in degrees ');
    cell_num = input('Which cell do you want to record from (1,2,3) ');
    ntrials = input('How many repeated trials would you like to perform? ');
    %}

    nmsec = 300;    % number of milliseconds to record for
    times= 1:nmsec; % vector of time points (1 msec apart)

    spiketrain = zeros(ntrials,nmsec);      % set up output data

    rate = cockroach_tuning(stimDir, cell_num); %returns rate, in Hz.       
    tau = 100;      % adaptation time constant in msec
    delta_t=0.001; %time bin, in seconds (1 msec)
    ratefun = rate*exp(-times/tau);  % adapting rate function 



    for j = 1:ntrials;

        for i = 1:nmsec;

                spiketrain(j,i) = round(rand + ratefun(i)*delta_t -1/2 );

        end;

    end;
end

    