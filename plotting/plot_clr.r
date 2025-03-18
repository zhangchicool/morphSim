library(vioplot)

setwd("~/Documents/Research/2024-MorphSim/")

## 1. base clock rate ##
cl_m1  <- read.table("tipdating/m2v-vs-m2v/cl_base.txt",     header=F)
cl_m2  <- read.table("tipdating/m2v-vs-f2v/cl_base.txt",     header=F)
cl_m3  <- read.table("tipdating/f2v-a1-vs-m2v/cl_base.txt",  header=F)
cl_m4  <- read.table("tipdating/f2v-a1-vs-f2v/cl_base.txt",  header=F)
cl_m5  <- read.table("tipdating/f2v-v4-vs-m2v/cl_base.txt",  header=F)
cl_m6  <- read.table("tipdating/f2v-v4-vs-f2vg/cl_base.txt", header=F)
cl_m7  <- read.table("tipdating/g4v-a10-vs-m2v/cl_base.txt", header=F)
cl_m8  <- read.table("tipdating/g4v-a10-vs-f2v/cl_base.txt", header=F)
cl_m9  <- read.table("tipdating/g4v-a1-vs-m2v/cl_base.txt",  header=F)
cl_m10 <- read.table("tipdating/g4v-a1-vs-f2v/cl_base.txt",  header=F)
cl_m11 <- read.table("tipdating/g4v-v4-vs-m2v/cl_base.txt",  header=F)
cl_m12 <- read.table("tipdating/g4v-v4-vs-f2vg/cl_base.txt", header=F)
cl_m13 <- read.table("tipdating/g8v-a10-vs-m2v/cl_base.txt", header=F)
cl_m14 <- read.table("tipdating/g8v-a10-vs-f2v/cl_base.txt", header=F)
cl_m15 <- read.table("tipdating/g8v-a1-vs-m2v/cl_base.txt",  header=F)
cl_m16 <- read.table("tipdating/g8v-a1-vs-f2v/cl_base.txt",  header=F)
cl_m17 <- read.table("tipdating/g8v-v4-vs-m2v/cl_base.txt",  header=F)
cl_m18 <- read.table("tipdating/g8v-v4-vs-f2vg/cl_base.txt", header=F)

# relative bias
cl_bias1  <- cl_m1$V2 - 1.0
cl_bias2  <- cl_m2$V2 - 1.0
cl_bias3  <- cl_m3$V2 - 1.0
cl_bias4  <- cl_m4$V2 - 1.0
cl_bias5  <- cl_m5$V2 - 1.0
cl_bias6  <- cl_m6$V2 - 1.0
cl_bias7  <- cl_m7$V2 - 1.0
cl_bias8  <- cl_m8$V2 - 1.0
cl_bias9  <- cl_m9$V2 - 1.0
cl_bias10 <- cl_m10$V2- 1.0
cl_bias11 <- cl_m11$V2- 1.0
cl_bias12 <- cl_m12$V2- 1.0
cl_bias13 <- cl_m13$V2- 1.0
cl_bias14 <- cl_m14$V2- 1.0
cl_bias15 <- cl_m15$V2- 1.0
cl_bias16 <- cl_m16$V2- 1.0
cl_bias17 <- cl_m17$V2- 1.0
cl_bias18 <- cl_m18$V2- 1.0

