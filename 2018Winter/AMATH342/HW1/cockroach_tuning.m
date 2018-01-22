function [ f ] = cockroach_tuning(stim_dir, cell_num)
    
    if cell_num == 1
        mu = 45;
        sigma = 5;
        f = gaussian(mu, sigma, stim_dir);
    elseif cell_num == 2
        mu = 45;
        sigma = 10;
        f = gaussian(mu, sigma, stim_dir); 
    else
        mu = 30;
        sigma = 10;
        f1 = gaussian(mu, sigma, stim_dir);
        mu = 60;
        f2 = gaussian(mu, sigma, stim_dir);
        f = (f1 + f2);
    end  
end

function [f] = gaussian(mu,sigma, x)
   maxrate = 300; % max firing rate
   f = maxrate*exp(-0.5*((x-mu)/sigma).^2);
end