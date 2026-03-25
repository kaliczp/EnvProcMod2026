## Install and load package
install.packages("TUWmodel")

library(TUWmodel)

## Identify the working folder and copy ptq.txt file, form Data sub-folder
getwd()

## Load dataset
ptq <- read.table("ptq.txt", sep = "\t", head = TRUE, skip = 1)

plot(ptq$Temp, type = "l")

## Genetate the dates for the whole window
ptqDate <- seq(as.Date("1981-01-01"),as.Date("1991-12-31"))
plot(ptqDate, ptq$Temp, type = "l")

## Time-series
install.packages("xts")
library(xts)
ptq.xts <- xts(ptq[,-1], ptqDate)
plot(ptq.xts$Temp)

ptq.xts
ptq.xts["1981"]

plot(ptq.xts["1981","Temp"])
plot(ptq.xts["1981-03","Temp"])
plot(ptq.xts["1981-03/1981-05","Temp"])

install.packages("SPEI")
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

str(simLight) # Let's see the structure of the result

## Visualise result
Qobs <- ptq.xts[,"Qsim"] # measured discharge
plot(Qobs)
Qmod <- xts(as.numeric((simLight$q)), ptqDate) # modelled discharge
plot(Qmod)

plot(Qmod['1981'])
lines(Qobs["1981"], col = "blue", lwd = 2)

## Nash-Sutcliff
1 - sum(coredata(Qobs - Qmod)^2) / sum(coredata(Qobs - mean(Qobs))^2)
