/*
 gcc -o simr main.c rate.c tree.c utils.c seqs.c -lm
 ./simr -i bd.tre -o out.nex -g 0.8
 ./simr -i bd.tre -o out.nex -h 1.5 -l 200
*/

#include "main.h"
#include <assert.h>
#include <unistd.h>

int main (int argc, char *argv[]) {
    FILE   *input =NULL, *output =NULL;
    pPhyTree evoTree;
    int    c, numTrees, clockMod = STRICT, seqLen = -1;
    double clockVar = 0.0;
    
    /* parse arguments */
    while ((c = getopt(argc, argv, "i:o:g:h:n:l:")) != -1) {
        switch(c) {
            case 'i':  // input
                input  = fopen(optarg, "r");
                break;
            case 'o':  // output
                output = fopen(optarg, "w");
                break;
            case 'g':  // gamma
                clockMod = IGR;
                clockVar = atof(optarg);
                break;
            case 'h':  // lognormal
                clockMod = ILN;
                clockVar = atof(optarg);
                break;
            case 'n':  // normal
                clockMod = NORM;
                clockVar = atof(optarg);
                break;
            case 'l':  // morphological characters
                seqLen = atoi(optarg);
                break;
            default:
                exit(1);
        }
    }
    
    if (input == NULL || output == NULL) {
        printf("Unable to open input/output file!\n");
        printf("Usage: ./simr -i input.trees -o output.nex [-g <var>] [-n <var>] [-e] [-l <nchars>]\n");
        exit(1);
    }

    numTrees = 0;
	while ((c = fgetc(input)) != EOF) {
        if (isspace(c))  continue;
        ungetc(c, input);

        /* read in rooted tree */
        evoTree = readTree(input, ROOTED);
        // writeTree(stdout, evoTree);

        /* simulate clock rates on tree */
        setSeed();
        simulateRates(evoTree, clockMod, clockVar);
        
        if (seqLen > 0) {
            /* simulate character data */
            simulateData(evoTree, seqLen);

            /* write MrBayes commands */
            writeMBCmd_Data(output, evoTree);
        }
        else {
            /* fixed tree, no data */
            writeMBCmd_FixTree(output, evoTree);
        }
        
        /* free memory of tree */
        freeTree(evoTree);
        numTrees++;
    }
    
    fclose(input);
    fclose(output);
    
    return 0;
}

void writeMBCmd_FixTree(FILE *fp, pPhyTree tree) {
    /* write specific nexus file */
    int i;
    
    fprintf(fp, "#NEXUS\n");
    fprintf(fp, "Begin data;\n");
    fprintf(fp, "  dimensions ntax=%d nchar=1;\n", tree->ntips);
    fprintf(fp, "  format datatype=standard gap=- missing=?;\n");
    fprintf(fp, "matrix\n");
    for (i = 0; i < tree->ntips; i++) {
        fprintf(fp, "  %s\t?\n", tree->tips[i]->name);
    }
    fprintf(fp, ";\nEnd;\n");

    fprintf(fp, "Begin trees;\n");
    fprintf(fp, "  tree mytree[&B MixedBrlens]=[&R][&clockrate = %.10lf]", tree->baserate);
    assert(tree->type == ROOTED);
    writeRootedTreeRates(fp, tree->root, tree->root, tree->baserate);
    fprintf(fp, ";\nEnd;\n");

    fprintf(fp, "Begin mrbayes;\n");
    for (i = 0; i < tree->ntips; i++) {
        if (tree->tips[i]->age > 1e-8) {
            fprintf(fp, "  calibrate %s=fixed(%.10lf);\n", tree->tips[i]->name, tree->tips[i]->age);
        }
    }
    fprintf(fp, "  prset nodeagepr=calibrated;\n");
    fprintf(fp, "  prset brlenspr=clock:uniform;\n");
    fprintf(fp, "  prset topologypr=fixed(mytree);\n");
    fprintf(fp, "  prset clockvarpr=mixed;\n");
    fprintf(fp, "  mcmcp nrun=1 nchain=1 ngen=1000000 samplefr=100 printfr=1000000;\n");
    fprintf(fp, "  propset nodesliderclock(v)$prob=0;\n");
    fprintf(fp, "  propset treestretch(v)$prob=0;\n");
    fprintf(fp, "  propset multiplier(mixedBrlens)$prob=0;\n");
    fprintf(fp, "  propset rjMCMC_RCL$delta=1.2;\n");
    fprintf(fp, "  startvals [tau=mytree] v=mytree mixedBrlens=mytree;\n");
    fprintf(fp, "  mcmc;\n");
    fprintf(fp, "  sump;\n");
    fprintf(fp, "End;\n");
}

void writeMBCmd_Data(FILE *fp, pPhyTree tree) {
    int i, j;
    
    fprintf(fp, "#NEXUS\n");
    fprintf(fp, "Begin data;\n");
    fprintf(fp, "  dimensions ntax=%d nchar=%d;\n", tree->ntips, tree->nsites);
    fprintf(fp, "  format datatype=standard gap=- missing=?;\n");
    fprintf(fp, "matrix\n");
    for (i = 0; i < tree->ntips; i++) {
        fprintf(fp, "  %s\t", tree->tips[i]->name);
        for (j = 0; j < tree->nsites; j++)
            fprintf(fp, "%d", tree->tips[i]->sequence[j]);
        fprintf(fp, "\n");
    }
    fprintf(fp, ";\nEnd;\n");

    fprintf(fp, "Begin trees;\n");
    fprintf(fp, "  tree mytree[&B MixedBrlens]=[&R][&clockrate = %.10lf]", tree->baserate);
    assert(tree->type == ROOTED);
    writeRootedTreeRates(fp, tree->root, tree->root, tree->baserate);
    fprintf(fp, ";\nEnd;\n");

    fprintf(fp, "Begin mrbayes;\n");
    fprintf(fp, "  lset coding=variable;\n");
    for (i = 0; i < tree->ntips; i++) {
        if (tree->tips[i]->age > 1e-8) {
            fprintf(fp, "  calibrate %s=fixed(%.10lf);\n", tree->tips[i]->name, tree->tips[i]->age);
        }
    }
    fprintf(fp, "  prset nodeagepr=calibrated;\n");
    fprintf(fp, "  prset brlenspr=clock:uniform;\n");
    fprintf(fp, "  prset treeagepr=gamma(1, 0.1);\n");
    fprintf(fp, "  prset clockratepr=exp(1);\n");
    fprintf(fp, "  prset clockvarpr=mixed;\n");
    fprintf(fp, "  mcmcp nrun=1 nchain=1 ngen=10000000 samplefr=250 printfr=1000000;\n");
    fprintf(fp, "  propset rjMCMC_RCL$delta=1.2;\n");
    fprintf(fp, "  startvals tau=mytree v=mytree mixedBrlens=mytree;\n");
    fprintf(fp, "  mcmc;\n");
    fprintf(fp, "  sump;\n");
    fprintf(fp, "End;\n");
}
