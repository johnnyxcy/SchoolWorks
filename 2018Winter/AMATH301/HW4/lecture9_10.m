clear all; close all; clc; 

%% Jacobi Method
% Here we will try to solve the equation Ax = b using a matrix splitting
% method.  Recall that a matrix splitting method involves rewriting the
% matrix A as A = P + T, then using the equation 
% 
% x_k = -P^(-1)Tx_(k-1) + P^(-1)b
% 
% to iteratively improve our guess for the solution x.  All matrix
% splitting methods follow the same form.  The only difference is how we
% choose P.  We will start with the simplest method: Choose P to be the
% diagonal entries of A.  This choice of P is called the Jacobi method (or
% Jacobi iteration).  
% 
% As an example, we will use 
A = [6 1 1; 1 8 2; 2 3 9];
b = [1; 2; 3]; 
% To implement the Jacobi method, we will make P be the diagonal matrix
P = [6 0 0; 0 8 0; 0 0 9];
% and then T will be the remaining entries of A: 
T = A - P;
% Note that we have used a sensible choice for P because it is easy to
% solve a diagonal system, so P\(some_vector) will be fast.  
% 
% We can now implement the iterative method described in class.  To start,
% we need to make some initial guess.  We already showed in class that the
% initial guess does not affect the convergence of this method, so it does
% not particularly matter what we choose here.  It is common to choose a
% random vector in situations like this, but we will choose a vector of all
% ones for no particular reason.  
x0 = [1; 1; 1];
% We can now use the equation from line 8 to update our guess.  It is
% usually more convenient to rewrite our equation a bit first: 
% 
% x_k = P^(-1)(-T*x_(k-1) + b)
% 
% We therefore have 
x1 = P\(-T*x0 + b)
% We could continue this process indefinitely.  For illustrative purposes,
% we will write out the first few guesses: 
x2 = P\(-T*x1 + b)
x3 = P\(-T*x2 + b)
x4 = P\(-T*x3 + b)
x5 = P\(-T*x4 + b)
x6 = P\(-T*x5 + b)
% These guesses don't appear to be going off to infinity.  Instead, they
% appear to be approaching some fixed vector.  Judging from the first few
% guesses, it looks like we are approaching x ~ [0.09; 0.17; 0.25].  We can
% check by calculating the true solution (well, within some rounding error)
% with Gaussian elimination.  We find 
x = A\b
% It looks like are indeed approaching the correct solution.  We can also
% confirm this by checking the eigenvalues of our iteration matrix M: 
M = -P\T;
lambdas = abs(eig(M))
% Since all of these eigenvalues are smaller than 1 (indeed, the largest is
% only 0.42) we know that the Jacobi method will converge to the true
% solution.  In fact, we know that the error will go down by a factor of
% approximately 0.42 after every step, so this method should converge quite
% quickly.  
% 
% It should be clear from lines 42-46 that this is the ideal place to use a
% loop in our code.  We want to repeatedly use the update equation (from
% line 36).  Since we don't know how many steps we need, this is actually a
% great place for a while loop, but we will start with a for loop because
% they tend to be easier to understand.  We know that we need code that
% looks something like this: 
% 
% for k = something
%     x_k = P\(-T*x_(k-1) + b);
% end
% 
% For the moment, we will just have our loop repeat ten times, just so we
% can run our code without an error.  That is, we will replace "something"
% with "1:10".  As a (very rough) first pass, we can try 
x0 = [1; 1; 1]; 
for k = 1:10
    x1 = P\(-T*x0 + b);
end
% This doesn't really do what we want, since it just calculates the first
% guess over and over again.  We need to keep changing the values of x0 and
% x1 as we go.  There are several ways to do this, but we will solve our
% problem by keeping track of all of our guesses.  (We really only need to
% remember the last two at any given time, but this way we'll be able to
% look at all of the guesses once we are done.)  We will do this by storing
% our guesses in a large matrix.  In particular, we will make a matrix X
% where every column is supposed to represent one of our guesses.  Since
% our loop needs to use the initial guess, we will need to put this initial
% guess in our matrix.  
% 
% Remember that we always want to initialize our matrices (that is, create
% an "empty" matrix of the right size before we start our loop).  However,
% we don't know how large our matrix is supposed to be because we don't
% know how many guesses we need.  There is not really an ideal way around
% this problem, but we will start by making space for ten columns (because
% our loop repeats ten times).  
X = zeros(3, 10);
% We now want to put our initial guess into the first column of X.  
X(:, 1) = x0; 
% Notice that the numbers here don't seem to match.  The guess x0 goes in
% column 1.  This is a common stumbling block in numerical programming.  In
% math it makes perfect sense to start a variable (like k) at 0 or to
% increment it by some value other than 1.  (For instance, we might need to
% keep track of time in units of 0.01 seconds.)  However, Matlab always
% counts columns in rows with whole numbers and always starts at 1.
% Therefore, we think of our initial guess as x0 but we have to store it in
% column 1.  This means that the next guess will be x1, but it will be
% stored in column 2.  Likewise, x2 will be stored in column 3 and so on.
% There is nothing wrong with this, but you have to keep track of it
% mentally (or through comments) because Matlab doesn't know the
% difference.  
% 
% We are now in a position to fix our loop.  At every step, we want to
% update the next guess using our last guess.  Turning this into code, we
% have 
X = zeros(3, 10);
X(:, 1) = x0; 
for k = 1:10
    X(:, k+1) = P\(-T*X(:, k) + b);
