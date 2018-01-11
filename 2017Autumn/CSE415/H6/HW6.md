# CSE 415 Assignment 6: Bayes' Rule and Markov Deicision
> Chongyi Xu, 1541273
## Problems
1. Should Anyone Panic?

   (a) **_Solution._** Let $D$ be the event that the Lucy has *HPAI* and $E$ the event that test result is positive. Then the probability will be

   $$
   \begin{aligned}
   P(D|E)   &= \frac{P(D\cap E)}{P(E)} \\
            &= \frac{P(E|D)P(D)}{P(E|D)P(D) + P(E|D^c)P(D^c)} \\
   \end{aligned}
   $$
    We have the probability table
    |               | True(Effected)| False(Not Effected)|
    | ------------- |:-------------:| ------:|
    | Positive      | 0.95          | 0.05   |
    | Negative      | 0             | 1      |
    $$
    \begin{aligned}
    P(D|E)  &= \frac{P(E|D)P(D)}{P(E|D)P(D) + P(E|D^c)P(D^c)} \\
            &= \frac{(0.95)(\frac{1}{1000})}{(0.95)(\frac{1}{1000}) + (0.05)(\frac{999}{1000})} \\
            &\approx 0.01866 \\
            &= 1.866\% \\
    \end{aligned}
    $$
    So the updated probability that Lucy has *HPAI* is 1.866\%

    (b) **_Solution._** Similiarly, let $D$ be the event that the Lucy has *HPAI* and $E$ the event that test result is positive. Then the probability will be

   $$
   \begin{aligned}
   P(D|E)   &= \frac{P(D\cap E)}{P(E)} \\
            &= \frac{P(E|D)P(D)}{P(E|D)P(D) + P(E|D^c)P(D^c)} \\
            &= \frac{(0.95)(\frac{1}{80})}{(0.95)(\frac{1}{80}) + (0.05)(\frac{79}{80})} \\
            &\approx 0.1939 \\
            &= 19.39\% \\
    \end{aligned}
    $$
    So the updated probability that James has *HPAI* is 19.39\%

    As the result, James should seek for assistance since he has a probability of ~19% that he has *HPAI* meanwhile Lucy could be not panic for having the decease. 

2. The Mecha-Mouse at the Hostel for Travelling Droids

    i. **_Answer._** The number of different policies that are possible for Mecha-mouse is
    
    $$ 3^4 = 81$$
    where $4$ is the number of rooms $(s)$, and $3$ is the number of possible actions $(a)$ in each room (state).

    ii. **_Answer._** Using the Bellman Equation
    
    $$V_{k+1}^*(s) = max_a \sum_{s^\prime} T(s, a, s^\prime)[R(s, a, s^\prime) + \gamma V_{k}^*(s^\prime)]$$

    Value iterations for six times which means iterating til $k = 6$ from $k = 0$
    |Iteration|Dormitory|Mess Hall|Lavatory|Pantry|Ambushed|Kaput|
    |---------|:-------:|-------:|-----:|--------:|-------:|----:|
    |#1|$3.2$|$6$|$6$|$3.2$|0|0|
    |#2|$6.2$|$7.6$|$7.6$|$6.2$|0|0|
    |#3|$7$|$9.1$|$9.1$|$7$|0|0|
    |#4|$7.75$|$9.5$|$9.5$|$7.75$|0|0|
    |#5|$7.95$|$9.875$|$9.875$|$7.95$|0|0|
    |#6|$8.1375$|$9.975$|$9.975$|$8.1375$|0|0|

    iii. *_Answer:_* The optimal policy I got is 
    |D|L|P|M|A|K|
    |-----|:-----:|---:|---:|---:|---:|
    |$Y$|$X$|$X$|$X$|$*$|$*$|
