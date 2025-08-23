library(vioplot)

setwd("~/Documents/Research/2024-MorphSim/")

## distance metrics ##
nc_d1  <- read.table("nonclock-50/m2v-vs-m2v/dist_t.txt",     header=T)
nc_d2  <- read.table("nonclock-50/m2v-vs-f2v/dist_t.txt",     header=T)
nc_d3  <- read.table("nonclock-50/f2v-a1-vs-m2v/dist_t.txt",  header=T)
nc_d4  <- read.table("nonclock-50/f2v-a1-vs-f2v/dist_t.txt",  header=T)
nc_d5  <- read.table("nonclock-50/f2v-v4-vs-m2v/dist_t.txt",  header=T)
nc_d6  <- read.table("nonclock-50/f2v-v4-vs-f2vg/dist_t.txt", header=T)
nc_d7  <- read.table("nonclock-50/g4v-a10-vs-m2v/dist_t.txt", header=T)
nc_d8  <- read.table("nonclock-50/g4v-a10-vs-f2v/dist_t.txt", header=T)
nc_d9  <- read.table("nonclock-50/g4v-a1-vs-m2v/dist_t.txt",  header=T)
nc_d10 <- read.table("nonclock-50/g4v-a1-vs-f2v/dist_t.txt",  header=T)
nc_d11 <- read.table("nonclock-50/g4v-v4-vs-m2v/dist_t.txt",  header=T)
nc_d12 <- read.table("nonclock-50/g4v-v4-vs-f2vg/dist_t.txt", header=T)
nc_d13 <- read.table("nonclock-50/g8v-a10-vs-m2v/dist_t.txt", header=T)
nc_d14 <- read.table("nonclock-50/g8v-a10-vs-f2v/dist_t.txt", header=T)
nc_d15 <- read.table("nonclock-50/g8v-a1-vs-m2v/dist_t.txt",  header=T)
nc_d16 <- read.table("nonclock-50/g8v-a1-vs-f2v/dist_t.txt",  header=T)
nc_d17 <- read.table("nonclock-50/g8v-v4-vs-m2v/dist_t.txt",  header=T)
nc_d18 <- read.table("nonclock-50/g8v-v4-vs-f2vg/dist_t.txt", header=T)

td_d1  <- read.table("tipdating-50/m2v-vs-m2v/dist_t.txt",     header=T)
td_d2  <- read.table("tipdating-50/m2v-vs-f2v/dist_t.txt",     header=T)
td_d3  <- read.table("tipdating-50/f2v-a1-vs-m2v/dist_t.txt",  header=T)
td_d4  <- read.table("tipdating-50/f2v-a1-vs-f2v/dist_t.txt",  header=T)
td_d5  <- read.table("tipdating-50/f2v-v4-vs-m2v/dist_t.txt",  header=T)
td_d6  <- read.table("tipdating-50/f2v-v4-vs-f2vg/dist_t.txt", header=T)
td_d7  <- read.table("tipdating-50/g4v-a10-vs-m2v/dist_t.txt", header=T)
td_d8  <- read.table("tipdating-50/g4v-a10-vs-f2v/dist_t.txt", header=T)
td_d9  <- read.table("tipdating-50/g4v-a1-vs-m2v/dist_t.txt",  header=T)
td_d10 <- read.table("tipdating-50/g4v-a1-vs-f2v/dist_t.txt",  header=T)
td_d11 <- read.table("tipdating-50/g4v-v4-vs-m2v/dist_t.txt",  header=T)
td_d12 <- read.table("tipdating-50/g4v-v4-vs-f2vg/dist_t.txt", header=T)
td_d13 <- read.table("tipdating-50/g8v-a10-vs-m2v/dist_t.txt", header=T)
td_d14 <- read.table("tipdating-50/g8v-a10-vs-f2v/dist_t.txt", header=T)
td_d15 <- read.table("tipdating-50/g8v-a1-vs-m2v/dist_t.txt",  header=T)
td_d16 <- read.table("tipdating-50/g8v-a1-vs-f2v/dist_t.txt",  header=T)
td_d17 <- read.table("tipdating-50/g8v-v4-vs-m2v/dist_t.txt",  header=T)
td_d18 <- read.table("tipdating-50/g8v-v4-vs-f2vg/dist_t.txt", header=T)

