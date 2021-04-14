########## time series and tests for root volume data

# read parsed data
control <- read.table("Biomass_per_rhizo_control.txt", header=T, sep="\t")
treatment <- read.table("Biomass_per_rhizo_treatment.txt", header=T, sep="\t")

# subset out time and log volume
treatmentx = treatment[,1]
treatmenty = log(treatment[,4])
controlx = control[,1]
controly = log(control[,4])

# prepare figure for plotting
pdf("output-data1.pdf", width=6, height=8, paper="special") 
par(mfrow=c(2,1))

## first look at raw data
# loess fit for control data
loesscontrol = predict(loess(controly ~ controlx), se=T)
plot(controlx-1.5, controly, col = "blue", xlab="Time / days", ylab = "log(Volume / mm3)", cex=0.5)
polygon(c(controlx, rev(controlx)), c( loesscontrol$fit - qt(0.975,loesscontrol$df)*loesscontrol$se, rev( loesscontrol$fit + qt(0.975,loesscontrol$df)*loesscontrol$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(controlx, loesscontrol$fit, col="blue")
points(controlx-1.5, controly, col = "blue", xlab="Time / days", ylab = "log(Volume / mm3)", cex=0.5)

# loess fit for eCO2 data
loesstreatment = predict(loess(treatmenty ~ treatmentx), se=T)
polygon(c(treatmentx, rev(treatmentx)), c( loesstreatment$fit - qt(0.975,loesstreatment$df)*loesstreatment$se, rev( loesstreatment$fit + qt(0.975,loesstreatment$df)*loesstreatment$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatmentx, loesstreatment$fit, col="red")
points(treatmentx+1.5, treatmenty, col = "red", xlab="Time / days", ylab = "log(Volume / mm3)", cex=0.5)

## now look at fold change from initial volume (column 5)
controlchangey = control[,4]/control[,5]
treatmentchangey = treatment[,4]/treatment[,5]

# loess fit for control data
loesscontrol = predict(loess(controlchangey ~ controlx), se=T)
plot(controlx-1.5, controlchangey, col = "blue", xlab = "Time / days", ylab = "Fold-change volume", cex=0.5)
polygon(c(controlx, rev(controlx)), c( loesscontrol$fit - qt(0.975,loesscontrol$df)*loesscontrol$se, rev( loesscontrol$fit + qt(0.975,loesscontrol$df)*loesscontrol$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(controlx, loesscontrol$fit, col="blue")
points(controlx-1.5, controlchangey, col = "blue", xlab = "Time / days", ylab = "Fold-change volumes", cex=0.5)

# loess fit for eCO2 data
loesstreatment = predict(loess(treatmentchangey ~ treatmentx), se=T)
polygon(c(treatmentx, rev(treatmentx)), c( loesstreatment$fit - qt(0.975,loesstreatment$df)*loesstreatment$se, rev( loesstreatment$fit + qt(0.975,loesstreatment$df)*loesstreatment$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatmentx, loesstreatment$fit, col="red")
points(treatmentx+1.5, treatmentchangey, col = "red", cex=0.5)
dev.off()

# LOESS fold-change maxima
max(loesstreatment$fit)
loesstreatment$se.fit[which(loesstreatment$fit==max(loesstreatment$fit))]
max(loesscontrol$fit)
loesscontrol$se.fit[which(loesscontrol$fit==max(loesscontrol$fit))]

# test specific data range
begin.date = 150
end.date = 350
treatment.set = treatmentchangey[which(treatmentx >= begin.date  & treatmentx <= end.date)]
control.set = controlchangey[which(controlx >= begin.date  & controlx <= end.date)]
mean(treatment.set)
mean(control.set)
sd(treatment.set)/sqrt(length(treatment.set))
sd(control.set)/sqrt(length(control.set))
wilcox.test(treatment.set, control.set)

############# fits for root widths

# read and subset data
df <- read.table("root-widths.txt")
controlw <- df[(df[,1]==2|df[,1]==3|df[,1]==5),]
treatmentw <- df[(df[,1]==1|df[,1]==4|df[,1]==6),]
controlw[,3] = log(controlw[,3])
treatmentw[,3] = log(treatmentw[,3])

# prepare figure for plotting
pdf("root-widths.pdf", width=6, height=4)

# loess fits
loesscontrolw = predict(loess(controlw[,3] ~ controlw[,2]), se=T)
plot(controlw[,2]-2.5, controlw[,3], col="blue", xlab="Days from 11/4/2017", ylab = "log(Diameter / cm)", cex=0.25)
polygon(c(controlw[,2], rev(controlw[,2])), c( loesscontrolw$fit - qt(0.975,loesscontrolw$df)*loesscontrolw$se, rev( loesscontrolw$fit + qt(0.975,loesscontrolw$df)*loesscontrolw$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(controlw[,2], loesscontrolw$fit, col="blue")
#points(controlw[,2], controlw[,3], col="blue")

loesstreatmentw = predict(loess(treatmentw[,3] ~ treatmentw[,2]), se=T)
points(treatmentw[,2]+2.5, treatmentw[,3], col="red", cex=0.25)
polygon(c(treatmentw[,2], rev(treatmentw[,2])), c( loesstreatmentw$fit - qt(0.975,loesstreatmentw$df)*loesstreatmentw$se, rev( loesstreatmentw$fit + qt(0.975,loesstreatmentw$df)*loesstreatmentw$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatmentw[,2], loesstreatmentw$fit, col="red")
#points(treatmentw[,2], treatmentw[,3], col="red")
dev.off()