% Problem 1
% A1
ans = func(0) * func(1.2);
save A1.dat ans -ascii;

% This tells f has a zero between the given interval since the product is 
% negative.

% A2
a = 0;
b = 1.2;
p = (a + b)/2;
err = abs(func(p));
step = 1;
while err > 1e-10
    if func(a)*func(p)<0 
       b = p;
    else
       a = p;          
    end
    p = (a + b)/2; 
    err = abs(func(p));
    step = step + 1;
end
save A2.dat p -ascii;

% A3
save A3.dat step -ascii;


% Problem 2

% A4
P1 = equilibria(100, 2.5);
P2 = equilibria(100, 3.2);
P3 = equilibria(100, 3.5);
A = [P1(98) P1(99) P1(100);
     P2(98) P2(99) P2(100);
     P3(98) P3(99) P3(100);
     ];
save A4.dat A -ascii;

% A5 A6
is_equilibrium = ones(1, 15);
equilibrium_value = zeros(1, 15);
tol = 1e-8;
for r = 2:0.1:3.4
    index = round(1 + (r - 2) / 0.1);
    P = equilibria(1e4, r);
    k = 1;
    try 
        while abs(P(k + 1) - P(k)) >= tol
            k = k + 1;
        end
        equilibrium_value(index) = P(k + 1);
    catch
        warning('Index exceeds matrix dimensions.');
        is_equilibrium(index) = 0;
    end
end
save A5.dat is_equilibrium -ascii;
save A6.dat equilibrium_value -ascii;

% A7
p = [1 0 0 0];
save A7.dat p -ascii;

% A8
P = [0.99 0.00 0.01 0.00;
     0.00 0.56 0.25 0.19;
     0.10 0.22 0.42 0.26;
     0.00 0.36 0.15 0.49;
     ];
index = 0;
while p(1) >= 0.8
    p = p * P;
    index = index + 1;
end
save A8.dat index -ascii;
save A9.dat p -ascii;

while true
    p1 = p * P;
    diff = abs(p1 - p);
    if all(diff(:) < tol)
        break;
    end
    p = p1;
end
save A10.dat p1 -ascii;