## tree lengths (50 chars) ##
true  <- read.table("simulator/bd.tl.txt", header=T)
tl_1  <- read.table("nonclock-50/m2v-vs-m2v/tl_estm.txt",     header=F)
tl_2  <- read.table("nonclock-50/m2v-vs-f2v/tl_estm.txt",     header=F)
tl_3  <- read.table("nonclock-50/f2v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_4  <- read.table("nonclock-50/f2v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_5  <- read.table("nonclock-50/f2v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_6  <- read.table("nonclock-50/f2v-v4-vs-f2vg/tl_estm.txt", header=F)
tl_7  <- read.table("nonclock-50/g4v-a10-vs-m2v/tl_estm.txt", header=F)
tl_8  <- read.table("nonclock-50/g4v-a10-vs-f2v/tl_estm.txt", header=F)
tl_9  <- read.table("nonclock-50/g4v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_10 <- read.table("nonclock-50/g4v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_11 <- read.table("nonclock-50/g4v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_12 <- read.table("nonclock-50/g4v-v4-vs-f2vg/tl_estm.txt", header=F)
tl_13 <- read.table("nonclock-50/g8v-a10-vs-m2v/tl_estm.txt", header=F)
tl_14 <- read.table("nonclock-50/g8v-a10-vs-f2v/tl_estm.txt", header=F)
tl_15 <- read.table("nonclock-50/g8v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_16 <- read.table("nonclock-50/g8v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_17 <- read.table("nonclock-50/g8v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_18 <- read.table("nonclock-50/g8v-v4-vs-f2vg/tl_estm.txt", header=F)
## tree heights (50 chars) ##
th_1  <- read.table("tipdating-50/m2v-vs-m2v/th_estm.txt",     header=F)
th_2  <- read.table("tipdating-50/m2v-vs-f2v/th_estm.txt",     header=F)
th_3  <- read.table("tipdating-50/f2v-a1-vs-m2v/th_estm.txt",  header=F)
th_4  <- read.table("tipdating-50/f2v-a1-vs-f2v/th_estm.txt",  header=F)
th_5  <- read.table("tipdating-50/f2v-v4-vs-m2v/th_estm.txt",  header=F)
th_6  <- read.table("tipdating-50/f2v-v4-vs-f2vg/th_estm.txt", header=F)
th_7  <- read.table("tipdating-50/g4v-a10-vs-m2v/th_estm.txt", header=F)
th_8  <- read.table("tipdating-50/g4v-a10-vs-f2v/th_estm.txt", header=F)
th_9  <- read.table("tipdating-50/g4v-a1-vs-m2v/th_estm.txt",  header=F)
th_10 <- read.table("tipdating-50/g4v-a1-vs-f2v/th_estm.txt",  header=F)
th_11 <- read.table("tipdating-50/g4v-v4-vs-m2v/th_estm.txt",  header=F)
th_12 <- read.table("tipdating-50/g4v-v4-vs-f2vg/th_estm.txt", header=F)
th_13 <- read.table("tipdating-50/g8v-a10-vs-m2v/th_estm.txt", header=F)
th_14 <- read.table("tipdating-50/g8v-a10-vs-f2v/th_estm.txt", header=F)
th_15 <- read.table("tipdating-50/g8v-a1-vs-m2v/th_estm.txt",  header=F)
th_16 <- read.table("tipdating-50/g8v-a1-vs-f2v/th_estm.txt",  header=F)
th_17 <- read.table("tipdating-50/g8v-v4-vs-m2v/th_estm.txt",  header=F)
th_18 <- read.table("tipdating-50/g8v-v4-vs-f2vg/th_estm.txt", header=F)

# relative bias
tl_bias1  <- (tl_1$V2 - true$tLength) / true$tLength
tl_bias2  <- (tl_2$V2 - true$tLength) / true$tLength
tl_bias3  <- (tl_3$V2 - true$tLength) / true$tLength
tl_bias4  <- (tl_4$V2 - true$tLength) / true$tLength
tl_bias5  <- (tl_5$V2 - true$tLength) / true$tLength
tl_bias6  <- (tl_6$V2 - true$tLength) / true$tLength
tl_bias7  <- (tl_7$V2 - true$tLength) / true$tLength
tl_bias8  <- (tl_8$V2 - true$tLength) / true$tLength
tl_bias9  <- (tl_9$V2 - true$tLength) / true$tLength
tl_bias10 <- (tl_10$V2- true$tLength) / true$tLength
tl_bias11 <- (tl_11$V2- true$tLength) / true$tLength
tl_bias12 <- (tl_12$V2- true$tLength) / true$tLength
tl_bias13 <- (tl_13$V2- true$tLength) / true$tLength
tl_bias14 <- (tl_14$V2- true$tLength) / true$tLength
tl_bias15 <- (tl_15$V2- true$tLength) / true$tLength
tl_bias16 <- (tl_16$V2- true$tLength) / true$tLength
tl_bias17 <- (tl_17$V2- true$tLength) / true$tLength
tl_bias18 <- (tl_18$V2- true$tLength) / true$tLength

th_bias1  <- (th_1$V2 - true$tHeight) / true$tHeight
th_bias2  <- (th_2$V2 - true$tHeight) / true$tHeight
th_bias3  <- (th_3$V2 - true$tHeight) / true$tHeight
th_bias4  <- (th_4$V2 - true$tHeight) / true$tHeight
th_bias5  <- (th_5$V2 - true$tHeight) / true$tHeight
th_bias6  <- (th_6$V2 - true$tHeight) / true$tHeight
th_bias7  <- (th_7$V2 - true$tHeight) / true$tHeight
th_bias8  <- (th_8$V2 - true$tHeight) / true$tHeight
th_bias9  <- (th_9$V2 - true$tHeight) / true$tHeight
th_bias10 <- (th_10$V2- true$tHeight) / true$tHeight
th_bias11 <- (th_11$V2- true$tHeight) / true$tHeight
th_bias12 <- (th_12$V2- true$tHeight) / true$tHeight
th_bias13 <- (th_13$V2- true$tHeight) / true$tHeight
th_bias14 <- (th_14$V2- true$tHeight) / true$tHeight
th_bias15 <- (th_15$V2- true$tHeight) / true$tHeight
th_bias16 <- (th_16$V2- true$tHeight) / true$tHeight
th_bias17 <- (th_17$V2- true$tHeight) / true$tHeight
th_bias18 <- (th_18$V2- true$tHeight) / true$tHeight

# relative CI width
tl_CIw1  <- (tl_1$V5 - tl_1$V4) / true$tLength
tl_CIw2  <- (tl_2$V5 - tl_2$V4) / true$tLength
tl_CIw3  <- (tl_3$V5 - tl_3$V4) / true$tLength
tl_CIw4  <- (tl_4$V5 - tl_4$V4) / true$tLength
tl_CIw5  <- (tl_5$V5 - tl_5$V4) / true$tLength
tl_CIw6  <- (tl_6$V5 - tl_6$V4) / true$tLength
tl_CIw7  <- (tl_7$V5 - tl_7$V4) / true$tLength
tl_CIw8  <- (tl_8$V5 - tl_8$V4) / true$tLength
tl_CIw9  <- (tl_9$V5 - tl_9$V4) / true$tLength
tl_CIw10 <- (tl_10$V5- tl_10$V4)/ true$tLength
tl_CIw11 <- (tl_11$V5- tl_11$V4)/ true$tLength
tl_CIw12 <- (tl_12$V5- tl_12$V4)/ true$tLength
tl_CIw13 <- (tl_13$V5- tl_13$V4)/ true$tLength
tl_CIw14 <- (tl_14$V5- tl_14$V4)/ true$tLength
tl_CIw15 <- (tl_15$V5- tl_15$V4)/ true$tLength
tl_CIw16 <- (tl_16$V5- tl_16$V4)/ true$tLength
tl_CIw17 <- (tl_17$V5- tl_17$V4)/ true$tLength
tl_CIw18 <- (tl_18$V5- tl_18$V4)/ true$tLength

th_CIw1  <- (th_1$V5 - th_1$V4) / true$tHeight
th_CIw2  <- (th_2$V5 - th_2$V4) / true$tHeight
th_CIw3  <- (th_3$V5 - th_3$V4) / true$tHeight
th_CIw4  <- (th_4$V5 - th_4$V4) / true$tHeight
th_CIw5  <- (th_5$V5 - th_5$V4) / true$tHeight
th_CIw6  <- (th_6$V5 - th_6$V4) / true$tHeight
th_CIw7  <- (th_7$V5 - th_7$V4) / true$tHeight
th_CIw8  <- (th_8$V5 - th_8$V4) / true$tHeight
th_CIw9  <- (th_9$V5 - th_9$V4) / true$tHeight
th_CIw10 <- (th_10$V5- th_10$V4)/ true$tHeight
th_CIw11 <- (th_11$V5- th_11$V4)/ true$tHeight
th_CIw12 <- (th_12$V5- th_12$V4)/ true$tHeight
th_CIw13 <- (th_13$V5- th_13$V4)/ true$tHeight
th_CIw14 <- (th_14$V5- th_14$V4)/ true$tHeight
th_CIw15 <- (th_15$V5- th_15$V4)/ true$tHeight
th_CIw16 <- (th_16$V5- th_16$V4)/ true$tHeight
th_CIw17 <- (th_17$V5- th_17$V4)/ true$tHeight
th_CIw18 <- (th_18$V5- th_18$V4)/ true$tHeight

## base clock rate ##
cl_m1  <- read.table("tipdating-50/m2v-vs-m2v/cl_base.txt",     header=F)
cl_m2  <- read.table("tipdating-50/m2v-vs-f2v/cl_base.txt",     header=F)
cl_m3  <- read.table("tipdating-50/f2v-a1-vs-m2v/cl_base.txt",  header=F)
cl_m4  <- read.table("tipdating-50/f2v-a1-vs-f2v/cl_base.txt",  header=F)
cl_m5  <- read.table("tipdating-50/f2v-v4-vs-m2v/cl_base.txt",  header=F)
cl_m6  <- read.table("tipdating-50/f2v-v4-vs-f2vg/cl_base.txt", header=F)
cl_m7  <- read.table("tipdating-50/g4v-a10-vs-m2v/cl_base.txt", header=F)
cl_m8  <- read.table("tipdating-50/g4v-a10-vs-f2v/cl_base.txt", header=F)
cl_m9  <- read.table("tipdating-50/g4v-a1-vs-m2v/cl_base.txt",  header=F)
cl_m10 <- read.table("tipdating-50/g4v-a1-vs-f2v/cl_base.txt",  header=F)
cl_m11 <- read.table("tipdating-50/g4v-v4-vs-m2v/cl_base.txt",  header=F)
cl_m12 <- read.table("tipdating-50/g4v-v4-vs-f2vg/cl_base.txt", header=F)
cl_m13 <- read.table("tipdating-50/g8v-a10-vs-m2v/cl_base.txt", header=F)
cl_m14 <- read.table("tipdating-50/g8v-a10-vs-f2v/cl_base.txt", header=F)
cl_m15 <- read.table("tipdating-50/g8v-a1-vs-m2v/cl_base.txt",  header=F)
cl_m16 <- read.table("tipdating-50/g8v-a1-vs-f2v/cl_base.txt",  header=F)
cl_m17 <- read.table("tipdating-50/g8v-v4-vs-m2v/cl_base.txt",  header=F)
cl_m18 <- read.table("tipdating-50/g8v-v4-vs-f2vg/cl_base.txt", header=F)

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

par(mfrow=c(4,2), mar=c(2.5,4.5,2.5,0.5))

# plot Quartet metrics
vioplot(nc_d1$d_qt, nc_d2$d_qt, nc_d7$d_qt, nc_d8$d_qt, nc_d13$d_qt,nc_d14$d_qt,
        nc_d3$d_qt, nc_d4$d_qt, nc_d9$d_qt, nc_d10$d_qt,nc_d15$d_qt,nc_d16$d_qt,
        nc_d5$d_qt, nc_d6$d_qt, nc_d11$d_qt,nc_d12$d_qt,nc_d17$d_qt,nc_d18$d_qt,
        xaxt="n", ylim=c(0,0.5))
axis(side=1, at=1:18, labels=1:18)
title(main="distance metrics (nonclock)", ylab="Quartet")

vioplot(td_d1$d_qt, td_d2$d_qt, td_d7$d_qt, td_d8$d_qt, td_d13$d_qt,td_d14$d_qt,
        td_d3$d_qt, td_d4$d_qt, td_d9$d_qt, td_d10$d_qt,td_d15$d_qt,td_d16$d_qt,
        td_d5$d_qt, td_d6$d_qt, td_d11$d_qt,td_d12$d_qt,td_d17$d_qt,td_d18$d_qt,
        xaxt="n", ylim=c(0,0.5))
axis(side=1, at=1:18, labels=1:18)
title(main="distance metrics (tip-dating)")

# and MCI distance metrics
vioplot(nc_d1$d_ci, nc_d2$d_ci, nc_d7$d_ci, nc_d8$d_ci, nc_d13$d_ci,nc_d14$d_ci,
        nc_d3$d_ci, nc_d4$d_ci, nc_d9$d_ci, nc_d10$d_ci,nc_d15$d_ci,nc_d16$d_ci,
        nc_d5$d_ci, nc_d6$d_ci, nc_d11$d_ci,nc_d12$d_ci,nc_d17$d_ci,nc_d18$d_ci,
        xaxt="n", ylim=c(0,1.0))
axis(side=1, at=1:18, labels=1:18)
title(ylab="MCI")

vioplot(td_d1$d_ci, td_d2$d_ci, td_d7$d_ci, td_d8$d_ci, td_d13$d_ci,td_d14$d_ci,
        td_d3$d_ci, td_d4$d_ci, td_d9$d_ci, td_d10$d_ci,td_d15$d_ci,td_d16$d_ci,
        td_d5$d_ci, td_d6$d_ci, td_d11$d_ci,td_d12$d_ci,td_d17$d_ci,td_d18$d_ci,
        xaxt="n", ylim=c(0,1.0))
axis(side=1, at=1:18, labels=1:18)

# plot tree lengths and heights
vioplot(tl_bias1, tl_bias2, tl_bias7, tl_bias8, tl_bias13,tl_bias14,
        tl_bias3, tl_bias4, tl_bias9, tl_bias10,tl_bias15,tl_bias16,
        tl_bias5, tl_bias6, tl_bias11,tl_bias12,tl_bias17,tl_bias18,
        xaxt="n", ylim=c(-1,0.4))
axis(side=1, at=1:18, labels=1:18)
title(main="tree length (nonclock)", ylab="relative bias")

vioplot(th_bias1, th_bias2, th_bias7, th_bias8, th_bias13,th_bias14,
        th_bias3, th_bias4, th_bias9, th_bias10,th_bias15,th_bias16,
        th_bias5, th_bias6, th_bias11,th_bias12,th_bias17,th_bias18,
        xaxt="n", ylim=c(-0.6,0.2))
axis(side=1, at=1:18, labels=1:18)
title(main="tree height (tip-dating)")

vioplot(tl_CIw1, tl_CIw2, tl_CIw7, tl_CIw8, tl_CIw13,tl_CIw14,
        tl_CIw3, tl_CIw4, tl_CIw9, tl_CIw10,tl_CIw15,tl_CIw16,
        tl_CIw5, tl_CIw6, tl_CIw11,tl_CIw12,tl_CIw17,tl_CIw18,
        xaxt="n", ylim=c(0,1.2))
axis(side=1, at=1:18, labels=1:18)
title(ylab="relative CI width")

vioplot(th_CIw1, th_CIw2, th_CIw7, th_CIw8, th_CIw13,th_CIw14,
        th_CIw3, th_CIw4, th_CIw9, th_CIw10,th_CIw15,th_CIw16,
        th_CIw5, th_CIw6, th_CIw11,th_CIw12,th_CIw17,th_CIw18,
        xaxt="n", ylim=c(0,1))
axis(side=1, at=1:18, labels=1:18)

# plot base clock rates
vioplot(cl_bias1, cl_bias2, cl_bias7, cl_bias8, cl_bias13,cl_bias14,
        cl_bias3, cl_bias4, cl_bias9, cl_bias10,cl_bias15,cl_bias16,
        cl_bias5, cl_bias6, cl_bias11,cl_bias12,cl_bias17,cl_bias18,
        xaxt="n", ylim=c(-0.8,1.5))
axis(side=1, at=1:18, labels=1:18)
title(main="base clock rate (tip-dating)", ylab="relative bias")

vioplot(cl_CIw1, cl_CIw2, cl_CIw7, cl_CIw8, cl_CIw13,cl_CIw14,
        cl_CIw3, cl_CIw4, cl_CIw9, cl_CIw10,cl_CIw15,cl_CIw16,
        cl_CIw5, cl_CIw6, cl_CIw11,cl_CIw12,cl_CIw17,cl_CIw18,
        xaxt="n", ylim=c(0,4))
axis(side=1, at=1:18, labels=1:18)
title(ylab="relative CI width")

# legend("topleft", 
#        c(" 1: M2v-vs-M2v;        2: M2v-vs-F2v",
#          " 3: G4v-a10-vs-M2v;    4: G4v-a10-vs-F2v",
#          " 5: G8v-a10-vs-M2v;    6: G8v-a10-vs-F2v",
#          " 7: F2v-vs-M2v;        8: F2v-vs-F2v",
#          " 9: G4v-a1-vs-M2v;    10: G4v-a1-vs-F2v",
#          "11: G8v-a1-vs-M2v;    12: G8v-a1-vs-F2v",
#          "13: F2v-v4-vs-M2v;    14: F2v-v4-vs-F2vG",
#          "15: G4v-a1-v4-vs-M2v; 16: G4v-a1-v4-vs-F2vG",
#          "17: G8v-a1-v4-vs-M2v; 18: G8v-a1-v4-vs-F2vG"), bty="n")

# 2. plot resolution vs SJA
par(mfrow=c(6,3), mar=c(1,1,1,1))

#(new fig) 
plot(nc_d1$sja ~nc_d1$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "M2v-vs-M2v", bty="n")
plot(nc_d3$sja ~nc_d3$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "F2v-vs-M2v", bty="n")
plot(nc_d5$sja ~nc_d5$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "F2v-v4-vs-M2v", bty="n")
plot(nc_d2$sja ~nc_d2$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "M2v-vs-F2v", bty="n")
plot(nc_d4$sja ~nc_d4$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "F2v-vs-F2v", bty="n")
plot(nc_d6$sja ~nc_d6$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "F2v-v4-vs-F2vG", bty="n")
plot(nc_d7$sja ~nc_d7$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a10-vs-M2v", bty="n")
plot(nc_d9$sja ~nc_d9$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a1-vs-M2v", bty="n")
plot(nc_d11$sja~nc_d11$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a1-v4-vs-M2v", bty="n")
plot(nc_d8$sja ~nc_d8$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a10-vs-F2v", bty="n")
plot(nc_d10$sja~nc_d10$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a1-vs-F2v", bty="n")
plot(nc_d12$sja~nc_d12$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a1-v4-vs-F2vG", bty="n")
plot(nc_d13$sja~nc_d13$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a10-vs-M2v", bty="n")
plot(nc_d15$sja~nc_d15$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a1-vs-M2v", bty="n")
plot(nc_d17$sja~nc_d17$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a1-v4-vs-M2v", bty="n")
plot(nc_d14$sja~nc_d14$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a10-vs-F2v", bty="n")
plot(nc_d16$sja~nc_d16$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a1-vs-F2v", bty="n")
plot(nc_d18$sja~nc_d18$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a1-v4-vs-F2vG", bty="n")

#(new fig) 
plot(td_d1$sja ~td_d1$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "M2v-vs-M2v", bty="n")
plot(td_d3$sja ~td_d3$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "F2v-vs-M2v", bty="n")
plot(td_d5$sja ~td_d5$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "F2v-v4-vs-M2v", bty="n")
plot(td_d2$sja ~td_d2$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "M2v-vs-F2v", bty="n")
plot(td_d4$sja ~td_d4$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "F2v-vs-F2v", bty="n")
plot(td_d6$sja ~td_d6$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "F2v-v4-vs-F2vG", bty="n")
plot(td_d7$sja ~td_d7$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a10-vs-M2v", bty="n")
plot(td_d9$sja ~td_d9$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a1-vs-M2v", bty="n")
plot(td_d11$sja~td_d11$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a1-v4-vs-M2v", bty="n")
plot(td_d8$sja ~td_d8$reso,  xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a10-vs-F2v", bty="n")
plot(td_d10$sja~td_d10$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a1-vs-F2v", bty="n")
plot(td_d12$sja~td_d12$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G4v-a1-v4-vs-F2vG", bty="n")
plot(td_d13$sja~td_d13$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a10-vs-M2v", bty="n")
plot(td_d15$sja~td_d15$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a1-vs-M2v", bty="n")
plot(td_d17$sja~td_d17$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a1-v4-vs-M2v", bty="n")
plot(td_d14$sja~td_d14$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a10-vs-F2v", bty="n")
plot(td_d16$sja~td_d16$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a1-vs-F2v", bty="n")
plot(td_d18$sja~td_d18$reso, xlim=c(0,1), ylim=c(0.5,1)); legend("bottomleft", "G8v-a1-v4-vs-F2vG", bty="n")
