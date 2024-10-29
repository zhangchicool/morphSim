#include "tree.h"
#include "sample.h"
#include "rate.h"
#include "seqs.h"
#include "utils.h"
#include "output.h"
#include <unistd.h>

void helpMsg(void);

int main (int argc, char *argv[]) {
    FILE   *input =NULL, *output =NULL;
    pPhyTree evoTree, fbdTree;
    double psi = 0.0;    // fossil sampling rate   default: no fossil
    double rho = 1.0;    // extant sampling prob   default: complete
    char   *ss = "info";
    double clRate = 1.0, clVar = 0.0;
    int    c, nChar = -1, clHetero = NO, corr = NO;
    double alphaD = -1.;  // negative value for equal frequencies
    double alphaG = 1.0;  // gamma shape for generating GTR rates
    double missing = 0.0; // percentage of missing states

    /* parse arguments */
    while ((c = getopt(argc, argv, "i:o:q:p:s:c:hv:r:l:a:m:")) != -1) {
        switch(c) {
            case 'i':  // input
                input  = fopen(optarg, "r");
                break;
            case 'o':  // output
                output = fopen(optarg, "w");
                break;
            case 'q':  // fossil sampling rate
                psi = atof(optarg);
                break;
            case 'p':  // extant sampling prob
                rho = atof(optarg);
                break;
            case 's':  // sampling strategy
                ss = optarg;
                break;
            case 'c':  // base clock rate
                clRate = atof(optarg);
                break;
            case 'v':  // clock variance
                clVar = atof(optarg);
                break;
            case 'h':  // clock heterogeneity
                clHetero = YES;
                break;
            case 'r':  // character correlation
                corr = YES;
                alphaG = atof(optarg);
                break;
            case 'l':  // number of characters
                nChar = atoi(optarg);
                break;
            case 'a':  // symmetric Dirichlet alpha
                alphaD = atof(optarg);
                break;
            case 'm':  // % missing characters
                missing = atof(optarg);
                break;
        }
    }

    if (input == NULL || output == NULL) {
        printf("Unable to open input/output file!\n");
        helpMsg();
        exit(1);
    }

    printf("seed: %u\n", z_rndu);
    // setSeed(-1);

    while ((c = fgetc(input)) != EOF) {
        if (isspace(c))  continue;
        ungetc(c, input);

        /* read in rooted bd tree */
        evoTree = readTree(input);
        // writeTree(stdout, evoTree);

        /* sample fossils on tree */
        if (strcmp(ss, "info") == 0)
            fbdTree = evoTree;
        else
            fbdTree = sampleFossilAndExtant(evoTree, psi, rho, ss);
        showTreeInfo(stdout, fbdTree);

        /* simulate clock rates on tree */
        if (nChar > 0 && clHetero == YES)
            simulateRates(fbdTree, nChar, clRate, clVar);
        else
            simulateRates(fbdTree, 1, clRate, clVar);
        
        /* simulate character data */
        if (nChar > 0 && corr == NO)
            simulateData(fbdTree, nChar, clHetero, alphaD);
        else if (nChar > 0 && corr == YES)
            simulateData_corr(fbdTree, nChar, clHetero, alphaD, alphaG);

        /* write files */
        writeMrBayesCmd(output, fbdTree, missing);
        
        /* free memory of trees */
        freeTree(evoTree);
        if (strcmp(ss, "info") != 0)
            freeTree(fbdTree);
    }

    fclose(input);
    fclose(output);
    
    return 0;
}

void helpMsg(void) {
    printf("Compile: gcc -o fbdt *.c -lm\n");
    printf("Usage: ./fbdt -i <input> -o <output> -q <psi> -p <rho> -s <strat>\n");
    printf("              -c <rate> [-h] -v <var> -l <nchars> -a <alpha>\n");
}
