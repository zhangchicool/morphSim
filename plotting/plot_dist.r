library(vioplot)

setwd("~/Documents/Research/2024-MorphSim/")
# need to learn ggplot2 to plot nicer figs :P

## distance metrics ##
nc_d1  <- read.table("nonclock/m2v-vs-m2v/dist_t.txt",     header=T)
nc_d2  <- read.table("nonclock/m2v-vs-f2v/dist_t.txt",     header=T)
nc_d3  <- read.table("nonclock/f2v-a1-vs-m2v/dist_t.txt",  header=T)
nc_d4  <- read.table("nonclock/f2v-a1-vs-f2v/dist_t.txt",  header=T)
nc_d5  <- read.table("nonclock/f2v-v4-vs-m2v/dist_t.txt",  header=T)
nc_d6  <- read.table("nonclock/f2v-v4-vs-f2vg/dist_t.txt", header=T)
nc_d7  <- read.table("nonclock/g4v-a10-vs-m2v/dist_t.txt", header=T)
nc_d8  <- read.table("nonclock/g4v-a10-vs-f2v/dist_t.txt", header=T)
nc_d9  <- read.table("nonclock/g4v-a1-vs-m2v/dist_t.txt",  header=T)
nc_d10 <- read.table("nonclock/g4v-a1-vs-f2v/dist_t.txt",  header=T)
nc_d11 <- read.table("nonclock/g4v-v4-vs-m2v/dist_t.txt",  header=T)
nc_d12 <- read.table("nonclock/g4v-v4-vs-f2vg/dist_t.txt", header=T)
nc_d13 <- read.table("nonclock/g8v-a10-vs-m2v/dist_t.txt", header=T)
nc_d14 <- read.table("nonclock/g8v-a10-vs-f2v/dist_t.txt", header=T)
nc_d15 <- read.table("nonclock/g8v-a1-vs-m2v/dist_t.txt",  header=T)
nc_d16 <- read.table("nonclock/g8v-a1-vs-f2v/dist_t.txt",  header=T)
nc_d17 <- read.table("nonclock/g8v-v4-vs-m2v/dist_t.txt",  header=T)
nc_d18 <- read.table("nonclock/g8v-v4-vs-f2vg/dist_t.txt", header=T)

td_d1  <- read.table("tipdating/m2v-vs-m2v/dist_t.txt",     header=T)
td_d2  <- read.table("tipdating/m2v-vs-f2v/dist_t.txt",     header=T)
td_d3  <- read.table("tipdating/f2v-a1-vs-m2v/dist_t.txt",  header=T)
td_d4  <- read.table("tipdating/f2v-a1-vs-f2v/dist_t.txt",  header=T)
td_d5  <- read.table("tipdating/f2v-v4-vs-m2v/dist_t.txt",  header=T)
td_d6  <- read.table("tipdating/f2v-v4-vs-f2vg/dist_t.txt", header=T)
td_d7  <- read.table("tipdating/g4v-a10-vs-m2v/dist_t.txt", header=T)
td_d8  <- read.table("tipdating/g4v-a10-vs-f2v/dist_t.txt", header=T)
td_d9  <- read.table("tipdating/g4v-a1-vs-m2v/dist_t.txt",  header=T)
td_d10 <- read.table("tipdating/g4v-a1-vs-f2v/dist_t.txt",  header=T)
td_d11 <- read.table("tipdating/g4v-v4-vs-m2v/dist_t.txt",  header=T)
td_d12 <- read.table("tipdating/g4v-v4-vs-f2vg/dist_t.txt", header=T)
td_d13 <- read.table("tipdating/g8v-a10-vs-m2v/dist_t.txt", header=T)
td_d14 <- read.table("tipdating/g8v-a10-vs-f2v/dist_t.txt", header=T)
td_d15 <- read.table("tipdating/g8v-a1-vs-m2v/dist_t.txt",  header=T)
td_d16 <- read.table("tipdating/g8v-a1-vs-f2v/dist_t.txt",  header=T)
td_d17 <- read.table("tipdating/g8v-v4-vs-m2v/dist_t.txt",  header=T)
td_d18 <- read.table("tipdating/g8v-v4-vs-f2vg/dist_t.txt", header=T)

# 1. plot Quartet and MCI distance metrics
par(mfrow=c(2,2), mar=c(2,5,3,1))

