library(TUWmodel)
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
                             FC = 121,
                             BETA = 2.52,
                             k0 = 0.473,
                             k1 = 9.06,
                             k2 = 142,
                             lsuz = 50.1,
                             cperc = 2.38,
                             bmax = 10,
                             croute = 25))
