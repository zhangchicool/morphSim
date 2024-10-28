You need a C compiler to compile the source code in “src” folder, e.g., 
“gcc -o fbdt *.c -lm”.

Options
-i  Specify a file containing (rooted) trees in Newick format.
-o  Specify a file for output (data and commands).
-q  Fossil sampling rate along the tree (psi≥0). Default: 0.0
-p  Extant sampling probability or fraction (0<rho≤1). Default: 1.0
-s  Extant sampling strategy. Specify “rnd” for random sampling,
    or “div” for diversified sampling.
-c  Base clock rate (c>0). Default: 1.0
-v  Variance of the clock (v≥0). The relative clock rate on each branch
    follows the same lognormal distribution with mean 1.0 and variance
    as the specified value. Default: 0.0, i.e., strict clock.
-h  When used, each character has its own evolutionary rate variation,
    i.e., the relative clock rates are independent across branches and
    characters. Otherwise, each branch rate is shared by all characters.
-r  When used, each pair of binary characters are correlated.
    Default: all characters are independent.
-l  Number of binary characters (l≥0). Only variable characters are recorded.
-a  Parameter (a>0) of symmetric Dirichlet distribution for drawing the
    state frequencies for each character. If not set or set to a negative
    value, the character states have equal frequencies.
-m  Percentage (0≤%≤1) of missing states for fossils. Extant taxa have
    no missing state.
