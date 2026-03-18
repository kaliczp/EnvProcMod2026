## Install and load package
install.packages("TUWmodel")

library(TUWmodel)

## Identify the working folder and copy ptq.txt file, form Data sub-folder
getwd()

ptq <- read.table("ptq.txt", sep = "\t", head = TRUE, skip = 1)
library(SPEI)
plot(thornthwaite(ptq[,"Temp"], 37.6475)/30, type = "l")
Evaplight <- thornthwaite(ptq[,"Temp"], 37.6475)/30
simLight <- TUWmodel(prec=ptq[,"Prec."],
                         airt=ptq[,"Temp"],
                         ep=Evaplight,
                         area=1,
                     param=c(SCF = 1.02,
                             DDF = 1.70,
                             Tr = 2,
                             Ts = 0,
                             Tm = -0.336,
                             LPrat = 0.934,
                             FC = 120,
                             BETA = 2,
                             k0 = 0.25,
                             k1 = 0.1,
                             k2 = 0.01,
                             lsuz = 30,
                             cperc = 1,
                             bmax = 1,
                             croute = 25))


