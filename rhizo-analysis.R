control <- read.table("Biomass_per_rhizo_control.txt", header=T, sep="\t")
treatment <- read.table("Biomass_per_rhizo_treatment.txt", header=T, sep="\t")
control = control[-75,]
treatment = treatment[-2,]

treatmentx = treatment[,1]
treatmenty = log(treatment[,4])
controlx = control[,1]
controly = log(control[,4])

pdf("output-data1.pdf", width=6, height=8, paper="special") 
par(mfrow=c(2,1))

loesscontrol = predict(loess(controly ~ controlx), se=T)
plot(controlx-1.5, controly, col = "blue", xlab="Time / days", ylab = "log(Biomass / mg)", cex=0.5)
polygon(c(controlx, rev(controlx)), c( loesscontrol$fit - qt(0.975,loesscontrol$df)*loesscontrol$se, rev( loesscontrol$fit + qt(0.975,loesscontrol$df)*loesscontrol$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(controlx, loesscontrol$fit, col="blue")
points(controlx-1.5, controly, col = "blue", xlab="Time / days", ylab = "log(Biomass / mg)", cex=0.5)

loesstreatment = predict(loess(treatmenty ~ treatmentx), se=T)
polygon(c(treatmentx, rev(treatmentx)), c( loesstreatment$fit - qt(0.975,loesstreatment$df)*loesstreatment$se, rev( loesstreatment$fit + qt(0.975,loesstreatment$df)*loesstreatment$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatmentx, loesstreatment$fit, col="red")
points(treatmentx+1.5, treatmenty, col = "red", xlab="Time / days", ylab = "log(Biomass / mg)", cex=0.5)

controlchangey = control[,4]/control[,5]
treatmentchangey = treatment[,4]/treatment[,5]

loesscontrol = predict(loess(controlchangey ~ controlx), se=T)
plot(controlx-1.5, controlchangey, col = "blue", xlab = "Time / days", ylab = "Fold-change biomass", cex=0.5)
polygon(c(controlx, rev(controlx)), c( loesscontrol$fit - qt(0.975,loesscontrol$df)*loesscontrol$se, rev( loesscontrol$fit + qt(0.975,loesscontrol$df)*loesscontrol$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(controlx, loesscontrol$fit, col="blue")
points(controlx-1.5, controlchangey, col = "blue", xlab = "Time / days", ylab = "Fold-change biomass", cex=0.5)

loesstreatment = predict(loess(treatmentchangey ~ treatmentx), se=T)
polygon(c(treatmentx, rev(treatmentx)), c( loesstreatment$fit - qt(0.975,loesstreatment$df)*loesstreatment$se, rev( loesstreatment$fit + qt(0.975,loesstreatment$df)*loesstreatment$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatmentx, loesstreatment$fit, col="red")
points(treatmentx+1.5, treatmentchangey, col = "red", cex=0.5)
dev.off()
