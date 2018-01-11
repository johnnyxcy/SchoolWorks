
Quiz 3

a) In class we have seen that the E[] and V[] (i.e., *distribution* mean and variance) 
of the binomial distribution both vary linearly with the n parameter of the distribution. 
In the prelab, we confirmed that mathematical result by simulation, i.e., we generated 
data from the binomial distribution, and then looked at how the *sample* mean and 
*sample* variance depend on the sample size n. Here, write code to simulate how
the mean and standard deviation (NOT variance) of the exponential distribution vary
with its parameter lambda; consider integer lambda values from 1 to 100.
(Note: The lambda parameter of the exponential is a real number, not necessarily integer;
but we look only at integer values because it makes the code simpler. For more advanced
students, on your own time, try this excercise with real lambda values.)

# Soln

n.trials = 1000
lambda = c(1:100)
sample.mean = numeric(100)
sample.std.dev = numeric(100)
for (i in lambda){
  x = rexp(n.trials, i)
  sample.mean[i] = mean(x)
  sample.std.dev[i] = sd(x)
}
plot(lambda, sample.mean, cex = 0.5 )
points(lambda, sample.std.dev, col = 2, cex = 0.5)

lines(lambda,1/lambda)
# The last line confirms the 1/lambda behaviour of both. Do note that the red and black
# circles do not overlap, i.e., the sample mean and sample std dev, for each value of
# lambda, are not necessarily equal; it is the distribution mean and distribution
# std dev which are equal.

'b) In the prelab you also learned about qqplots. As a special case of qqplots, you learned
about qqnorm() which plots quantiles of data on the y-axis, and quantiles of the
standard normal distribution on the x-axis. You also learned about qqmath() which
allows you to plot quantiles of *any* distribution on the x-axis. This is useful, because
if you suspect your data come from, say, an exponential distribution, then you should
put quantiles of the exponential distribution on the x-axis; if the resulting qqplot
looks linear, then you have confirmed that your data come from an exponential distribution.
Now, if you look at the prelab, where we learned how to make a qqplot "by hand," you
will see that we can revise that code easily to put quantiles of any distribution
on the x-axis; in other words, we don't need qqmath(). Here, write code to draw a
sample of size 1000 from an exponential distribution with parameter 2, and make the
qqplot with quantiles of that distribution on the x-axis.

# Soln

x = rexp(1000,2)
n = length(x)
X = seq(.5/n, 1-.5/n, length=n)
Q = qexp(X, 2)
plot(Q, sort(x))
# The linear behavior confirms that the data came from an exponential distribution.

# Moral: a) One can use simulations to study the behavior of E[] and V[] of *any*
distribution as a fucntion of its parameters. b) One can use qqplots to test whether
a data set comes from *any* distribution, e.g., normal, exponential, even binomial.

