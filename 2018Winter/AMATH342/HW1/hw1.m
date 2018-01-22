tuning(1);
tuning(2);
tuning(3);
function sd = tuning(cell)
    f = cockroach_tuning(1:90, cell);
    a = zeros(1, 90);
    sd = zeros(1, 90);
    for d = 1:90
        [a(d), sd(d)] = count_rate(d, cell, 100);
    end
    figure
    plot(f)
    errorbar(f, sd);
    ylabel('f(Hz)');
    xlabel('Direction');
end
