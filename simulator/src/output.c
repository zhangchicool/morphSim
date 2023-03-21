#include "tree.h"
#include "utils.h"

/* NEXUS file for MrBayes */
void writeMrBayesCmd(FILE* fp, pPhyTree tree, double missing) {
    int i, j;

    fprintf(fp, "#NEXUS\n");
    fprintf(fp, "Begin data;\n");
    if (tree->nsites > 0)
        fprintf(fp, "  dimensions ntax=%d nchar=%d;\n", tree->ntips, tree->nsites);
    else
        fprintf(fp, "  dimensions ntax=%d nchar=1;\n", tree->ntips);

    fprintf(fp, "  format datatype=standard gap=- missing=?;\n");
    fprintf(fp, "matrix\n");
    if (tree->nsites > 0) {
        for (i = 0; i < tree->ntips; i++) {
            fprintf(fp, "  %s\t", tree->tips[i]->name);
            for (j = 0; j < tree->nsites; j++) {
                if (rndu() < missing)
                    fprintf(fp, "?");
                else
                    fprintf(fp, "%d", tree->tips[i]->sequence[j]);
            }
            fprintf(fp, "\n");
        }
    } else {
        for (i = 0; i < tree->ntips; i++) {
            fprintf(fp, "  %s\t?\n", tree->tips[i]->name);
        }
    }
    fprintf(fp, ";\nEnd;\n\n");
    
    fprintf(fp, "Begin trees;\n");
    fprintf(fp, "  tree mytree=[&R][&clockrate = %lf]", tree->rbase);
    writeRootedTree(fp, tree->root);
    fprintf(fp, ";\nEnd;\n\n");
    
    fprintf(fp, "Begin MrBayes;\n");
    for (i = 0; i < tree->ntips; i++) {
        if (tree->tips[i]->age > 1e-8) {
            fprintf(fp, "  calibrate %s=fixed(%.10lf);\n", tree->tips[i]->name, tree->tips[i]->age);
        }
    }
    fprintf(fp, "  prset nodeagepr=calibrated;\n");
    fprintf(fp, "End;\n");
}