# relative CI width
cl_CIw1  <- cl_m1$V5 - cl_m1$V4
cl_CIw2  <- cl_m2$V5 - cl_m2$V4
cl_CIw3  <- cl_m3$V5 - cl_m3$V4
cl_CIw4  <- cl_m4$V5 - cl_m4$V4
cl_CIw5  <- cl_m5$V5 - cl_m5$V4
cl_CIw6  <- cl_m6$V5 - cl_m6$V4
cl_CIw7  <- cl_m7$V5 - cl_m7$V4
cl_CIw8  <- cl_m8$V5 - cl_m8$V4
cl_CIw9  <- cl_m9$V5 - cl_m9$V4
cl_CIw10 <- cl_m10$V5- cl_m10$V4
cl_CIw11 <- cl_m11$V5- cl_m11$V4
cl_CIw12 <- cl_m12$V5- cl_m12$V4
cl_CIw13 <- cl_m13$V5- cl_m13$V4
cl_CIw14 <- cl_m14$V5- cl_m14$V4
cl_CIw15 <- cl_m15$V5- cl_m15$V4
cl_CIw16 <- cl_m16$V5- cl_m16$V4
cl_CIw17 <- cl_m17$V5- cl_m17$V4
cl_CIw18 <- cl_m18$V5- cl_m18$V4

# plot 
par(mfrow=c(2,2), mar=c(2,5,3,1))

vioplot(cl_bias1, cl_bias2, cl_bias7, cl_bias8, cl_bias13,cl_bias14,
        cl_bias3, cl_bias4, cl_bias9, cl_bias10,cl_bias15,cl_bias16,
        cl_bias5, cl_bias6, cl_bias11,cl_bias12,cl_bias17,cl_bias18,
        xaxt="n", ylim=c(-0.8,1.0))
axis(side=1, at=1:18, labels=F)
title(main="base clock rate (tip-dating)", ylab="relative bias")

vioplot(cl_CIw1, cl_CIw2, cl_CIw7, cl_CIw8, cl_CIw13,cl_CIw14,
        cl_CIw3, cl_CIw4, cl_CIw9, cl_CIw10,cl_CIw15,cl_CIw16,
        cl_CIw5, cl_CIw6, cl_CIw11,cl_CIw12,cl_CIw17,cl_CIw18,
        xaxt="n", ylim=c(0,3))
axis(side=1, at=1:18, labels=F)
title(ylab="relative CI width")

## 2. clock variance ##
cl_v1  <- read.table("tipdating/m2v-vs-m2v/cl_var.txt",     header=F)
cl_v2  <- read.table("tipdating/m2v-vs-f2v/cl_var.txt",     header=F)
cl_v3  <- read.table("tipdating/f2v-a1-vs-m2v/cl_var.txt",  header=F)
cl_v4  <- read.table("tipdating/f2v-a1-vs-f2v/cl_var.txt",  header=F)
cl_v5  <- read.table("tipdating/f2v-v4-vs-m2v/cl_var.txt",  header=F)
cl_v6  <- read.table("tipdating/f2v-v4-vs-f2vg/cl_var.txt", header=F)
cl_v7  <- read.table("tipdating/g4v-a10-vs-m2v/cl_var.txt", header=F)
cl_v8  <- read.table("tipdating/g4v-a10-vs-f2v/cl_var.txt", header=F)
cl_v9  <- read.table("tipdating/g4v-a1-vs-m2v/cl_var.txt",  header=F)
cl_v10 <- read.table("tipdating/g4v-a1-vs-f2v/cl_var.txt",  header=F)
cl_v11 <- read.table("tipdating/g4v-v4-vs-m2v/cl_var.txt",  header=F)
cl_v12 <- read.table("tipdating/g4v-v4-vs-f2vg/cl_var.txt", header=F)
cl_v13 <- read.table("tipdating/g8v-a10-vs-m2v/cl_var.txt", header=F)
cl_v14 <- read.table("tipdating/g8v-a10-vs-f2v/cl_var.txt", header=F)
cl_v15 <- read.table("tipdating/g8v-a1-vs-m2v/cl_var.txt",  header=F)
cl_v16 <- read.table("tipdating/g8v-a1-vs-f2v/cl_var.txt",  header=F)
cl_v17 <- read.table("tipdating/g8v-v4-vs-m2v/cl_var.txt",  header=F)
cl_v18 <- read.table("tipdating/g8v-v4-vs-f2vg/cl_var.txt", header=F)


