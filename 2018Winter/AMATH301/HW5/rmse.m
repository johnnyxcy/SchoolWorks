function err = rmse(m)
    load('salmon.mat');
    a = m(1); b = m(2); c = m(3);
    pred = exp(a .* t.^2 + b .* t + c);
    err = sqrt(mean((salmon - pred).^2));
end