end
% If you look at the matrix X, you should see that the columns are now
% filled with our guesses (and the first 7 columns should match our old
% answers).  You should also notice something a little bit odd: We made X
% with ten columns, but it now has eleven.  This is because we forgot about
% the initial guess when we made our matrix.  We really needed one column
% for the initial guess plus ten more for our later guesses.  Fortunately,
% Matlab automatically resizes matrices whenever it needs to add another
% column.  It's not ideal to rely on this behavior, because resizing a
% matrix is quite slow.  However, there is not a particularly practical way
% around this because we don't know beforehand how many columns we might
% need.  
% 
% It is also worth noting that our final guess (the last column of X) is
% not all that close to the correct answer.  That means that we didn't
% repeat our loop enough times.  The easy way to fix this is just to change
% the first line of our loop: 
X = zeros(3, 10); 
X(:, 1) = x0; 
for k = 1:100
    X(:, k+1) = P\(-T*X(:, k) + b); 
end
% Now it looks like our method converged successfully, since the columns of
% X are not changing (in all fifteen decimal places).  In fact, it looks
% like our method found the correct answer in much less than 100 steps.
% This means that we wasted time by doing many extra steps.  We can fix
% this by using the stopping criterion described in class.  We will stop if
% the difference between our last two guesses gets small enough.  In this
% case, I have arbitrarilly decided that "small enough" means that none of
% the entries change by more than 10^(-10).  
tolerance = 1e-10; 
X = zeros(3, 10); 
X(:, 1) = x0; 
for k = 1:100
    X(:, k+1) = P\(-T*X(:, k) + b); 
    if norm(X(:, k+1) - X(:, k), Inf) < tolerance
        break
    end
end
% Remember that norm(x, Inf) gives the "magnitude" of the vector x.  It is
% equivalent to writing max(abs(x)).  
% 
% As mentioned earlier, this is probably an ideal case for a while loop,
% since we don't know beforehand how many iterations we will need.  We
% could implement the Jacobi method in a while loop as follows: 
tolerance = 1e-10; 
X = zeros(3, 10); 
X(:, 1) = x0; 
k = 0; 
err = 1; 
while err > tolerance
    k = k + 1;
    X(:, k+1) = P\(-T*X(:, k) + b);
    err = norm(X(:, k+1) - X(:, k), Inf);
end
% Notice that we have to keep track of the column number k ourselves, since
% the while loop does not do it for us.  We also have to give some initial
% value for err so that the while loop will start.  It doesn't matter what
% we choose for the initial value, as long as it is larger than the
% tolerance.  
% 
% As a general rule, it is wise to guard against infinite loops when we
% use a while loop.  In this case, we know that our loop will stop after
% about thirty steps, but it is easy to make a mistake and end up with an
% infinite loop instead.  To stop this, we usually give some maximum number
% of steps and stop the loop if we go over that number.  For instance, we
% could write 
tolerance = 1e-10; 
X = zeros(3, 10); 
X(:, 1) = x0; 
k = 0; 
err = 1; 
max_steps = 100;
while err > tolerance && k < max_steps
    k = k + 1; 
    X(:, k+1) = P\(-T*X(:, k) + b); 
    err = norm(X(:, k+1) - X(:, k), Inf);
end
% At this point, our code does exactly the same thing as a for loop, so it
% is really just a matter of taste as to which version you use.  

%% Gauss-Seidel Method
% Other matrix splitting methods are almost exactly the same as the Jacobi
% method.  The only difference is which P we choose.  In the Jacobi method,
% we choose P to be the diagonal entries of A.  In the Gauss-Seidel method,
% we choose P to be the diagonal entries of A and all the entries below the
% diagonal.  That is, 
P = [6 0 0; 1 8 0; 2 3 9];
% After this, all of our code is exactly the same.  
T = A - P; 
M = -P\T; 
lambdas = abs(eig(M))
% Since the eigenvalues of M are all less than 1, this method will
% converge.  
tolerance = 1e-10; 
X = zeros(3, 10); 
X(:, 1) = x0; 
for k = 1:100
    X(:, k+1) = P\(-T*X(:, k) + b); 
    if norm(X(:, k+1) - X(:, k), Inf) < tolerance
        break
    end
end
% Notice that this method converged much more quickly.  We already knew
% this would happen, because the largest eigenvalue of this M is smaller 
% than the largest eigenvalue of the M from the Jacobi method.  (Of course,
% since P is different in each method, T and M are also different, so M
% will have different eigenvalues.)  This is actually fairly common.  If
% both Gauss-Seidel and the Jacobi method converge, then very often the
% Gauss-Seidel method is roughly twice as fast.  However, it is possible to
% come up with examples where either method converges and the other does
% not or where both converge but the Jacobi method is faster.  In general,
% if you want to find the fastest method there is no substitute for
% checking the eigenvalues of M.  