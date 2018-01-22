spiketrain = generate_noisy_data_cockroach(60, 3, 10);

sums = zeros(1, 300);
for k = 1:300
    sums(k) = sum(spiketrain(:, k));
end
plot(sums)
xlabel('Time t');
ylabel('Sum of Spikes at Time t');