You need a C compiler to compile the source code in “src” folder, e.g., 
“gcc -o msim *.c -lm”.

Options
-i  Specify a file containing (rooted) trees in Newick format.
-o  Specify a file for output (data and commands).
-c  Base clock rate (c>0). Default: 1.0
-v  Variance of the clock (v≥0). Default: 0.0, i.e., strict clock.
    The relative clock rate on each branch follows the same lognormal 
    distribution with mean 1.0 and variance as the specified value. 
    All characters within a partition share the same rate, while the rates
    are independent (unlinked) among partitions.
-l  Number of binary characters (l≥0). Only variable characters are recorded.
-m  Percentage (0≤%≤1) of missing states for fossils. Extant taxa have
    no missing state.
-n  Number of character partitions.
-a  Parameter (a>0) of symmetric Dirichlet distribution for drawing the
    state frequencies for each character. If not set or set to a negative
    value, the character states have equal frequencies.
-r  When used, each group of binary characters are correlated, followed
    by a parameter (>0) for drawing rates in the Q matrix from a Dirichlet
    distribution. Default: all characters are independent.
-q  Number of correlated characters in each group. Use with option -r. 
    Support 2 or 3. Default: 2
