library(readxl)
temp2 <- read_excel("C:/Users/Pablo/Desktop/rose/temp2.xlsx")
View(temp2)

dput(temp2)

a<-petri_grid(temp2)
plot_tempgrad(b,toplot = "average")
b<-tempgrad(0,0,40,40,0,40,0,40,petri = 13)

library(thermgRad)
library(dplyr)
library(tidyverse)

x<-left_join(a,b,by=c("grid"="PD_ID"))%>%
  filter(fluc>=0)%>%
  drop_na()

ggplot2::ggplot(x,aes(y=day_temp,x=night_temp,z=fluc,label=round(fluc,2)))+
  geom_segment(x=0,xend=40,y=0,yend=40,size=2,linetype="dashed")+
  geom_point(aes(fill=fluc),size=12,shape=21,stroke=1.1)+
  theme_dark()+
  geom_text(size=4)+
  scale_fill_distiller(palette = "Spectral", direction = 1)+
  labs(title="Average Petri dish temperature",y="Day Temperature",x="Night Temperature")+
  theme(plot.title =element_text(size=16),
        legend.title = element_blank(),
        axis.text.x = element_text(size=20),
        axis.text.y= element_text(size=20),
        axis.title = element_text(size=20))+
  theme(legend.position = "right")





