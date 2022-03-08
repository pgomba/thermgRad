library(dplyr)
library(tidyverse)
a<-tg_example()

b<-petri_grid(a)
c<-tempgrad(0,0,40,40,0,40,0,40,petri = 13)

d<-left_join(b,c,by=c("grid"="PD_ID"))

e<-d%>%filter(fluc==0)%>%drop_na()%>%select(grid,GR)


which(e$GR,max(e$GR))

tt<-which(e$GR==max(e$GR))
w<-replace(e$GR,1:tt-1,"sub")
wc<-replace(w,(tt+1):length(w),"supra")
wc1<-replace(wc,tt,"both")
e$wc1<-wc1
