#' Title
#'
#' @param data
#'
#' @return
#' @export
#' @importFrom dplyr left_join filter between
#' @importFrom ggplot2
#' @examples
cardinal<-function(data="template dataframe",
                   fs= "lower thershold of fluctuation values",
                   fe= "higher threshold of fluctuation values"){
  grid<-petri_grid(data)
  temp<-tempgrad(0,0,40,40,0,40,0,40,petri = 13)
  grid_temp<-left_join(grid,temp,by="PD_ID")%>%
    filter(between(fluc,fs,fe))%>%
    drop_na()

  #maxGR<-which(grid_temp$GR==max(grid_temp$GR))
  #put_sub<-replace(grid_temp$GR,1:maxGR-1,"sub")
  #put_supra<-replace(put_sub,(maxGR+1):length(put_sub),"supra")
  #grid_temp$cardinal_labels<-replace(put_supra,maxGR,"both")

  print(grid_temp)

  show(ggplot(grid_temp,aes(x=average,y=GR))+
    geom_point(size=5))


  selectGR <- as.numeric(readline(prompt="Enter common temperature PD_ID number: "))

  put_sub<-replace(grid_temp$GR,1:selectGR-1,"sub")
  put_supra<-replace(put_sub,(selectGR+1):length(put_sub),"supra")
  grid_temp$cardinal_labels<-replace(put_supra,selectGR,"both")

  ggplot(grid_temp,aes(x=average,y=GR,colour=cardinal_labels))+
    geom_point(size=5)+
    geom_smooth(method="lm",se=FALSE,fullrange=TRUE, aes(colour=cardinal_labels))

}

cardinal(a,1,4)

ssibrary(tidyr)
library(thermgRad)
library(dplyr)
library(tidyverse)
library(devtools)
install()

e<-d%>%filter(fluc==0)%>%drop_na()%>%select(grid,GR)


which(e$GR,max(e$GR))

tt<-which(e$GR==max(e$GR))
w<-replace(e$GR,1:tt-1,"sub")
wc<-replace(w,(tt+1):length(w),"supra")
wc1<-replace(wc,tt,"both")
e$wc1<-wc1
