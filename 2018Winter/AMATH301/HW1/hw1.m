A = [1 2; -3 1];
B = [5 3; -1 3];
C = [1 2 3; -9 2 4];
D = [1 -2; -1 3; 2 3];
x = [-2; 0];
y = [0; 3];
z = [2; -3; 1];

% Problem 1
% (a)
ans1a = B - A;
save A1.dat ans1a -ascii;

% (b)
ans1b = -2 * x + 4 * y;
save A2.dat ans1b -ascii;

% (c)
ans1c = B * x;
save A3.dat ans1c -ascii;

% (d)
ans1d = A * (x - y);
save A4.dat ans1d -ascii;

% (e)
ans1e = C * z;
save A5.dat ans1e -ascii;

% (f)
ans1f = A * B;
save A6.dat ans1f -ascii;

% (g)
ans1g = B * A;
save A7.dat ans1g -ascii;

% (h)
ans1h = A * C;
save A8.dat ans1h -ascii;

% (i)
ans1i = C * D;
save A9.dat ans1i -ascii;

% The answer in (f) and (g) are not the same due to the multiplication
% order are different. 
% If try to calculate CA, DC or x + z, Matlab will pop out an error "inner matrix
% dimensions must agree"

% (j)
ans1j = D(1:2, :);
save A10.dat ans1j -ascii;

% (k)
ans1k = C(:, 2);
save A11.dat ans1k -ascii;

% (l)
ans1l = C(1, end-1:end);
save A12.dat ans1l -ascii;

% Problem 2
% x1
sum = 0;
for k = 1:800000
    sum = sum + 0.1;
end
x1 = abs(80000 - sum);
save A13.dat x1 -ascii;

% x2
sum = 0;
for k = 1:640000
    sum = sum + 0.125;
end
x2 = abs(80000 - sum);
save A14.dat x2 -ascii;

% x3
sum = 0;
for k = 1:400000
    sum = sum + 0.2;
end
x3 = abs(80000 - sum);
save A15.dat x3 -ascii;

% x4
sum = 0;
for k = 1:320000
    sum = sum + 0.25;
end
x4 = abs(80000 - sum);
save A16.dat x4 -ascii;

% Some values are really close to 0 but not exactly 0.
% The reason could be that the storage of 0.1 is not exactly 0.1 but 0.25
% and 0.125 are exact.

% Problem 3
p = 10;
r = 3;
K = 20;
q(1) = p;
for t = 2:100
    p = r * p * (1 - p/K);
    q(t) = p;
end
save A17.dat p -ascii;
plot(q);