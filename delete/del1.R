library(devtools)
library(ggplot2)
library(magrittr)
library(dplyr)

chopchop(temp2)

document()
?plot_tempgrad
check()
install()
library(thermgRad)

a<-tempgrad(dayBL=0,dayBR=0,dayTL=40,dayTR=40,nightBL=0,nightBR=40,nightTL=0,nightTR=40,petri=13)
library(thermgRad)

tempgrad(dayBL=5.5,dayBR=6.1,dayTL=40,dayTR=39,nightBL=6,nightBR=39,nightTL=6.2,nightTR=40,petri=13,method = "precise")%>%
  plot_tempgrad(toplot = "average")

rep(seq((dayTL+dayTR)/2,(dayBL+dayBR)/2,length.out=petri),time=petri)

plot_tempgrad(a,toplot = "average")

use_pipe()
