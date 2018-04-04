%% Find the image matrix
delay = 1;
i = find(spikeTrain == 1);
ii = i + round(time_between_samples * delay);
[m, n, L] = size(stim);
img = zeros(length(ii), m * n);
for k = 1:length(ii)
    if k > L
        img(k, :) = reshape(stim(:, :, L), m * n, 1);
    else
        img(k, :) = reshape(stim(:, :, k), m * n, 1);
    end
end
ave = mean(img);
ave = reshape(ave, m, n);
ave = imresize(ave, 100);
figure(1);
imshow(ave);
title('Average Image with 0.3 sec delay');
set(gca,'Fontsize',14,'fontweight','bold');

%% generate noisy data cockroach
ntrials = 100000;
spiketrain = generate_noisy_data_cockroach(45, 1, 100000);
%%
sum = zeros(ntrials, 1);
for k = 1:ntrials
    sum(k) = count_spike(spiketrain(k, :));
end
max(sum);
mean(sum);
%% Plot the spikes
histfit(sum);
title('Histogram of spike count');
xlabel('Number of spikes');
%%
input = 20;
x = 1;
% error probability
err = 1 - length(find(abs(sum - input) <= x)) / ntrials;

%% tol
tol = 0.1;
while err > tol
    x = x + 1;
    err = 1 - length(find(abs(sum - input) <= x)) / ntrials;
end


function c = count_spike(spiketrain)
    c = length(find(spiketrain == 1));
end