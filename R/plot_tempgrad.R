#' Plots thermal gradient temperature for each Petri dish
#'
#' Taking into account thermal gradient plate corner temperatures this function return a graph with the temperatures of each Petri dish. Using the "precise" method returns a more accurate estimated grid of temperatures across the thermal plate, while with the adjust parameter is possible to estimate the temperature at the center of each Petri dish
#'
#' @param x a dataframe outputted by tempgrad function
#' @param toplot Decides between plotting average Petri dish temperature (="average) or fluctuation (="fluctuation)
#'
#' @return A graph with average Petri dish temperature or temperature fluctuation
#' @export
#'
#' @examples
#' x<-tempgrad(dayBL=0,dayBR=0,dayTL=40,dayTR=40,nightBL=0,nightBR=40,nightTL=0,nightTR=40,petri=13)
#' plot_tempgrad(x,toplot="average")
#' plot_tempgrad(x,toplot="fluctuation")
#' x%>%plot_tempgrad(toplot="average")
#'#'
#' @importFrom ggplot2 ggplot aes geom_bar geom_segment geom_point theme_dark geom_text scale_fill_distiller labs theme element_text element_blank
#' @importFrom magrittr %>%
plot_tempgrad<-function(x="output dataframe from tempgrad function",
                        toplot="tbdescribed"){
  day_temp<-x$day_temp
  night_temp<-x$night_temp
  if (toplot=="average"){
    z<-(day_temp+night_temp)/2
    label<-round(z,1)
    tit<-"Average temperature"
  }
  if (toplot=="fluctuation"){
    z<-round(abs(day_temp-night_temp),1)
    label<-round(z,1)
    tit<-"Temperature fluctuation"
  }
  ggplot2::ggplot(x,aes(night_temp,day_temp,z=z,label=label))+
    geom_segment(x=0,xend=40,y=0,yend=40,size=2,linetype="dashed")+
    geom_point(aes(fill=z),size=12,shape=21,stroke=1.1)+
    theme_dark()+
    geom_text(size=4)+
    scale_fill_distiller(palette = "Spectral", direction = -1)+
    labs(title=tit,x="Night Temperature",y="Day Temperature")+
    theme(plot.title =element_text(size=16),
          legend.title = element_blank(),
          axis.text.x = element_text(size=20),
          axis.text.y= element_text(size=20),
          axis.title = element_text(size=20))+
    theme(legend.position = "right")
  }

