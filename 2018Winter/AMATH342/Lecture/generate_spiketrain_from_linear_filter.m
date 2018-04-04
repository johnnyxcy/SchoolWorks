%Generate single spiketrain
clear all

rand('state',sum(100*clock));

T=1 * 10^3; %total duration of spike train, in milliseconds
deltat=1;  %in ms

data_length=round(T/deltat);

rate_list=zeros(1,data_length);  
spike_train=zeros(1,data_length);  %list of 0/1 spike/or not each timestep

%define filter
D= @(t) exp(-t/100) * 1/100;
filter_length=300;  %how long filter must be, numerically:  as mny ms as takes for it to decay to 0
filter_time_list=deltat:deltat:filter_length;
filter=D(filter_time_list);

%define stimulus
pad_length=filter_length;    %start stimulus a time pad_length before "0"
stim_list = randn(1,data_length+pad_length) ;  %list of stimulus values at each timestep


for i=1:data_length
    stim_start_index=pad_length+i-filter_length; 
    stim_end_index=pad_length+i-1; 
    stim_segment=stim_list(stim_start_index:stim_end_index);
    rate_list(i) = max( sum(filter.* fliplr(stim_segment))*deltat ,0);
end

prob_list=min( rate_list*deltat , 1);  %round down any huge spike probas
spike_train=round(rand(1,data_length) + (prob_list-1/2)) ;

%now, to make comparision less confusing, let's pad the spike train with a bunch of zeros
%during the "pad" time of the stimulus, when we did not try to generate
%spikes anyway

spike_train = [zeros(1,pad_length) spike_train] ;
rate_list = [zeros(1,pad_length) rate_list] ;
time_list=deltat*(1:length(stim_list));  %list of times



figure;
subplot(211)
plot(time_list,stim_list);
title('stimulus','FontSize',18)
subplot(212)
stem(time_list,spike_train,'.')
xlabel('time (ms)','FontSize',15)
title('spike raster plot','FontSize',15)
set(gca,'FontSize',14)


figure;
subplot(211)
plot(time_list,rate_list);
title('firing rate (underlying inhomog poisson process)','FontSize',12)
subplot(212)
stem(time_list,spike_train,'.')
xlabel('time (ms)','FontSize',15)
title('spikes','FontSize',15)
set(gca,'FontSize',14)

