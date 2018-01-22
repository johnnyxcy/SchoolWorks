number_on = 1;
for t=2:30
    number_on(t) = 3 * number_on(t - 1);
end

figure
plot(number_on)
title('Number of "on" neurons over time')
xlabel('time t')
ylabel('Number of "on" neurons')