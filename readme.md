This repo contains solutions for different problems from [Project Euler](https://projecteuler.net/archives)

## Mission and origin

I started playing with Project Euler by randomly picking problems and after solving first few I was surprised that most of them had fairly straightforward SQL solution. My path started with [67](https://projecteuler.net/problem=67), [92](https://projecteuler.net/problem=92), [205](https://projecteuler.net/problem=205) etc.

This is how the idea **Create a repo with SQL solutions** was born.

Another reason is that I want to demonstrate the power of SQL language.
SQL is a **declarative** language to work with data and it is quite limited comparing to pure **functional** languages or **imperative** languages but nevertheless SQL can be used to solve wide range of problems.

I decided to use Postgres (PG) dialect however if some problems can be solved only with Oracle specific features (like `model clause` or `match_recognize`) then I might also publish Oracle solution. For additional details about Oracle solutions see the next section.

All SQL solutions are **pure SQL** which means I did not write any procedural code or created types, functions, etc. Once again - this is to show what can be done strictly in **declarative** way.

In some cases I also included python solutions... Well, ok, I must confess - for some problems I had to come up with python solution first before producing a SQL code. :sunglasses:

## Oracle specific solutions

There was one problem ([Poker Hands](https://projecteuler.net/problem=54)) where `match_recognize` looks as more or less natural solution. Alternatively this can be solved in SQL with multiple subqueries and window functions but that would look much more cumbersome than `match_recognize` solution.

A few times I used `model clause` but that does not necessarily mean that this is the only possible SQL solution.
* Solution for [Problem 5](https://projecteuler.net/problem=5) shows how we can utilize `model` to work with auxiliary array-like structures.
* Solution for [Problem 11](https://projecteuler.net/problem=11) shows how `model` can help to avoid joins.
* Solution for [Problem 81](https://projecteuler.net/problem=81) shows how we can traverse matrix with `model` (see also PG solution for comparison).
* Solutions for [Problem 116](https://projecteuler.net/problem=116) and [Problem 117](https://projecteuler.net/problem=117) are really elegant (imho) implementations with `model` of dynamic programming (DP) algorithms but recursive CTE can be used instead - see PG solution for Problem 117.
* Solution for [Problem 121](https://projecteuler.net/problem=121) is yet another DP algorithm implemented in SQL. In this case algorithm is implemented with `iterate` + `for-loop` in rules and uses an array-like structure constructed on a previous iteration so CTE alternative is not that straightforward here - see **Advanced SQL tricks**.

The last problem to highlight is [Problem 17](https://projecteuler.net/problem=17) - classical task to **spell the number**. For this one I included both Oracle and PG solutions to compare built-in features. Another problem where I found interesting to compare Oracle and PG solutions is [Problem 229](https://projecteuler.net/problem=229) - but the focus here is on performance comparison.

## Typical SQL tricks

* If we want to generate rows we can use built-in function `generate_series` in PG.
In Oracle that is usually done with `connect by level <= ...`.

* If we want to perform iterative-like computations then we can use recursive CTE (also known as recursive subquery factoring in Oracle).
Iterative-like means that on i<sup>th</sup> step we might want to use results from i-1<sup>th</sup> step. Recursive CTE is necessary here because `generate_series` or `connect by level` does not allow to access previous row during generation.

## Advanced SQL tricks

Neither in Oracle nor in PG recursive CTE allows using `group by` in recursive member but still recursive CTE is slightly more powerful in PG.

* CTE name in recursive member in PG can appear in inline view (Oracle does not allow this).

* PG allows using `distinct` in recursive member (hence we can apply silly workaround for `group by` - analytic (window) functions + `distinct`). In Oracle we still can do (kind of) grouping in recursive member by using window functions and taking first row from each group on the next step (this requires additional column for row_number). *Please never ever use in real life tricks with window functions as an alternative to `group by`*. :wink:

For an example of recursive CTE with `distinct` in recursive member check the solution for [Problem 92](https://projecteuler.net/problem=92) or perhaps [Problem 171](https://projecteuler.net/problem=171) which is very similar. There are a few more solutions with this trick in the repo. For example, for [Problem 14](https://projecteuler.net/problem=14),  [Problem 81](https://projecteuler.net/problem=81), [Problem 164](https://projecteuler.net/problem=164), [Problem 172](https://projecteuler.net/problem=172), etc.

Solution for [Problem 82](https://projecteuler.net/problem=82) is a great example of advanced capabilities in recursive CTE in PG. It requires both `distinct` and inline view in recursive member to get the job done.

At first glance there might be an impression that recursive CTE can be used as an alternative to a single for-loop in imperative language. In reality id does not matter how many nested loops logic requires in imperative style. In general case that can be re-written into a single for-loop and eventually implemented with recursive CTE. For a specific example - see [Problem 173](https://projecteuler.net/problem=173) and its implementation with python. As well as [Problem 3](https://projecteuler.net/problem=3) where we do prime factorization in SQL.

The last but not least detail is that recursive CTE allows accessing only recordset generated on a previous iteration. So if there is a need to access something from earlier iterations then you might need to either duplicate that data again and again on every iteration or consider using `model`. The great example of this is Oracle and PG solutions for [Problem 117](https://projecteuler.net/problem=117).

If there is a need to re-use some additional data structures which keep changing during iterations (arrays in the simplest case) then recursive CTE is not a reasonable option. In some cases `model` might help because it operates on a single recordset - unlike recursive CTE which adds new rows to the recordset on each step. For an example of such algorithm please check solution for [Problem 121](https://projecteuler.net/problem=121).

Some advanced applications of `model` you can find in my book [Oracle SQL Revealed](https://link.springer.com/book/10.1007/978-1-4842-3372-6). For example *bisection method* in Chapter 7 or *Longest Increasing Subsequence* in Chapter 12. Please note that I'm not saying that SQL is the right tool for such tasks but the idea here is to highlight the capabilities which might be useful in some special cases of SQL processing.

## Disclaimer and final details

**Do not take this very seriously.**

If something **can** be implemented with SQL it does not necessarily mean it **should** be implemented with SQL.

There is an amazing portal [Rosetta Code](https://rosettacode.org/wiki/Rosetta_Code). It provides solution for various challenges in different languages. Those challenges cover a lot of Project Euler problems - like [Iterated digits squaring](https://rosettacode.org/wiki/Iterated_digits_squaring) (the same as [Problem 92](https://projecteuler.net/problem=92)) or [Maximum triangle path sum](https://rosettacode.org/wiki/Maximum_triangle_path_sum) (the same as [Problem 67](https://projecteuler.net/problem=67)).

Noone in their right mind would publish SQL solutions for those problems there. But the good news is – you can find them in this repo. :grin:

For a lot of Euler Problems there are alternative versions for on [HakerRank](https://www.hackerrank.com/contests/projecteuler/challenges) which require to handle "extended" input.
For example [Problem 94](https://www.hackerrank.com/contests/projecteuler/challenges/euler094/problem).

So there is a probability that some solutions in this repo are not fast enough to pass all test cases in hakerrank but that was not a goal.
Original priorities were *readability* (or in the best case *elegance* in SQL) and *reasonable performance* to get the answer for a given input.

As Donald Knuth used to say **"Premature optimization is the root of all evil"**.

A number of python solutions rely on `euler_lib.py` which has a couple of frequently used routines - is_prime/get_prime_factors. You can find equivalents for those in sympy -
`from sympy import factorint, isprime`.

## Did I really try to solve everything with SQL?

No.

Examples where it could be done in SQL but I did not publish SQL solution include:
* One liners. Problems 15, 20, 53, 56, 69, 493, etc. This is nice an beautiful in python but would look a bit awkward in SQL with many lines of code.
* There are also a number of solutions which are trivial in python but would look quite cumbersome in SQL.
    * related to primes 46, 47, 49 
    * others 93, etc

There are still a few SQL solutions which use table with primes numbers. It is generated with script `eubler_lib.sql` however it could also be generated with `euler_10_brute_force.sql` (even faster :smile:). 

Some solutions have "brute_force" suffix in the file name. Usually those solutions are accompanied by not brute force solutions but not always. Also if file name does not have "brute_force" suffix that does not necessarily mean that solution is not brute force. :wink: