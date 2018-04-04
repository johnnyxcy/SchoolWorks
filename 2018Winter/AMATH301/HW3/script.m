clear all;
%
r1 = 15; r2 = 20; r3 = 6; r4 = 18; r5 = 25; r6 = 30;

A = [r6 + r1 + r2, -r1, -r2;
     -r1, r1 + r3 + r4, -r4;
     -r2, -r4, r2 + r4 + r5;];

% A1
[L, U, P] = lu(A);
a1 = U * P * L;
save A1.dat a1 -ascii;

% A2
for i = 1:100
    b = [50; i; 75];
    y = L \ (P * b);
    x(:, i) = U \ y;
end
a2 = x(2, :);
save A2.dat a2 -ascii;

% A3
for i = 1:100
    b = [50; i; 75];
    x(:, i) = inv(A) * b;
end
a3 = x(1, :);
save A3.dat a3 -ascii;

% A4, A5
s = sqrt(2) / 2;
A = zeros(13, 13);
A(1, 1) = -s;
A(1, 2) = 1;
A(1, 10) = s;
A(2, 1) = -s;
A(2, 9) = -1;
A(2, 10) = -s;
A(3, 2) = -1;
A(3, 3) = 1;
A(4, 11) = -1;
A(5, 3) = -1;
A(5, 4) = s;
A(5, 12) = -s;
A(6, 4) = -s;
A(6, 12) = -s;
A(6, 13) = -1;
A(7, 4) = -s;
A(7, 5) = -1;
A(8, 5) = 1;
A(8, 6) = -1;
A(9, 13) = 1;
A(10, 6) = 1;
A(10, 7) = -1;
A(10, 10) = -s;
A(10, 12) = s;
A(11, 10) = s;
A(11, 11) = 1;
A(11, 12) = s;
A(12, 7) = 1;
A(12, 8) = -1;
A(13, 9) = 1;

b = [0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 10, 0, 5];
b = b.';
[L, U, P] = lu(A);
y = L \ (P * b);
x = U \ y;
save A4.dat y -ascii;
save A5.dat x -ascii;

% A6
x = A \ b;
save A6.dat x -ascii;

% A7
b = [0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 10, 0, 5];
b = b.';
for w = 0:0.01:(30 - 4)
    b(9) = 4 + w;
    x = A \ b;
    if max(abs(x)) > 30
        weight = 4 + w;
        break;
    end
end
save A7.dat weight -ascii;

% A8
A = [10^(-20), 1;
     1, 1];
a8 = cond(A);
save A8.dat a8 -ascii;

% A9
L = [1, 0; 10^20, 1];
U = [10^(-20), 1; 0, 1 - 10^20];
a9 = L * U;
save A9.dat a9 -ascii;

% A10
L = [1, 0; 10^(-20), 1];
U = [1, 1; 0, 1 - 10^(-20)];
a10 = L * U;
save A10.dat a10 -ascii;