/* XML file for BEAST2: fixed tree, no sequence data */
void writeBEAST2XML_fixT(FILE* fp, pPhyTree tree, double rho, char *ss) {
    int i;
    int dimension = 10; // number of time intervals
    
    fprintf(fp, "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n");
    fprintf(fp, "<beast namespace=\"beast.core:beast.evolution.alignment:beast.evolution.operators:beast.evolution.likelihood\" version=\"2.6\">\n");
    fprintf(fp, "\n");
    fprintf(fp, "<map name=\"Uniform\" >beast.math.distributions.Uniform</map>\n");
    fprintf(fp, "<map name=\"Exponential\" >beast.math.distributions.Exponential</map>\n");
    fprintf(fp, "<map name=\"Beta\" >beast.math.distributions.Beta</map>\n");
    fprintf(fp, "<map name=\"Gamma\" >beast.math.distributions.Gamma</map>\n");
    fprintf(fp, "<map name=\"prior\" >beast.math.distributions.Prior</map>\n");
    fprintf(fp, "\n");
    fprintf(fp, "<run id=\"mcmc\" spec=\"MCMC\" chainLength=\"5000000\">\n");
    fprintf(fp, "    <state id=\"state\" storeEvery=\"10000\">\n");
    fprintf(fp, "        <tree id=\"Tree.t:tree\" name=\"stateNode\">\n");
    fprintf(fp, "            <taxonset id=\"TaxonSet.t:tree\" spec=\"TaxonSet\">\n");
    for (i = 0; i < tree->ntips; i++)
        fprintf(fp, "                <taxon id=\"%s\" spec=\"Taxon\"/>\n", tree->tips[i]->name);
    fprintf(fp, "            </taxonset>\n");
    fprintf(fp, "        </tree>\n");
    fprintf(fp, "        <parameter id=\"birthRate.t:tree\"       lower=\"0.0\" dimension=\"%d\" name=\"stateNode\">0.05</parameter>\n", dimension);
    fprintf(fp, "        <parameter id=\"deathRate.t:tree\"       lower=\"0.0\" dimension=\"%d\" name=\"stateNode\">0.03</parameter>\n", dimension);
    fprintf(fp, "        <parameter id=\"samplingRate.t:tree\"    lower=\"0.0\" dimension=\"%d\" name=\"stateNode\">0.02</parameter>\n", dimension);
    fprintf(fp, "        <parameter id=\"rho.t:tree\" upper=\"1.0\" lower=\"0.0\" dimension=\"1\" name=\"stateNode\">%lf</parameter>\n", rho);
    fprintf(fp, "        <parameter id=\"meanOU:birth\"  lower=\"0.0\" name=\"stateNode\">0.05</parameter>\n");
    fprintf(fp, "        <parameter id=\"sigmaOU:birth\" lower=\"0.0\" name=\"stateNode\">0.05</parameter>\n");
    fprintf(fp, "        <parameter id=\"nuOU:birth\"    lower=\"0.0\" name=\"stateNode\">2.0</parameter>\n");
    fprintf(fp, "        <parameter id=\"meanOU:death\"  lower=\"0.0\" name=\"stateNode\">0.05</parameter>\n");
    fprintf(fp, "        <parameter id=\"sigmaOU:death\" lower=\"0.0\" name=\"stateNode\">0.05</parameter>\n");
    fprintf(fp, "        <parameter id=\"nuOU:death\"    lower=\"0.0\" name=\"stateNode\">2.0</parameter>\n");
    fprintf(fp, "        <parameter id=\"meanOU:sampl\"  lower=\"0.0\" name=\"stateNode\">0.01</parameter>\n");
    fprintf(fp, "        <parameter id=\"sigmaOU:sampl\" lower=\"0.0\" name=\"stateNode\">0.01</parameter>\n");
    fprintf(fp, "        <parameter id=\"nuOU:sampl\"    lower=\"0.0\" name=\"stateNode\">2.0</parameter>\n");
    fprintf(fp, "    </state>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <init id=\"Tree.t:initial\" spec=\"beast.util.TreeParser\" IsLabelledNewick=\"true\" initial=\"@Tree.t:tree\"\n");
    fprintf(fp, "          newick=\"");
    writeRootedTree(fp, tree->root);
    fprintf(fp, ";\"\n");
    fprintf(fp, "          adjustTreeNodeHeights=\"false\" adjustTipHeights=\"false\"/>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <distribution id=\"posterior\" spec=\"util.CompoundDistribution\">\n");
    fprintf(fp, "        <distribution id=\"likelihood\" spec=\"util.CompoundDistribution\"/>\n");
    fprintf(fp, "        <distribution id=\"prior\" spec=\"util.CompoundDistribution\">\n");
    if (strcmp(ss, "div") == 0)
        fprintf(fp, "            <distribution id=\"FBDSkyline.t:tree\" spec=\"beast.evolution.speciation.BirthDeathSkylineDiversifiedSampling\" \n");
    else
        fprintf(fp, "            <distribution id=\"FBDSkyline.t:tree\" spec=\"beast.evolution.speciation.BirthDeathSkylineModel\" \n");
    fprintf(fp, "                          tree=\"@Tree.t:tree\" conditionOnRoot=\"true\" conditionOnSurvival=\"true\"\n");
    fprintf(fp, "                          birthRate=\"@birthRate.t:tree\" deathRate=\"@deathRate.t:tree\" samplingRate=\"@samplingRate.t:tree\"\n");
    fprintf(fp, "                          removalProbability=\"0.0\" rho=\"@rho.t:tree\">\n");
    fprintf(fp, "                <parameter id=\"birthChangeTimes.t:tree\" dimension=\"%d\" name=\"birthRateChangeTimes\">   ", dimension);
    for (i = dimension; i > 0; i--)
        fprintf(fp, "%.1lf ", (i-1) * tree->height / dimension);
    fprintf(fp, "</parameter>\n");
    fprintf(fp, "                <parameter id=\"deathChangeTimes.t:tree\" dimension=\"%d\" name=\"deathRateChangeTimes\">   ", dimension);
    for (i = dimension; i > 0; i--)
        fprintf(fp, "%.1lf ", (i-1) * tree->height / dimension);
    fprintf(fp, "</parameter>\n");
    fprintf(fp, "                <parameter id=\"samplChangeTimes.t:tree\" dimension=\"%d\" name=\"samplingRateChangeTimes\">", dimension);
    for (i = dimension; i > 0; i--)
        fprintf(fp, "%.1lf ", (i-1) * tree->height / dimension);
    fprintf(fp, "</parameter>\n");
    fprintf(fp, "                <reverseTimeArrays id=\"Boolean.0\" spec=\"parameter.BooleanParameter\" dimension=\"5\">true true true true true</reverseTimeArrays>\n");
    fprintf(fp, "            </distribution>\n");
    fprintf(fp, "\n");
    /* // uncomment the following
    fprintf(fp, "            <prior id=\"birthRatePrior.t:tree\" name=\"distribution\" x=\"@birthRate.t:tree\">\n");
    fprintf(fp, "                <Exponential id=\"ExpDistr.1\" name=\"distr\" mean=\"0.1\"/>\n");
    fprintf(fp, "            </prior>\n");
    fprintf(fp, "            <prior id=\"deathRatePrior.t:tree\" name=\"distribution\" x=\"@deathRate.t:tree\">\n");
    fprintf(fp, "                <Exponential id=\"ExpDistr.2\" name=\"distr\" mean=\"0.1\"/>\n");
    fprintf(fp, "            </prior>\n");
    fprintf(fp, "            <prior id=\"samplingRatePrior.t:tree\" name=\"distribution\" x=\"@samplingRate.t:tree\">\n");
    fprintf(fp, "                <Exponential id=\"ExpDistr.3\" name=\"distr\" mean=\"0.1\"/>\n");
    fprintf(fp, "            </prior>\n");
    fprintf(fp, "        </distribution>\n");
    fprintf(fp, "    </distribution>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <operator id=\"birthScaler.t:tree\"    spec=\"ScaleOperator\" parameter=\"@birthRate.t:tree\"    scaleFactor=\"0.75\" weight=\"10.0\"/>\n");
    fprintf(fp, "    <operator id=\"deathScaler.t:tree\"    spec=\"ScaleOperator\" parameter=\"@deathRate.t:tree\"    scaleFactor=\"0.75\" weight=\"10.0\"/>\n");
    fprintf(fp, "    <operator id=\"samplingScaler.t:tree\" spec=\"ScaleOperator\" parameter=\"@samplingRate.t:tree\" scaleFactor=\"0.75\" weight=\"10.0\"/>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <logger id=\"screenlog\" logEvery=\"100000\">\n");
    fprintf(fp, "        <log idref=\"posterior\"/>\n");
    fprintf(fp, "        <log idref=\"likelihood\"/>\n");
    fprintf(fp, "        <log idref=\"prior\"/>\n");
    fprintf(fp, "    </logger>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <logger id=\"tracelog\" fileName=\"sim_run.log\" logEvery=\"500\" model=\"@posterior\" sanitiseHeaders=\"true\" sort=\"smart\">\n");
    fprintf(fp, "        <log idref=\"posterior\"/>\n");
    fprintf(fp, "        <log idref=\"prior\"/>\n");
    fprintf(fp, "        <log id=\"treeHeight.t:tree\" spec=\"beast.evolution.tree.TreeHeightLogger\" tree=\"@Tree.t:tree\"/>\n");
    fprintf(fp, "        <log idref=\"birthRate.t:tree\"/>\n");
    fprintf(fp, "        <log idref=\"deathRate.t:tree\"/>\n");
    fprintf(fp, "        <log idref=\"samplingRate.t:tree\"/>\n");
    fprintf(fp, "        <log idref=\"rho.t:tree\"/>\n");
    fprintf(fp, "    </logger>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <logger id=\"treelog\" fileName=\"sim_run.trees\" logEvery=\"500\" mode=\"tree\">\n");
    fprintf(fp, "        <log id=\"treeLogger.t:tree\" spec=\"beast.evolution.tree.TreeWithMetaDataLogger\" tree=\"@Tree.t:tree\"/>\n");
    fprintf(fp, "    </logger>\n");
    fprintf(fp, "</run>\n");
    fprintf(fp, "</beast>\n");
    */
}

