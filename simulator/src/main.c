#include "tree.h"
#include "rate.h"
#include "seqs.h"
#include "utils.h"
#include "output.h"
#include <unistd.h>

void helpMsg(void);

int main (int argc, char *argv[]) {
    FILE   *input =NULL, *output =NULL;
    pPhyTree tTree;
    double clRate = 1.0, clVar = 0.0;
    int    c, nChar = -1;
    int    nPart = 1;
    int    corr = NO, cSize = 2;
    double alphaD = -1.;  // negative value for equal frequencies
    double alphaG = 1.0;  // gamma shape for generating GTR rates
    double missing = 0.0;

    /* parse arguments */
    while ((c = getopt(argc, argv, "i:o:c:v:l:m:n:a:r:q:")) != -1) {
        switch(c) {
            case 'i':  // input
                input  = fopen(optarg, "r");
                break;
            case 'o':  // output
                output = fopen(optarg, "w");
                break;
            case 'c':  // base clock rate
                clRate = atof(optarg);
                break;
            case 'v':  // clock variance
                clVar = atof(optarg);
                break;
            case 'l':  // number of characters in total
                nChar = atoi(optarg);
                break;
            case 'm':  // percentage of missing characters
                missing = atof(optarg);
                break;
            case 'n':  // number of partitions
                nPart = atoi(optarg);
                break;
            case 'a':  // Dirichlet alpha for state freq
                alphaD = atof(optarg);
                break;
            case 'r':  // character correlation
                corr = YES;
                alphaG = atof(optarg);
                break;
            case 'q':  // correlated group size (2 or 3)
                cSize = atoi(optarg);
                break;
        }
    }

    if (input == NULL || output == NULL) {
        printf("Unable to open input/output file!\n");
        helpMsg();
        exit(1);
    }
    // TODO: check the inputs are reasonable

    // printf("seed: %u\n", z_rndu);
    setSeed(123456789);

    while ((c = fgetc(input)) != EOF) {
        if (isspace(c))  continue;
        ungetc(c, input);

        /* read in rooted time tree */
        tTree = readTree(input);
        // writeTree(stdout, tTree);
        showTreeInfo(stdout, tTree);

        if (nChar > 0) {
            /* simulate clock rates on tree */
            simulateRates(tTree, nChar, nPart, clRate, clVar);
            
            /* simulate character data */
            if (corr == NO)
                simulateData(tTree, nChar, alphaD);
            else
                simulateData_corr(tTree, nChar, cSize, alphaD, alphaG);
        }
        
        /* write files */
        writeMrBayesCmd(output, tTree, missing);
        
        /* free memory of trees */
        freeTree(tTree);
    }

    fclose(input);
    fclose(output);
    
    return 0;
}

void helpMsg(void) {
    printf("Compile: gcc -o msim *.c -lm\n");
    printf("Usage: ./msim -i <input> -o <output> -c <rate> -v <var>\n");
    printf("              -l <nchar> -m <missing> -n <npart>\n");
}
