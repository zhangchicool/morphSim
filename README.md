This git repository contains simulation scripts and main outputs under various settings each in a separate folder.  The aim of this simulation study is to explore how well the trees can be inferred from morphological characters. In some simple conditions, the inference model can match the model used to simulate the data, but for the others, the model used in simulation is more complicated than that in inference.

1. Simulating time trees: 
Rooted trees are simulated under a birth-death process with birth rate 5.0 and death rate 4.0, conditioned on root age of 1.0, and kept 100 trees with tips no more than 50. 
The simulation script is “bd.sim.r” in the “simulator” folder, and it requires R and the TreeSim package in R. The output trees are saved in “bd.trees”. Tree height, tree length, number of extant tips and number of extinct tips (treated as fossils) are summarized in “bd.tl.txt”. 

2. Simulating morphological characters: 
Given each tree, 200 morphological binary characters are simulated under the given substitution and clock models. 
The source code of this simulator is in the “simulator/src” folder.  Usage can be found in “readme.txt” in the “simulator” folder.

3. Inferring undated trees: 
The trees inferred from morphological characters are unrooted. Branch lengths in the tree are measured by distance. The commands for MrBayes are in “mb_un_*.nex” in the “scripts” folder.  The master script to run all analyses is “master.sh”.

4. Inferring time trees: 
The trees inferred using tip dating approach are rooted. The data include morphological characters and tip (fossil) ages. The tree prior is given by the fossilized birth-death process. The prior for the rates is independent lognormal. The clock rates are shared (linked) by all characters. 

5. Summarizing results: 
The tree distance metrics are summarized using "sum_t.r".

---
Contents:

1. figures -- supplementary figures S1-S4

2. scripts

3. simulator

4. nonclock(-mis) -- subfolder names refer figure legends

5. tipdating(-mis) -- subfolder names refer figure legends

6. test -- test run for one instance
