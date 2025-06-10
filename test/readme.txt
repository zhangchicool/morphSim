Prerequirement: Linux (or WSL). Install gcc and R in Linux. 

To start, create a folder, e.g. called “test”. 

1. Run `bd.sim.r` in R to generate trees. Copy a small tree (e.g., line 19) in “bd.trees” and save it to “bd.tre” in the “test” folder.
  
2. Compile the source code in “simulator/src” and put the generated executable “msim” in the “test” folder. 

3. Compile the source code of MrBayes (downloaded from the develop branch on GitHub) and put the generated executable “mb” in the “test” folder. 

4. Copy “mb_un_m2v.nex” in the “scripts” folder to the “test” folder as "cmd.nex". 
Now the “test” folder contains: `bd.tre, cmd.nex, msim, mb`. In the Linux terminal, use the `cd` command to navigate to the “test” folder.

5. Run `./msim -i bd.tre -o data.nex -l 200 > run.log`. This will generate a file called “data.nex” containing a morphological character matrix.

6. Run `./mb cmd.nex >> run.log`. This will infer a tree from the data and save it to “data.nex.con.tre”.

7. Compare the true tree (bd.tre) with the inferred tree (data.nex.con.tre), e.g., using FigTree.

Once finishing this test, you can start to understand the script “run.sh”. You can also write your own script to automate the analysis.
