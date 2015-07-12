## Timing attack

Construct the DiffieHellman key exchange algorithm.

## Objective
- Create a test environment to see whether a timing attack is feasible
- Analyze and document your findings
- Compare your results with those of your colleagues
- Write a constant-time string comparison function

## Definition

The following program analyzes necessary time to compare different strings and time needed for it.

We check the following cases:
- Compare two strings with == where the characters are the same until late in the string.
- Compare two strings with == where the characters differ early in the string.
- Same as 1 but with a ruby implementation of secure compare.
- Same as 2 but with a ruby implementation of secure compare.

We do 1000 tests of each case.
Due to the fact that the difference is not visible at small sizes, I implemented the following example that uses the ’TrurlAndKlapaucius’ repeated 1000 times.
Ruby’s benchmark module rounds off numbers quite agressively, so to see anything for the == cases, refer to the ’real’ measurement.
In the first case, you should observe an order of magnitude or greater difference in using just ==, while you get measurements for both secure compares that are the same to within the margin of error. In the second case, the == are much closer, but should still be distinguishable.

You’ll also notice that secure compare is *much* slower and not super consistent, especially the pure Ruby one. This is the price you pay for not having a language-level secure byte comparison primitive.

## Conclusion

After making this laboratory work I learned more about timing attacks, and perform different comparision on strings to see the diference between recorded times needed to perform the ’comp’ operation. Also implemented constant-time string comparison and saw why it is necessary. Analyzing the preliminary results, the time received for short strings (usually used for passwords and normal text) is too small and random to draw some conclusion about the used information, but if we use big strings the difference in time is visible for unsave comparision of strings.
