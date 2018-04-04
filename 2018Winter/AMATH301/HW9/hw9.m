%% Problem 1
clc; clear all;
I = @(t) 1/10 * (5 + sin(1/10 * pi * t));
a = 0.7; b = 0.8; tao = 12.5;

dvdt = @(v, w, t) v - 1/3 * v^3 - w + I(t);
dwdt = @(v, w) (a + v - b * w) / tao;
dt = 0.5;
t = 0:dt:100;
npoints = length(t);
v = zeros(npoints, 1);
w = zeros(npoints, 1);
v(1) = 1;
w(1) = 0;

for i = 2:npoints
    tt = t(i - 1) + dt / 2;
    dvdt1 = dvdt(v(i - 1), w(i - 1), t(i - 1));
    dwdt1 = dwdt(v(i - 1), w(i - 1));
    v(i) = v(i - 1) + dt * dvdt(v(i - 1) + dt / 2 * dvdt1, w(i - 1) + dt / 2 * dwdt1, tt);
    w(i) = w(i - 1) + dt * dwdt(v(i - 1) + dt / 2 * dvdt1, w(i - 1) + dt / 2 * dwdt1);
end

% plot(t, v);

% A1
A1 = v(end);
save('A1.dat', 'A1', '-ascii');

% A2, A3
vv = v(t >= 0 & t <= 20);
t1 = t(vv == max(vv));
t2 = t(vv == min(vv));
vvv = v(t >= 40 & t <= 50);
tt = t(t>=40&t<=50);
t3 = tt(vvv == max(vvv));
A2 = v(t == t1) - v(t == t2);
A3 = t3 - t1;
save('A2.dat', 'A2', '-ascii');
save('A3.dat', 'A3', '-ascii');

%% A4
clc; clear all;
I = @(t) 1/10 * (5 + sin(1/10 * pi * t));
a = 0.7; b = 0.8; tao = 12.5;

dvdt = @(v, w, t) v - 1/3 * v^3 - w + I(t);
dwdt = @(v, w) (a + v - b * w) / tao;
dt = 0.5;
t = 0:dt:100;
npoints = length(t);
v = zeros(npoints, 1);
w = zeros(npoints, 1);
v(1) = 1;
w(1) = 0;

for i = 2:npoints
    tk = t(i - 1); vk = v(i - 1); wk = w(i - 1);
    dvdt1 = dvdt(vk, wk, tk);
    dwdt1 = dwdt(vk, wk);
    dvdt2 = dvdt(vk + dt / 2 * dvdt1, wk + dt / 2 * dwdt1, tk + dt / 2);
    dwdt2 = dwdt(vk + dt / 2 * dvdt1, wk + dt / 2 * dwdt1);
    dvdt3 = dvdt(vk + dt / 2 * dvdt2, wk + dt / 2 * dwdt2, tk + dt / 2);
    dwdt3 = dwdt(vk + dt / 2 * dvdt2, wk + dt / 2 * dwdt2);
    dvdt4 = dvdt(vk + dt * dvdt3, wk + dt * dwdt3, tk + dt);
    dwdt4 = dwdt(vk + dt * dvdt3, wk + dt * dwdt3);
    v(i) = vk + dt / 6 * (dvdt1 + 2 * dvdt2 + 2 * dvdt3 + dvdt4);
    w(i) = wk + dt / 6 * (dwdt1 + 2 * dwdt2 + 2 * dwdt3 + dwdt4);
end

% A4
A4 = v(end);
save('A4.dat', 'A4', '-ascii');

% A5, A6
vv = v(t >= 0 & t <= 20);
t1 = t(vv == max(vv));
t2 = t(vv == min(vv));
vvv = v(t >= 40 & t <= 50);
tt = t(t>=40&t<=50);
t3 = tt(vvv == max(vvv));
A5 = v(t == t1) - v(t == t2);
A6 = t3 - t1;
save('A5.dat', 'A5', '-ascii');
save('A6.dat', 'A6', '-ascii');

%% Problem 2
clear all; clc;
dt = 0.01;
t = 0:dt:6;
t = t.';
npoints = 6 / dt;
A7 = npoints - 1;
save('A7.dat', 'A7', '-ascii');

x0 = 1;
xT = 2;

v1 = ones(npoints-2, 1);
v2 = -2*ones(npoints-1, 1);
A = diag(v2) + diag(v1, 1) + diag(v1, -1);
A = (1/dt^2) * A;
A = A + eye(npoints-1);
b = zeros(npoints-1, 1);
b(1) = 4 * cos(5 * t(1)) - x0 / (dt^2);
b(2:end-1) = 4 * cos(5 * t(3:end-2));
b(end) = 4 * cos(5 * t(end)) - xT / (dt^2);
x_int = A \ b;
x = [x0; x_int; xT];

A8 = x(t==3);
A9 = t(x == max(x));
A10 = t(x == min(x));
save('A8.dat', 'A8', '-ascii');
save('A9.dat', 'A9', '-ascii');
save('A10.dat', 'A10', '-ascii');
