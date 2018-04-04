%% A1 A2
a = 5;
x0 = pi / 4;
dt = 0.1;
t = 0;
x = zeros(11, 1);
x(1) = x0;
realx = @(t) 2 * atan(exp(a * t) / (1 + sqrt(2)));
xx = realx(0:dt:1);
xx = xx.';

% Forward Euler Method
for i = 2:11
    t = t + dt;
    x(i) = x(i - 1) + dt * a * sin(x(i - 1));
end
A1 = x(11);
save('A1.dat', 'A1', '-ascii');
A2 = norm(x - xx, inf);
save('A2.dat', 'A2', '-ascii');

%% A3 A4
a = 5;
x0 = pi / 4;
dt = 0.01;
points = 1 / dt;
t = 0;
x = zeros(points, 1);
x(1) = x0;
realx = @(t) 2 * atan(exp(a * t) / (1 + sqrt(2)));
xx = realx(0:dt:1).';

% Forward Euler Method
for i = 2:points+1
    t = t + dt;
    x(i) = x(i - 1) + dt * a * sin(x(i - 1));
end
A3 = x(end);
save('A3.dat', 'A3', '-ascii');
A4 = norm(x - xx, inf);
save('A4.dat', 'A4', '-ascii');

%% A5
A5 = A2 / A4;
save('A5.dat', 'A5', '-ascii');

%% A6
a = 5;
x0 = pi / 4;
dt = 1;
points = 100 / dt;
t = 0;
x = zeros(points, 1);
x(1) = x0;
xx = realx(0:dt:100).';

% Forward Euler Method
for i = 2:points+1
    t = t + dt;
    x(i) = x(i - 1) + dt * a * sin(x(i - 1));
end
A6 = x(end);
save('A6.dat', 'A6', '-ascii');

%% A7
dt = 1;
a = 5;
points = 100 / dt;
x0 = 3;

for i = 2:points+1
    xk = x(i);
    f = @(xx) xx - a * sin(xx) - xk;
    x(i+1) = fzero(f, x0);
end

A7 = x(end);
save('A7.dat', 'A7', '-ascii');

%% Problem 2
g = -9.8;
L = 2;
n = 0.5;
x0 = 1;
v0 = 0;
a = [0, 1;
     g/L, -n];

dt = 0.05;
points = 10/dt;
x = zeros(points, 1);
v = zeros(points, 1);
x(1) = x0;
v(1) = v0;

%% A8
for i = 2:points+1
    x(i) = x(i - 1) + dt * (a(1, 1) * x(i - 1) + a(1, 2) * v(i - 1));
    v(i) = v(i - 1) + dt * (a(2, 1) * x(i - 1) + a(2, 2) * v(i - 1));                
end

A8 = x(end);
save('A8.dat', 'A8', '-ascii');

%% A9
for i = 2:points+1
    v(i) = (v(i - 1) + dt * g/L * x(i - 1)) / (1 - g/L * dt^2 + n * dt);
    x(i) = x(i - 1) + dt * (a(1, 2) * v(i));
end

A9 = x(end);
save('A9.dat', 'A9', '-ascii');

%% A10 
t = 0:0.05:10;
y0 = [1; 0];

[t, y] = ode45(@(t, y)pend(t, y), t, y0);

A10 = y(:, 1);
A10 = A10(end);
save('A10.dat', 'A10', '-ascii');

function dy = pend(t, y)
    dy(1, 1) = y(2);
    dy(2, 1) = -9.8 / 2 * y(1) - 0.5 * y(2);
end