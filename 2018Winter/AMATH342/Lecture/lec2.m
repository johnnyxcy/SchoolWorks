count = 1;
N=200;
for t=1:1300
    if spike_train(t) == 1
        sec(count, :) = stim_list((t-N):t);
        count = count + 1;
    end
end
for t=1:N
    sta(t) = mean(sec(:, t));
end
sta = sta/sum(spike_train);
figure;
plot(sta)  