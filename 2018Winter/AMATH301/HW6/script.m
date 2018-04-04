%%
x=-3:0.1:3;
y=-10:0.2:10;
[X,Y]=meshgrid(x,y);
a = 1; b = 10;
Z=(a-X).^2+b*(Y-X.^2).^2;
surf(X,Y,Z)
%% A1
f = @(X) (a - X(1))^2 + b * (X(2) - X(1)^2)^2;
X1 = [-1; 8];
A1 = f(X1);
save('A1.dat', 'A1', '-ascii');
%% A2
[A2, fval] = fminsearch(f, X1);
save('A2.dat', 'A2', '-ascii');
%% A3, A4
f = @(x1, x2) (1 - x1)^2 + 10 * (x2 - x1^2)^2;
syms x1 x2
fgfun = matlabFunction([diff(f, x1); diff(f, x2)]);
A3 = fgfun(-1, 8);
save('A3.dat', 'A3', '-ascii');
A4 = norm(A3, inf);
save('A4.dat', 'A4', '-ascii');

%% A5, A6
phi = @(t) [-1; 8] - t .* A3;
A5 = phi(0.1);
A6 = f(A5(1), A5(2));
save('A5.dat', 'A5', '-ascii');
save('A6.dat', 'A6', '-ascii');

%% A7, A8
f_phi = @(t) f(subsref(phi(t),struct('type','()','subs',{{1}})), ...
                   subsref(phi(t),struct('type','()','subs',{{2}})));
[t, fval] = fminbnd(f_phi, 0, 0.1);
A7 = t;
A8 = phi(t);
save('A7.dat', 'A7', '-ascii');
save('A8.dat', 'A8', '-ascii');

%% A9, A10
tol = 1e-4;
err = 10 * tol;
guess = [-1; 8];
f = @(x1, x2) (1 - x1)^2 + 10 * (x2 - x1^2)^2;
syms x1 x2
fgfun = matlabFunction([diff(f, x1); diff(f, x2)]);
step = 0;
while err >= tol
    step = step + 1;
    fg = fgfun(guess(1), guess(2));
    phi = @(t) [guess(1) - t * fg(1); guess(2) - t * fg(2)];
    f_phi = @(t) f(subsref(phi(t),struct('type','()','subs',{{1}})), ...
                   subsref(phi(t),struct('type','()','subs',{{2}})));
    [tmin, fvalmin] = fminbnd(f_phi, 0, 0.1);
    guess = phi(tmin);
    err = norm(fg, inf);
end
A9 = guess;
A10 = step - 1;
save('A9.dat', 'A9', '-ascii');
save('A10.dat', 'A10', '-ascii');