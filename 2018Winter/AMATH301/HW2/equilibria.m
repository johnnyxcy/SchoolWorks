function P = equilibria(N, gamma)
    p = 10;
    K = 50;
    for t = 1:N
        P(t) = gamma * p * (1 - p / K);
        p = P(t);
    end
end