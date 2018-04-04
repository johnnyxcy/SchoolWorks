%% Load the data
load('salmon.mat');

% Problem 1
%% A1 A2 A3
p1 = polyfit(t, salmon, 1);
A1 = p1(1);

A2 = polyval(p1, 80);
pred = polyval(p1, t);
A3 = sqrt(mean((salmon - pred).^2));  % Root Mean Squared Error

save('A1.dat', 'A1', '-ascii');
save('A2.dat', 'A2', '-ascii');
save('A3.dat', 'A3', '-ascii');

scatter(t,salmon)
hold on
plot(t,pred)
xlabel('Population of state')
ylabel('Fatal traffic accidents per state')
title('Linear Regression Relation Between Accidents & Population')
grid on
hold off

%% A4 A5 A6
p2 = polyfit(t, salmon, 2);
A4 = polyval(p2, 80);
p5 = polyfit(t, salmon, 5);
A5 = polyval(p5, 80);
p20 = polyfit(t, salmon, 20);
A6 = polyval(p20, 80);
save('A4.dat', 'A4', '-ascii');
save('A5.dat', 'A5', '-ascii');
save('A6.dat', 'A6', '-ascii');
%%
% y1 = polyval(p20,t);
% figure
% plot(t,salmon,'o')
% hold on
% plot(t,y1)
% hold off
%% A7 A8
ylog = log(salmon);
p1log = polyfit(t, ylog, 1);
r = p1log(1);
N0 = exp(p1log(2));
A7 = [N0, r];
pred = N0 * exp(t * r);

figure
plot(t,salmon,'o')
hold on
plot(t,pred)
hold off
A8 = N0 * exp(80 * r);
save('A7.dat', 'A7', '-ascii');
save('A8.dat', 'A8', '-ascii');

%% A9
f = @(m, t0)sqrt(mean((salmon - exp(m(1) .* t0.^2 + m(2) .* t0 + m(3))).^2));
fun = @(m)f(m, t);
m0 = [0.001, -0.01, 10];
m1 = fminsearch(fun, m0);
tt = 80;
A9 = exp(m1(1) .* tt.^2 + m1(2) .* tt + m1(3));
save('A9.dat', 'A9', '-ascii');
% figure
% plot(t,salmon,'o')
% hold on
% ypred =  exp(m1(1) .* t.^2 + m1(2) .* t + m1(3));
% plot(t, ypred)
% hold off
%% A10
A10 = spline(t, salmon, 80);
save('A10.dat', 'A10', '-ascii');