# read concatenated roots data by control/eCO2 and horizon

controlA = read.table("control-A.csv", sep=",", comment.char="")
controlB = read.table("control-B.csv", sep=",", comment.char="")
controlO = read.table("control-O.csv", sep=",", comment.char="")

treatmentA = read.table("treatment-A.csv", sep=",", comment.char="")
treatmentB = read.table("treatment-B.csv", sep=",", comment.char="")
treatmentO = read.table("treatment-O.csv", sep=",", comment.char="")

### boxplots for lengths by horizon and experiment

pdf("roots-length-horizon.pdf")
boxplot(log(controlO$V4), log(treatmentO$V4), log(controlA$V4), log(treatmentA$V4), log(controlB$V4), log(treatmentB$V4), col=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(1,0,0,0.5)), xaxt="n", ylab = "log(Length / cm)")
axis(1, at = c(1, 2, 3, 4, 5, 6), labels=c("C-O", "T-O", "C-A", "T-A", "C-B", "T-B"))

dev.off()

pdf("roots-length-all.pdf")
controlall = c(controlO$V4, controlA$V4, controlB$V4)
treatmentall = c(treatmentO$V4, treatmentA$V4, treatmentB$V4)
boxplot(log(controlall), log(treatmentall), col=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)), xaxt="n", ylab = "log(Length / cm)")
axis(1, at = c(1, 2), labels=c("Control", "Treatment"))
dev.off()

### boxplots for widths by horizon and experiment

pdf("roots-width-horizon.pdf")
boxplot(log(controlO$V9), log(treatmentO$V9), log(controlA$V9), log(treatmentA$V9), log(controlB$V9), log(treatmentB$V9), col=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(1,0,0,0.5), rgb(0,0,1,0.5), rgb(1,0,0,0.5)), xaxt="n", ylab = "log(Width / cm)")
axis(1, at = c(1, 2, 3, 4, 5, 6), labels=c("C-O", "T-O", "C-A", "T-A", "C-B", "T-B"))
dev.off()

pdf("roots-width-all.pdf")
controlall = c(controlO$V9, controlA$V9, controlB$V9)
treatmentall = c(treatmentO$V9, treatmentA$V9, treatmentB$V9)
boxplot(log(controlall), log(treatmentall), col=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)), xaxt="n", ylab = "log(Length / cm)")
axis(1, at = c(1, 2), labels=c("Control", "Treatment"))
dev.off()