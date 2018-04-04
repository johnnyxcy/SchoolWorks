clear all; close all; clc;
load('population.mat');
%% 
n = length(N);
dNdt = zeros(21, 1);
dNdt(1) = (-3 * N(1) + 4 * N(2) - N(3)) / (t(3) - t(1)); % forward
for i = 2:(n - 1)
    dNdt(i) = (N(i + 1) - N(i - 1)) / (t(i + 1) - t(i - 1)); % central
end
dNdt(n) = (3 * N(n) - 4 * N(n - 1) + N(n - 2)) / (t(n) - t(n - 2)); % backward
% plot(t,N,'k--','LineWidth',1.2), hold on, grid on;
% plot(t,dNdt,'k','LineWidth',3), hold on;
% l1 = legend('Function','Second Order Accurate Difference Scheme');
% hold off;
A1 = dNdt(1);
A2 = dNdt(11);
A3 = dNdt(21);
save('A1.dat', 'A1', '-ascii');
save('A2.dat', 'A2', '-ascii');
save('A3.dat', 'A3', '-ascii');
%%
pcg = zeros(21, 1);
for i = 1:n
    pcg(i) = dNdt(i) / N(i);
end
A4 = mean(pcg);
save('A4.dat', 'A4', '-ascii');

%%
load('brake_pad.mat');
dr = r(2) - r(1);
theta_p = 0.7051;
%% left-rectangle rule
T_total = 0;
A = 0;
nn = length(r);
for i = 1:nn - 1
    T_total = T_total + r(i) * T(i) * theta_p * dr;
    A = A + r(i) * theta_p * dr;
end
T_bar = T_total / A;
save('A5.dat', 'T_total', '-ascii');
save('A6.dat', 'A', '-ascii');
save('A7.dat', 'T_bar', '-ascii');
%% Trapzoid Rule
T_total = 0;
A = 0;
nn = length(r);
for i = 1:nn - 1
    TT = (r(i) * T(i) * theta_p + r(i + 1) * T(i + 1) * theta_p)...
        * dr / 2
    T_total = T_total + TT;
    AA = (r(i) * theta_p + r(i + 1) * theta_p) * dr / 2;
    A = A + AA;
end
T_bar = T_total / A;
save('A8.dat', 'T_total', '-ascii');
save('A9.dat', 'A', '-ascii');
save('A10.dat', 'T_bar', '-ascii');