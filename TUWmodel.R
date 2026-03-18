library(TUWmodel)
ptq <- read.table("ptq.txt", sep = "\t", head = TRUE, skip = 1)
library(SPEI)
plot(thornthwaite(ptq[,"Temp"], 37.6475)/30, type = "l")
Evaplight <- thornthwaite(ptq[,"Temp"], 37.6475)/30
simLight <- TUWmodel(prec=ptq[,"Prec."],
                         airt=ptq[,"Temp"],
                         ep=Evaplight,
                         area=1,
                  param=c(1.02,1.70,2,0,-0.336,
                          0.934,121,2.52,
                          0.473,9.06,142,
                          50.1,2.38,10,25))