/* XML file for BEAST2: infer tree from sequence data */
void writeBEAST2XML_data(FILE* fp, pPhyTree tree, double rho, char *ss) {
    int i, l, len, n2st, n3st, n4st, n5st;
    int dimension = 10; // number of time intervals
    
    len = tree->nsites;
    n2st = (int)(len * 0.4);
    n3st = (int)(len * 0.3);
    n4st = (int)(len * 0.2);
    n5st = len - n2st - n3st - n4st;

    fprintf(fp, "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n");
    fprintf(fp, "<beast namespace=\"beast.core:beast.evolution.alignment:beast.evolution.operators:beast.evolution.likelihood:");
    fprintf(fp, "beast.evolution.sitemodel:beast.evolution.substitutionmodel\" version=\"2.6\">\n");
    fprintf(fp, "\n");
    fprintf(fp, "<data id=\"align:out\" spec=\"Alignment\" dataType=\"standard\">\n");
    for (i = 0; i < tree->ntips; i++) {
        fprintf(fp, "    <sequence id=\"seq_%d\" spec=\"Sequence\" taxon=\"%s\" totalcount=\"5\" value=\"", i+1, tree->tips[i]->name);
        for (l = 0; l < tree->nsites; l++)
            fprintf(fp, "%d", tree->tips[i]->sequence[l]);
        fprintf(fp, "01234\"/>\n");
    }
    fprintf(fp, "    <userDataType id=\"standardData\" spec=\"beast.evolution.datatype.StandardData\" ambiguities=\"\" nrOfStates=\"5\"/>\n");
    fprintf(fp, "</data>\n");
    fprintf(fp, "\n");
    fprintf(fp, "<map name=\"Uniform\" >beast.math.distributions.Uniform</map>\n");
    fprintf(fp, "<map name=\"Exponential\" >beast.math.distributions.Exponential</map>\n");
    fprintf(fp, "<map name=\"LogNormal\" >beast.math.distributions.LogNormalDistributionModel</map>\n");
    fprintf(fp, "<map name=\"Normal\" >beast.math.distributions.Normal</map>\n");
    fprintf(fp, "<map name=\"Beta\" >beast.math.distributions.Beta</map>\n");
    fprintf(fp, "<map name=\"Gamma\" >beast.math.distributions.Gamma</map>\n");
    fprintf(fp, "<map name=\"prior\" >beast.math.distributions.Prior</map>\n");
    fprintf(fp, "\n");
    fprintf(fp, "<run id=\"mcmc\" spec=\"MCMC\" chainLength=\"10000000\">\n");
    fprintf(fp, "    <state id=\"state\" spec=\"State\" storeEvery=\"10000\">\n");
    fprintf(fp, "        <tree id=\"Tree.t:out\" spec=\"beast.evolution.tree.Tree\" name=\"stateNode\">\n");
    fprintf(fp, "            <trait id=\"dateTrait.t:out\" spec=\"beast.evolution.tree.TraitSet\" traitname=\"date-backward\">\n");
    for (i = 0; i < tree->ntips; i++) {
        fprintf(fp, "                %s=%lf", tree->tips[i]->name, tree->tips[i]->age);
        if (i < tree->ntips -1)  fprintf(fp, ",\n");
        else                     fprintf(fp, "\n");
    }
    fprintf(fp, "                <taxa id=\"taxonSet.out\" spec=\"TaxonSet\">\n");
    fprintf(fp, "                    <alignment id=\"out2\" spec=\"FilteredAlignment\" ascertained=\"true\" data=\"@align:out\" ");
    fprintf(fp, "excludefrom=\"%d\" excludeto=\"%d\" filter=\"1-%d,%d-%d\">\n", n2st, n2st+2, n2st, len+1, len+2);
    fprintf(fp, "                        <userDataType id=\"morphDataType.out2\" spec=\"beast.evolution.datatype.StandardData\" ambiguities=\"\" nrOfStates=\"2\"/>\n");
    fprintf(fp, "                    </alignment>\n");
    fprintf(fp, "                </taxa>\n");
    fprintf(fp, "            </trait>\n");
    fprintf(fp, "            <taxonset idref=\"taxonSet.out\"/>\n");
    fprintf(fp, "        </tree>\n");
    fprintf(fp, "        <parameter id=\"clockRate.c:out\" lower=\"0.0\" name=\"stateNode\">%lf</parameter>\n", tree->rbase);
    if (tree->rvar > 0.0) {
        fprintf(fp, "        <parameter id=\"ucldStdev.c:out\" lower=\"0.0\" name=\"stateNode\">0.1</parameter>\n");
        fprintf(fp, "        <stateNode id=\"rateCategories.c:out\" spec=\"parameter.IntegerParameter\" dimension=\"%d\">1</stateNode>\n", 2*tree->ntips -2);
    }
    fprintf(fp, "        <parameter id=\"birthRate.t:out\"      lower=\"1E-8\" dimension=\"%d\" name=\"stateNode\">0.05</parameter>\n", dimension);
    fprintf(fp, "        <parameter id=\"deathRate.t:out\"      lower=\"1E-8\" dimension=\"%d\" name=\"stateNode\">0.03</parameter>\n", dimension);
    fprintf(fp, "        <parameter id=\"samplingRate.t:out\"    lower=\"0.0\" dimension=\"%d\" name=\"stateNode\">0.02</parameter>\n", dimension);
    fprintf(fp, "        <parameter id=\"rho.t:out\" upper=\"1.0\" lower=\"0.0\" dimension=\"1\" name=\"stateNode\">%lf</parameter>\n", rho);
    fprintf(fp, "        <parameter id=\"meanOU:birth\"  lower=\"0.0\" name=\"stateNode\">0.05</parameter>\n");
    fprintf(fp, "        <parameter id=\"sigmaOU:birth\" lower=\"0.0\" name=\"stateNode\">0.05</parameter>\n");
    fprintf(fp, "        <parameter id=\"nuOU:birth\"    lower=\"0.0\" name=\"stateNode\">2.0</parameter>\n");
    fprintf(fp, "        <parameter id=\"meanOU:death\"  lower=\"0.0\" name=\"stateNode\">0.05</parameter>\n");
    fprintf(fp, "        <parameter id=\"sigmaOU:death\" lower=\"0.0\" name=\"stateNode\">0.05</parameter>\n");
    fprintf(fp, "        <parameter id=\"nuOU:death\"    lower=\"0.0\" name=\"stateNode\">2.0</parameter>\n");
    fprintf(fp, "        <parameter id=\"meanOU:sampl\"  lower=\"0.0\" name=\"stateNode\">0.01</parameter>\n");
    fprintf(fp, "        <parameter id=\"sigmaOU:sampl\" lower=\"0.0\" name=\"stateNode\">0.01</parameter>\n");
    fprintf(fp, "        <parameter id=\"nuOU:sampl\"    lower=\"0.0\" name=\"stateNode\">2.0</parameter>\n");
    fprintf(fp, "    </state>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <init id=\"Tree.t:initial\" spec=\"beast.util.TreeParser\" IsLabelledNewick=\"true\" initial=\"@Tree.t:out\"\n");
    fprintf(fp, "          newick=\"");
    writeRootedTree(fp, tree->root);
    fprintf(fp, ";\"/>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <distribution id=\"posterior\" spec=\"util.CompoundDistribution\">\n");
    fprintf(fp, "        <distribution id=\"likelihood\" spec=\"util.CompoundDistribution\" useThreads=\"true\">\n");
    fprintf(fp, "            <distribution id=\"morphTreeLikelihood.out2\" spec=\"TreeLikelihood\" tree=\"@Tree.t:out\" data=\"@out2\">\n");
    fprintf(fp, "                <siteModel id=\"morphSiteModel.s:out2\" spec=\"SiteModel\">\n");
    fprintf(fp, "                    <substModel id=\"LewisMK.s:out2\" spec=\"LewisMK\" datatype=\"@morphDataType.out2\"/>\n");
    fprintf(fp, "                </siteModel>\n");
    fprintf(fp, "                <branchRateModel id=\"clockModel.c:out\" ");
    if (tree->rvar > 0.0) {
        fprintf(fp, "spec=\"beast.evolution.branchratemodel.UCRelaxedClockModel\" clock.rate=\"@clockRate.c:out\"");
        fprintf(fp, " rateCategories=\"@rateCategories.c:out\" tree=\"@Tree.t:out\">\n");
        fprintf(fp, "                    <LogNormal id=\"LNormDistr.c:out\" S=\"@ucldStdev.c:out\" M=\"1.0\" meanInRealSpace=\"true\" name=\"distr\"/>\n");
        fprintf(fp, "                </branchRateModel>\n");
    } else {
        fprintf(fp, "spec=\"beast.evolution.branchratemodel.StrictClockModel\" clock.rate=\"@clockRate.c:out\"/>\n");
    }
    fprintf(fp, "            </distribution>\n");
    fprintf(fp, "            <distribution id=\"morphTreeLikelihood.out3\" spec=\"TreeLikelihood\" tree=\"@Tree.t:out\" branchRateModel=\"@clockModel.c:out\">\n");
    fprintf(fp, "                <data id=\"out3\" spec=\"FilteredAlignment\" ascertained=\"true\" data=\"@align:out\" ");
    fprintf(fp, "excludefrom=\"%d\" excludeto=\"%d\" filter=\"%d-%d,%d-%d\">\n", n3st, n3st+3, n2st+1, n2st+n3st, len+1, len+3);
    fprintf(fp, "                    <userDataType id=\"morphDataType.out3\" spec=\"beast.evolution.datatype.StandardData\" ambiguities=\"\" nrOfStates=\"3\"/>\n");
    fprintf(fp, "                </data>\n");
    fprintf(fp, "                <siteModel id=\"morphSiteModel.s:out3\" spec=\"SiteModel\">\n");
    fprintf(fp, "                    <substModel id=\"LewisMK.s:out3\" spec=\"LewisMK\" datatype=\"@morphDataType.out3\"/>\n");
    fprintf(fp, "                </siteModel>\n");
    fprintf(fp, "            </distribution>\n");
    fprintf(fp, "            <distribution id=\"morphTreeLikelihood.out4\" spec=\"TreeLikelihood\" tree=\"@Tree.t:out\" branchRateModel=\"@clockModel.c:out\">\n");
    fprintf(fp, "                <data id=\"out4\" spec=\"FilteredAlignment\" ascertained=\"true\" data=\"@align:out\" ");
    fprintf(fp, "excludefrom=\"%d\" excludeto=\"%d\" filter=\"%d-%d,%d-%d\">\n", n4st, n4st+4, n2st+n3st+1, n2st+n3st+n4st, len+1, len+4);
    fprintf(fp, "                    <userDataType id=\"morphDataType.out4\" spec=\"beast.evolution.datatype.StandardData\" ambiguities=\"\" nrOfStates=\"4\"/>\n");
    fprintf(fp, "                </data>\n");
    fprintf(fp, "                <siteModel id=\"morphSiteModel.s:out4\" spec=\"SiteModel\">\n");
    fprintf(fp, "                    <substModel id=\"LewisMK.s:out4\" spec=\"LewisMK\" datatype=\"@morphDataType.out4\"/>\n");
    fprintf(fp, "                </siteModel>\n");
    fprintf(fp, "            </distribution>\n");
    fprintf(fp, "            <distribution id=\"morphTreeLikelihood.out5\" spec=\"TreeLikelihood\" tree=\"@Tree.t:out\" branchRateModel=\"@clockModel.c:out\">\n");
    fprintf(fp, "                <data id=\"out5\" spec=\"FilteredAlignment\" ascertained=\"true\" data=\"@align:out\" ");
    fprintf(fp, "excludefrom=\"%d\" excludeto=\"%d\" filter=\"%d-%d,%d-%d\">\n", n5st, n5st+5, len-n5st+1, len, len+1, len+5);
    fprintf(fp, "                    <userDataType id=\"morphDataType.out5\" spec=\"beast.evolution.datatype.StandardData\" ambiguities=\"\" nrOfStates=\"5\"/>\n");
    fprintf(fp, "                </data>\n");
    fprintf(fp, "                <siteModel id=\"morphSiteModel.s:out5\" spec=\"SiteModel\">\n");
    fprintf(fp, "                    <substModel id=\"LewisMK.s:out5\" spec=\"LewisMK\" datatype=\"@morphDataType.out5\"/>\n");
    fprintf(fp, "                </siteModel>\n");
    fprintf(fp, "            </distribution>\n");
    fprintf(fp, "        </distribution>\n");
    fprintf(fp, "        <distribution id=\"prior\" spec=\"util.CompoundDistribution\">\n");
    fprintf(fp, "            <distribution id=\"FBDSkyline.t:out\" ");
    if (strcmp(ss, "div") == 0)
        fprintf(fp, "spec=\"beast.evolution.speciation.BirthDeathSkylineDiversifiedSampling\" \n");
    else
        fprintf(fp, "spec=\"beast.evolution.speciation.BirthDeathSkylineModel\" \n");
    fprintf(fp, "                          tree=\"@Tree.t:out\" conditionOnRoot=\"true\" conditionOnSurvival=\"true\"\n");
    fprintf(fp, "                          birthRate=\"@birthRate.t:out\" deathRate=\"@deathRate.t:out\" samplingRate=\"@samplingRate.t:out\"\n");
    fprintf(fp, "                          removalProbability=\"0.0\" rho=\"@rho.t:out\">\n");
    fprintf(fp, "                <parameter id=\"birthChangeTimes.t:out\" dimension=\"%d\" name=\"birthRateChangeTimes\">   ", dimension);
    for (i = dimension; i > 0; i--)
        fprintf(fp, "%.1lf ", (i-1) * tree->height / dimension);
    fprintf(fp, "</parameter>\n");
    fprintf(fp, "                <parameter id=\"deathChangeTimes.t:out\" dimension=\"%d\" name=\"deathRateChangeTimes\">   ", dimension);
    for (i = dimension; i > 0; i--)
        fprintf(fp, "%.1lf ", (i-1) * tree->height / dimension);
    fprintf(fp, "</parameter>\n");
    fprintf(fp, "                <parameter id=\"samplChangeTimes.t:out\" dimension=\"%d\" name=\"samplingRateChangeTimes\">", dimension);
    for (i = dimension; i > 0; i--)
        fprintf(fp, "%.1lf ", (i-1) * tree->height / dimension);
    fprintf(fp, "</parameter>\n");
    fprintf(fp, "                <reverseTimeArrays id=\"Boolean.0\" spec=\"parameter.BooleanParameter\" dimension=\"5\">true true true true true</reverseTimeArrays>\n");
    fprintf(fp, "            </distribution>\n");
    fprintf(fp, "            <distribution id=\"rootAge.prior\" spec=\"beast.math.distributions.MRCAPrior\" monophyletic=\"true\" tree=\"@Tree.t:out\">\n");
    fprintf(fp, "                <taxonset id=\"root\" spec=\"TaxonSet\">\n");
    for (i = 0; i < tree->ntips; i++)
        fprintf(fp, "                    <taxon id=\"%s\" spec=\"Taxon\"/>\n", tree->tips[i]->name);
    fprintf(fp, "                </taxonset>\n");
    fprintf(fp, "                <Uniform id=\"Uniform.0\" name=\"distr\" upper=\"%lf\"/>\n", tree->height *2);
    fprintf(fp, "            </distribution>\n");
    fprintf(fp, "\n");
    /* // uncomment the following
    fprintf(fp, "            <prior id=\"birthRatePrior.t:out\" name=\"distribution\" x=\"@birthRate.t:out\">\n");
    fprintf(fp, "                <Exponential id=\"ExpDistr.1\" name=\"distr\" mean=\"0.1\"/>\n");
    fprintf(fp, "            </prior>\n");
    fprintf(fp, "            <prior id=\"deathRatePrior.t:out\" name=\"distribution\" x=\"@deathRate.t:out\">\n");
    fprintf(fp, "                <Exponential id=\"ExpDistr.2\" name=\"distr\" mean=\"0.1\"/>\n");
    fprintf(fp, "            </prior>\n");
    fprintf(fp, "            <prior id=\"samplingRatePrior.t:out\" name=\"distribution\" x=\"@samplingRate.t:out\">\n");
    fprintf(fp, "                <Exponential id=\"ExpDistr.3\" name=\"distr\" mean=\"0.1\"/>\n");
    fprintf(fp, "            </prior>\n");
    fprintf(fp, "            <prior id=\"clockPrior.c:out\" name=\"distribution\" x=\"@clockRate.c:out\">\n");
    fprintf(fp, "                <Uniform id=\"Uniform.c\" name=\"distr\"/>\n");
    fprintf(fp, "            </prior>\n");
    if (tree->rvar > 0.0) {
        fprintf(fp, "            <prior id=\"ucldStdevPrior.c:out\" name=\"distribution\" x=\"@ucldStdev.c:out\">\n");
        fprintf(fp, "                <Exponential id=\"ExpDistr.4\" name=\"distr\" mean=\"1.0\"/>\n");
        fprintf(fp, "            </prior>\n");
    }
    fprintf(fp, "        </distribution>\n");
    fprintf(fp, "    </distribution>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <operator id=\"birthScaler.t:out\"    spec=\"ScaleOperator\" parameter=\"@birthRate.t:out\"    scaleFactor=\"0.75\" weight=\"10.0\"/>\n");
    fprintf(fp, "    <operator id=\"deathScaler.t:out\"    spec=\"ScaleOperator\" parameter=\"@deathRate.t:out\"    scaleFactor=\"0.75\" weight=\"10.0\"/>\n");
    fprintf(fp, "    <operator id=\"samplingScaler.t:out\" spec=\"ScaleOperator\" parameter=\"@samplingRate.t:out\" scaleFactor=\"0.75\" weight=\"10.0\"/>\n");
    fprintf(fp, "    <operator id=\"clockScaler.c:out\"    spec=\"ScaleOperator\" parameter=\"@clockRate.c:out\"    scaleFactor=\"0.75\" weight=\"2.0\"/>\n");
    fprintf(fp, "    <operator id=\"clockUpDown.c:out\" spec=\"UpDownOperator\" scaleFactor=\"0.9\" weight=\"2.0\">\n");
    fprintf(fp, "        <up idref=\"clockRate.c:out\"/>\n        <down idref=\"Tree.t:out\"/>\n");
    fprintf(fp, "    </operator>\n");
    if (tree->rvar > 0.0) {
        fprintf(fp, "    <operator id=\"ucldStdevScaler.c:out\" spec=\"ScaleOperator\" parameter=\"@ucldStdev.c:out\" scaleFactor=\"0.5\" weight=\"2.0\"/>\n");
        fprintf(fp, "    <operator id=\"CategoriesRWalk.c:out\" spec=\"IntRandomWalkOperator\" parameter=\"@rateCategories.c:out\" weight=\"10.0\" windowSize=\"1\"/>\n");
        fprintf(fp, "    <operator id=\"CategoriesSwap.c:out\" spec=\"SwapOperator\" intparameter=\"@rateCategories.c:out\" weight=\"10.0\"/>\n");
        fprintf(fp, "    <operator id=\"CategoriesUniform.c:out\" spec=\"UniformOperator\" parameter=\"@rateCategories.c:out\" weight=\"10.0\"/>\n");
    }
    fprintf(fp, "    <operator id=\"LeafToSAFBD.t:out\" spec=\"LeafToSampledAncestorJump\" tree=\"@Tree.t:out\" weight=\"10.0\"/>\n");
    fprintf(fp, "    <operator id=\"SANarrowFBD.t:out\" spec=\"SAExchange\" tree=\"@Tree.t:out\" weight=\"15.0\"/>\n");
    fprintf(fp, "    <operator id=\"SAWideFBD.t:out\" spec=\"SAExchange\" isNarrow=\"false\" tree=\"@Tree.t:out\" weight=\"10.0\"/>\n");
    fprintf(fp, "    <operator id=\"SAWilsonBaldingFBD.t:out\" spec=\"SAWilsonBalding\" tree=\"@Tree.t:out\" weight=\"10.0\"/>\n");
    fprintf(fp, "    <operator id=\"SAUniformFBD.t:out\" spec=\"SAUniform\" tree=\"@Tree.t:out\" weight=\"35.0\"/>\n");
    fprintf(fp, "    <operator id=\"SARootScalerFBD.t:out\" spec=\"SAScaleOperator\" scaleFactor=\"0.9\" tree=\"@Tree.t:out\" rootOnly=\"true\" weight=\"1.0\"/>\n");
    fprintf(fp, "    <operator id=\"SATreeScalerFBD.t:out\" spec=\"SAScaleOperator\" scaleFactor=\"0.9\" tree=\"@Tree.t:out\" weight=\"2.0\"/>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <logger id=\"screenlog\" logEvery=\"100000\">\n");
    fprintf(fp, "        <log idref=\"posterior\"/>\n");
    fprintf(fp, "        <log idref=\"likelihood\"/>\n");
    fprintf(fp, "        <log idref=\"prior\"/>\n");
    fprintf(fp, "    </logger>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <logger id=\"tracelog\" fileName=\"sim_run.log\" logEvery=\"1000\" model=\"@posterior\" sanitiseHeaders=\"true\" sort=\"smart\">\n");
    fprintf(fp, "        <log idref=\"posterior\"/>\n");
    fprintf(fp, "        <log idref=\"likelihood\"/>\n");
    fprintf(fp, "        <log idref=\"prior\"/>\n");
    fprintf(fp, "        <log id=\"treeHeight.t:out\" spec=\"beast.evolution.tree.TreeStatLogger\" tree=\"@Tree.t:out\"/>\n");
    fprintf(fp, "        <log idref=\"birthRate.t:out\"/>\n");
    fprintf(fp, "        <log idref=\"deathRate.t:out\"/>\n");
    fprintf(fp, "        <log idref=\"samplingRate.t:out\"/>\n");
    fprintf(fp, "        <log idref=\"rho.t:out\"/>\n");
    fprintf(fp, "        <log idref=\"clockRate.c:out\"/>\n");
    if (tree->rvar > 0.0) {
        fprintf(fp, "        <log idref=\"ucldStdev.c:out\"/>\n");
        fprintf(fp, "        <log id=\"rate.c:out\" spec=\"beast.evolution.branchratemodel.RateStatistic\" tree=\"@Tree.t:out\" branchratemodel=\"@clockModel.c:out\"/>\n");
    }
    fprintf(fp, "    </logger>\n");
    fprintf(fp, "\n");
    fprintf(fp, "    <logger id=\"treelog\" fileName=\"sim_run.trees\" logEvery=\"1000\" mode=\"tree\">\n");
    fprintf(fp, "        <log id=\"treeLogger.t:out\" spec=\"beast.evolution.tree.TreeWithMetaDataLogger\" tree=\"@Tree.t:out\"");
    if (tree->rvar > 0.0)
        fprintf(fp, " branchratemodel=\"@clockModel.c:out\"/>\n");
    else
        fprintf(fp, "/>\n");
    fprintf(fp, "    </logger>\n");
    fprintf(fp, "</run>\n");
    fprintf(fp, "</beast>\n");
    */
}

void writeBEAST2XML(FILE* fp, pPhyTree tree, double rho, char *ss) {
    if (tree->nsites > 0)
        writeBEAST2XML_data(fp, tree, rho, ss);
    else
        writeBEAST2XML_fixT(fp, tree, rho, ss);
}