vioplot(nc_d1$d_qt, nc_d2$d_qt, nc_d7$d_qt, nc_d8$d_qt, nc_d13$d_qt,nc_d14$d_qt,
        nc_d3$d_qt, nc_d4$d_qt, nc_d9$d_qt, nc_d10$d_qt,nc_d15$d_qt,nc_d16$d_qt,
        nc_d5$d_qt, nc_d6$d_qt, nc_d11$d_qt,nc_d12$d_qt,nc_d17$d_qt,nc_d18$d_qt,
        xaxt="n", ylim=c(0,0.5))
axis(side=1, at=1:18, labels=F)
title(main="distance metrics (nonclock)", ylab="Quartet")

vioplot(td_d1$d_qt, td_d2$d_qt, td_d7$d_qt, td_d8$d_qt, td_d13$d_qt,td_d14$d_qt,
        td_d3$d_qt, td_d4$d_qt, td_d9$d_qt, td_d10$d_qt,td_d15$d_qt,td_d16$d_qt,
        td_d5$d_qt, td_d6$d_qt, td_d11$d_qt,td_d12$d_qt,td_d17$d_qt,td_d18$d_qt,
        xaxt="n", ylim=c(0,0.5))
axis(side=1, at=1:18, labels=F)
title(main="distance metrics (tip-dating)")

vioplot(nc_d1$d_ci, nc_d2$d_ci, nc_d7$d_ci, nc_d8$d_ci, nc_d13$d_ci,nc_d14$d_ci,
        nc_d3$d_ci, nc_d4$d_ci, nc_d9$d_ci, nc_d10$d_ci,nc_d15$d_ci,nc_d16$d_ci,
        nc_d5$d_ci, nc_d6$d_ci, nc_d11$d_ci,nc_d12$d_ci,nc_d17$d_ci,nc_d18$d_ci,
        xaxt="n", ylim=c(0,0.5))
axis(side=1, at=1:18, labels=F)
title(ylab="MCI")

vioplot(td_d1$d_ci, td_d2$d_ci, td_d7$d_ci, td_d8$d_ci, td_d13$d_ci,td_d14$d_ci,
        td_d3$d_ci, td_d4$d_ci, td_d9$d_ci, td_d10$d_ci,td_d15$d_ci,td_d16$d_ci,
        td_d5$d_ci, td_d6$d_ci, td_d11$d_ci,td_d12$d_ci,td_d17$d_ci,td_d18$d_ci,
        xaxt="n", ylim=c(0,0.5))
axis(side=1, at=1:18, labels=F)

# 2. plot resolution vs SJA
par(mfrow=c(6,3), mar=c(1,1,1,1))

#(new fig) 
plot(nc_d1$sja ~nc_d1$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d3$sja ~nc_d3$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d5$sja ~nc_d5$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d2$sja ~nc_d2$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d4$sja ~nc_d4$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d6$sja ~nc_d6$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d7$sja ~nc_d7$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d9$sja ~nc_d9$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d11$sja~nc_d11$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d8$sja ~nc_d8$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d10$sja~nc_d10$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d12$sja~nc_d12$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d13$sja~nc_d13$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d15$sja~nc_d15$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d17$sja~nc_d17$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d14$sja~nc_d14$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d16$sja~nc_d16$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(nc_d18$sja~nc_d18$reso, xlim=c(0,1), ylim=c(0.5,1))

#(new fig) 
plot(td_d1$sja ~td_d1$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d3$sja ~td_d3$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d5$sja ~td_d5$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d2$sja ~td_d2$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d4$sja ~td_d4$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d6$sja ~td_d6$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d7$sja ~td_d7$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d9$sja ~td_d9$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d11$sja~td_d11$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(td_d8$sja ~td_d8$reso,  xlim=c(0,1), ylim=c(0.5,1))
plot(td_d10$sja~td_d10$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(td_d12$sja~td_d12$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(td_d13$sja~td_d13$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(td_d15$sja~td_d15$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(td_d17$sja~td_d17$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(td_d14$sja~td_d14$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(td_d16$sja~td_d16$reso, xlim=c(0,1), ylim=c(0.5,1))
plot(td_d18$sja~td_d18$reso, xlim=c(0,1), ylim=c(0.5,1))

