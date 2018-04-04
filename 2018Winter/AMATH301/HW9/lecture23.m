clear all; close all; clc; 

%% Example 1
% First, let's solve the boundary value problem x'' = 0 with x(0) = x0 and
% x(T) = xT.  For no particular reason, we will use 
x0 = 1; 
xT = 5; 
T = 2; 
% Our goal is to approximate x at many t-values between 0 and T.  In
% particular, let's choose dt = 0.1 and approximate x at every t-value in
% 0:0.1:1.  
dt = 0.1;
t = 0:dt:T;
% To match the notation we used in class, define 
N = T/dt;
% This number tells us how many points we have, but a little care is
% required here.  There are N + 1 points in t, which means we ultimately
% want to find N + 1 x-values.  However, we already know the x-values for
% two of the points (the first and last points), so we really only need to
% find N - 1 x-values.  That is, we are interested in finding x-values for
% each time in t = 0.1:0.1:(T-0.1).  (This is just t with the first and
% last entry removed.)  These are called the "interior points" or the
% "interior values".  
% 
% To find these x-values, we need to set up the linear system described in
% the notes.  First, we need an N-1 x N-1 matrix with -2's on the main
% diagonal and 1's immediately above and below the main diagonal.  One way
% to make this matrix is as follows: 
v1 = ones(N-2, 1);
v2 = -2*ones(N-1, 1);
A = diag(v2) + diag(v1, 1) + diag(v1, -1);
% The actual system does not use this matrix, though.  We also need to
% include the 1/dt^2 factor.  
A = (1/dt^2) * A;
% Next, we need the right hand side vector for our linear system.  This
% needs to be an N-1 x 1 column vector, and most of the entries are zero.
% We also need to adjust the first and last entries to account for the
% boundary conditions.  
b = zeros(N-1, 1);
b(1) = -x0 / dt^2;
b(end) = -xT / dt^2;
% Now we can find our x-values by solving the system Ax = b.  
x_int = A\b;
% Notice that there are only N-1 x's here.  We only found x at the interior
% values, not at the endpoints.  This isn't really a problem, since we
% already know x at the endpoints, but it is almost always more convenient
% to have all of the x-values together in one vector.  
x = [x0; x_int; xT];
% Now we can check how we did.  We already know that the true solution is 
x_true = ((xT - x0) / T) * t' + x0;
% (Notice that we used t' instead of t so that x_true would be a column
% vector instead of a row vector.  This isn't strictly necessary, but it
% will save you some headaches later if you make sure that you are
% consistent about columns vs rows.  
% 
% If we plot our solution and the true solution, we will see that we got
% it almost exactly right: 
plot(t, x_true, 'k', t, x, 'r')
% It looks like these two lines are exactly the same.  We can check this by
% calculating the maximum error: 
err = norm(x - x_true, Inf);
% This error is about 10^(-15), which means our answer is essentially
% perfect.  Our approximations will usually be worse than this, but this
% problem is so simple that our approximation is actually exact.  
% 
%% Example 2
% Now let's try a slightly more complicated problem: x'' + x = 0, with
% x(0) = x0 and x(T) = xT.  We will use 
x0 = 0;
xT = 5; 
T = 2;
% The basic setup is the same as before: 
dt = 0.1; 
t = 0:dt:T;
N = T/dt;
% We still need to start with the same matrix as before: 
v1 = ones(N-2, 1);
v2 = -2*ones(N-1, 1);
A = diag(v2) + diag(v1, 1) + diag(v1, -1);
A = (1/dt^2) * A;
% However, because of the "+ x" term in our differential equation, we also
% need to add an N-1 x N-1 identity matrix to A.  
A = A + eye(N-1);
% Since the right hand side of our equation is 0, we still have the same
% vector b: 
b = zeros(N-1, 1);
b(1) = -x0 / dt^2;
b(end) = -xT / dt^2;
% And now we can solve for the interior x-values:
x_int = A\b;
% As before, it is usually more convenient to have all of the x-values, not
% just the interior values, so we have 
x = [x0; x_int; xT];
% We know that the true solution is 
x_true = (xT / sin(T)) * sin(t');
% Let's plot our approximation next to the true solution.  
plot(t, x_true, 'k', t, x, 'r')
% This approximation looks very good.  We can check our error just like
% before with 
err = norm(x - x_true, Inf);
% We get a value of 0.003, which is no longer perfect (because this is a
% more complicated equation), but still fairly small.  If we make our dt
% smaller, then we can get better error.  For instance, we can reduce dt by
% a factor of 10: 
dt = 0.01;
t = 0:dt:T;
N = T/dt;

v1 = ones(N-2, 1);
v2 = -2*ones(N-1, 1);
A = diag(v2) + diag(v1, 1) + diag(v1, -1);
A = (1/dt^2) * A;

A = A + eye(N-1);

b = zeros(N-1, 1);
b(1) = -x0 / dt^2;
b(end) = -xT / dt^2;

x_int = A\b;
x = [x0; x_int; xT];

x_true = (xT / sin(T)) * sin(t');

err2 = norm(x - x_true, Inf);
% This error is substantially smaller.  In fact, if we divide the two
% errors
ratio = err / err2;
% we can see that this is 100 times better.  This tells us that we are
% using a second order method, because we reduced dt by a factor of 10 and
% reduced the error by a factor of 10^2 = 100.  