######## first look at overall data (not separated by horizon)

# read in parsed data
d0 <- read.table("core-weights.csv", header = T, sep = ",")

# subset out control and eCO2 observations
control = d0[(d0$Array.Number == 2 | d0$Array.Number == 3 | d0$Array.Number == 5),]
treatment = d0[(d0$Array.Number == 1 | d0$Array.Number == 4 | d0$Array.Number == 6),]
# normalise and transform
# live = col 3; dead = col 4; both = col 5
control[,1] = control[,1]-min(control[,1])
treatment[,1] = treatment[,1]-min(treatment[,1])
control[,3] = log(control[,3])
control[,4] = log(control[,4])
control[,5] = log(control[,5])
treatment[,3] = log(treatment[,3])
treatment[,4] = log(treatment[,4])
treatment[,5] = log(treatment[,5])

# set up for plotting
pdf("output-weights1.pdf", width=8, height=2, paper="special") 
par(mfrow=c(1,3))

# loess fit for control-live 
loesscontrollive = predict(loess(control[,3] ~ control[,1]), se=T)
plot(control[,1], control[,3], col="blue", xlab="Time / days", ylab = "log(Live Biomass / mg)")
polygon(c(control[,1], rev(control[,1])), c( loesscontrollive$fit - qt(0.975,loesscontrollive$df)*loesscontrollive$se, rev( loesscontrollive$fit + qt(0.975,loesscontrollive$df)*loesscontrollive$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(control[,1], loesscontrollive$fit, col="blue")
points(control[,1], control[,3], col="blue", xlab="Time / days", ylab = "log(Live Biomass / mg)")

# loess fit for eCO2-live
loesstreatmentlive = predict(loess(treatment[,3] ~ treatment[,1]), se=T)
polygon(c(treatment[,1], rev(treatment[,1])), c( loesstreatmentlive$fit - qt(0.975,loesstreatmentlive$df)*loesstreatmentlive$se, rev( loesstreatmentlive$fit + qt(0.975,loesstreatmentlive$df)*loesstreatmentlive$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatment[,1], loesstreatmentlive$fit, col="red")
points(treatment[,1], treatment[,3], col="red", xlab="Time / days", ylab = "log(Live Biomass / mg)")

# loess fit for control-dead
loesscontroldead = predict(loess(control[,4] ~ control[,1]), se=T)
plot(control[,1], control[,4], col="blue", xlab="Time / days", ylab = "log(Dead Biomass / mg)")
polygon(c(control[,1], rev(control[,1])), c( loesscontroldead$fit - qt(0.975,loesscontroldead$df)*loesscontroldead$se, rev( loesscontroldead$fit + qt(0.975,loesscontroldead$df)*loesscontroldead$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(control[,1], loesscontroldead$fit, col="blue")
points(control[,1], control[,4], col="blue", xlab="Time / days", ylab = "log(Dead Biomass / mg)")

# loess fit for eCO2-dead
loesstreatmentdead = predict(loess(treatment[,4] ~ treatment[,1]), se=T)
polygon(c(treatment[,1], rev(treatment[,1])), c( loesstreatmentdead$fit - qt(0.975,loesstreatmentdead$df)*loesstreatmentdead$se, rev( loesstreatmentdead$fit + qt(0.975,loesstreatmentdead$df)*loesstreatmentdead$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatment[,1], loesstreatmentdead$fit, col="red")
points(treatment[,1], treatment[,4], col="red", xlab="Time / days", ylab = "log(Dead Biomass / mg)")

# loess fit for control-both
loesscontroltotal = predict(loess(control[,5] ~ control[,1]), se=T)
plot(control[,1], control[,5], col="blue", xlab="Time / days", ylab = "log(Total Biomass / mg)")
polygon(c(control[,1], rev(control[,1])), c( loesscontroltotal$fit - qt(0.975,loesscontroltotal$df)*loesscontroltotal$se, rev( loesscontroltotal$fit + qt(0.975,loesscontroltotal$df)*loesscontroltotal$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(control[,1], loesscontroltotal$fit, col="blue")
points(control[,1], control[,5], col="blue", xlab="Time / days", ylab = "log(Total Biomass / mg)")

# loess fit for eCO2-both
loesstreatmenttotal = predict(loess(treatment[,5] ~ treatment[,1]), se=T)
polygon(c(treatment[,1], rev(treatment[,1])), c( loesstreatmenttotal$fit - qt(0.975,loesstreatmenttotal$df)*loesstreatmenttotal$se, rev( loesstreatmenttotal$fit + qt(0.975,loesstreatmenttotal$df)*loesstreatmenttotal$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatment[,1], loesstreatmenttotal$fit, col="red")
points(treatment[,1], treatment[,5], col="red", xlab="Time / days", ylab = "log(Total Biomass / mg)")

dev.off()

############### now separate by horizon

# prepare for plot
pdf("output-weights2.pdf", width=8, height=4, paper="special") 
par(mfrow=c(1,2))

# read parsed data
dh = read.table("core-by-horizon.txt", header=T, sep="\t", stringsAsFactors=F)

# reorder (awkwardly dealing with legacy data format)
datalive = dh[,c(2,3,4,1)]
datadead = dh[,c(2,3,5,1)]

names(datalive)[1] <- "Array"
names(datalive)[2] <- "Horizon"
names(datalive)[3] <- "Mass"
names(datalive)[4] <- "Time"
names(datadead)[1] <- "Array"
names(datadead)[2] <- "Horizon"
names(datadead)[3] <- "Mass"
names(datadead)[4] <- "Time"

alllive = datalive
alldead = datadead
allliveo = alllive[alllive$Horizon == "O",]
alllivea = alllive[alllive$Horizon == "A",]
allliveb = alllive[alllive$Horizon == "B",]
alldeado = alldead[alldead$Horizon == "O",]
alldeada = alldead[alldead$Horizon == "A",]
alldeadb = alldead[alldead$Horizon == "B",]

# big subsetting into different control/eCO2 x live/dead x horizon
treatmentliveo = allliveo[(allliveo$Array == 1 | allliveo$Array == 4 | allliveo$Array == 6),]
treatmentlivea = alllivea[(alllivea$Array == 1 | alllivea$Array == 4 | alllivea$Array == 6),]
treatmentliveb = allliveb[(allliveb$Array == 1 | allliveb$Array == 4 | allliveb$Array == 6),]
controlliveo = allliveo[(allliveo$Array == 2 | allliveo$Array == 3 | allliveo$Array == 5),]
controllivea = alllivea[(alllivea$Array == 2 | alllivea$Array == 3 | alllivea$Array == 5),]
controlliveb = allliveb[(allliveb$Array == 2 | allliveb$Array == 3 | allliveb$Array == 5),]

treatmentdeado = alldeado[(alldeado$Array == 1 | alldeado$Array == 4 | alldeado$Array == 6),]
treatmentdeada = alldeada[(alldeada$Array == 1 | alldeada$Array == 4 | alldeada$Array == 6),]
treatmentdeadb = alldeadb[(alldeadb$Array == 1 | alldeadb$Array == 4 | alldeadb$Array == 6),]
controldeado = alldeado[(alldeado$Array == 2 | alldeado$Array == 3 | alldeado$Array == 5),]
controldeada = alldeada[(alldeada$Array == 2 | alldeada$Array == 3 | alldeada$Array == 5),]
controldeadb = alldeadb[(alldeadb$Array == 2 | alldeadb$Array == 3 | alldeadb$Array == 5),]

controllive = rbind(controlliveo, controllivea, controlliveb)
controllive[,3] = log(controllive[,3])
controllive = controllive[is.finite(controllive$Mass), ]
treatmentlive = rbind(treatmentliveo, treatmentlivea, treatmentliveb)
treatmentlive[,3] = log(treatmentlive[,3])
treatmentlive = treatmentlive[is.finite(treatmentlive$Mass), ]
controldead = rbind(controldeado, controldeada, controldeadb)
controldead[,3] = log(controldead[,3])
controldead = controldead[is.finite(controldead$Mass), ]
treatmentdead = rbind(treatmentdeado, treatmentdeada, treatmentdeadb)
treatmentdead[,3] = log(treatmentdead[,3])
treatmentdead = treatmentdead[is.finite(treatmentdead$Mass), ]

controldeado = alldeado[(alldeado$Array == 1 | alldeado$Array == 4 | alldeado$Array == 6),]
controldeada = alldeada[(alldeada$Array == 1 | alldeada$Array == 4 | alldeada$Array == 6),]
controldeadb = alldeadb[(alldeadb$Array == 1 | alldeadb$Array == 4 | alldeadb$Array == 6),]
treatmentdeado = alldeado[(alldeado$Array == 2 | alldeado$Array == 3 | alldeado$Array == 5),]
treatmentdeada = alldeada[(alldeada$Array == 2 | alldeada$Array == 3 | alldeada$Array == 5),]
treatmentdeadb = alldeadb[(alldeadb$Array == 2 | alldeadb$Array == 3 | alldeadb$Array == 5),]

# corresponding plots with horizontal offsets for clarity
plot(controlliveo[,4]-30, log(controlliveo[,3]), col="red", ylim=c(0,10), pch = 2, xlab="Time / days", ylab = "log(Biomass / mg)", cex=0.5)
points(controllivea[,4]-20, log(controllivea[,3]), col="pink", pch = 1, cex=0.5)
points(controlliveb[,4]-10, log(controlliveb[,3]), col="orange", pch=6, cex=0.5)
points(controldeado[,4]+10, log(controldeado[,3]), col="blue", pch=2, cex=0.5)
points(controldeada[,4]+20, log(controldeada[,3]), col="green", pch=1, cex=0.5)
points(controldeadb[,4]+30, log(controldeadb[,3]), col="purple", pch=6, cex=0.5)

plot(treatmentliveo[,4]-30, log(treatmentliveo[,3]), col="red", ylim=c(0,10), pch=2, xlab = "Time / days", ylab = "log(Biomass / mg)", cex=0.5)
points(treatmentlivea[,4]-20, log(treatmentlivea[,3]), col="pink", pch=1, cex=0.5)
points(treatmentliveb[,4]-10, log(treatmentliveb[,3]), col="orange", pch=6, cex=0.5)
points(treatmentdeado[,4]+10, log(treatmentdeado[,3]), col="blue", pch=2, cex=0.5)
points(treatmentdeada[,4]+20, log(treatmentdeada[,3]), col="green", pch=1, cex=0.5)
points(treatmentdeadb[,4]+30, log(treatmentdeadb[,3]), col="purple", pch=6, cex=0.5)
dev.off()
