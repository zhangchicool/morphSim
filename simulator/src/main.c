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
    int    c, numTree;
    double psi = 0.0;    // fossil sampling rate   default: no fossil
    double rho = 1.0;    // extant sampling prob   default: complete
    char   *ss = "info";
    double clRate = 1.0, clVar = 0.0;
    int    seqLen = -1, clHetero = NO;
    double alpha = -1;   // negative value for Mk

    /* parse arguments */
    while ((c = getopt(argc, argv, "i:o:q:p:s:c:hv:l:a:")) != -1) {
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
            case 'l':  // morphological characters
                seqLen = atoi(optarg);
                break;
            case 'a':  // symmetric Dirichlet alpha
                alpha = atof(optarg);
                break;
        }
    }

    if (input == NULL || output == NULL) {
        printf("Unable to open input/output file!\n");
        helpMsg();
        exit(1);
    }

    // setSeed(-1);
    printf("seed: %u\n", z_rndu);

    numTree = 0;
	while ((c = fgetc(input)) != EOF) {
        if (isspace(c))  continue;
        ungetc(c, input);
        
        /* read in rooted bd tree */
        evoTree = readTree(input);
        // writeTree(stdout, evoTree);
        
        /* sample fossils on tree */
        if (strcmp(ss, "info") == 0) {
            showTreeInfo(output, evoTree);
            fbdTree = evoTree;
        }
        else
            fbdTree = sampleFossilAndExtant(evoTree, psi, rho, ss);
        
        /* simulate clock rates on tree */
        if (seqLen > 0 && clHetero == YES)
            simulateRates(fbdTree, seqLen, clRate, clVar);
        else
            simulateRates(fbdTree, 1, clRate, clVar);
        
        /* simulate character data */
        if (seqLen > 0)
            simulateData(fbdTree, seqLen, clHetero, alpha);
        
        /* write files */
        writeMrBayesCmd(output, fbdTree);
        // writeBEAST2XML(output, fbdTree, rho, ss);
        
        /* free memory of trees */
        freeTree(evoTree);
        freeTree(fbdTree);
        numTree++;
    }
    
    fclose(input);
    fclose(output);
    
    return 0;
}

void helpMsg() {
    printf("Compile: gcc -o fbdt *.c -lm\n");
    printf("Usage: ./fbdt -i <input> -o <output> -q <psi> -p <rho> -s <strat>\n");
    printf("              -c <rate> [-h] -v <var> -l <nchars> -a <alpha>\n");
}
