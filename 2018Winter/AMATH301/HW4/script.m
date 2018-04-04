% Problem 1
A = 2*diag(ones(100,1),0) - diag(ones(99,1),1) - diag(ones(99,1),-1);
ro = zeros(100,1);
for j = 1:100
    ro(j,:) = 2*(1-cos(56*pi/101))*sin((56*pi*j/101));
end

D = diag(diag(A));
R = A - D;

%% A1
M = inv(D)*(D-A);
A1 = max(abs(eig(M)));
save('A1.dat', 'A1', '-ascii');

%% A2, A3
guess = ones(100,1);

tol = 1e-4;
error = 2 * tol;
new = guess;
iteration = 1;
for i = 1:100000
    iteration = iteration + 1;
    v_new = D\(ro-R*guess);
    guess = v_new;
    new(:,i+1) = v_new;
    error = norm(new(:,iteration)-new(:,iteration-1),Inf);
    if error <= tol
        break;
    end
end
A2 = iteration - 1;
real = A \ ro;
A3 = norm(real - guess, inf);
save('A2.dat', 'A2', '-ascii');
save('A3.dat', 'A3', '-ascii');

%% A4
S = tril(A);
T = triu(A) - D;
M = inv(S) * - T;
A4 = max(abs(eig(M)));
save('A4.dat','A4','-ascii');

%% A5, A6
x0 = ones(100,1);
X(:,1) = x0;
iterations = 1;
error = 2*tol;
while error > tol
    iterations = iterations + 1;
    X(:,iterations) = S \ (ro-T*X(:,iterations-1));
    error = norm(A*X(:,iterations)-ro,Inf);
end
A5 = iterations - 1;
save('A5.dat','A5','-ascii');
A6 = norm(real - X(:, end), inf);
save('A6.dat','A6','-ascii');

%% A7
L = tril(A) - D;
U = triu(A) - D;
w = 1.5;
M = inv(D+w*L) * (-(w*U+(w-1)*D));
A7 = max(abs(eig(M)));
save('A7.dat','A7','-ascii');

%% A8
eigval = zeros(100, 2);
index = 1;
for w = 1:0.01:1.99
    M = -(D+w*L)\(w*U+(w-1)*D);
    maximum = max(abs(eig(M)));
    eigval(index, :) = [maximum; w];
    index = index + 1;
end
index = find(eigval == min(eigval(:, 1)));
A8 = eigval(index, 2);
save('A8.dat', 'A8', '-ascii');
%% A9
tol = 1e-4;
error = 2 * tol;
iterations = 1;
guess = ones(100,1);
phi = guess;
while error > tol
    iterations = iterations + 1;
    M_x = inv(D+A8*L) * (-(A8*U+(A8-1)*D));
    C_x = inv(D+A8*L) * (A8*ro);
    phi = M_x * phi + C_x;
    error = norm(A*phi-ro,Inf);
end
A9 = iterations;
A10 = norm(real - phi, inf);
save('A9.dat', 'A9', '-ascii');
save('A10.dat', 'A10', '-ascii');