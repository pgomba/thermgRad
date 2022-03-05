#' Plots thermal gradient temperature for each Petri dish
#'
#' Taking into account thermal gradient plate corner temperatures this function return a graph with the temperatures of each Petri dish. Using the "precise" method returns a more accurate estimated grid of temperatures across the thermal plate, while with the adjust parameter is possible to estimate the temperature at the center of each Petri dish
#'
#' @param dayBL Average diurnal temperature at the bottom left side of the thermal gradient plate
#' @param dayBR Average diurnal temperature at the bottom left side of the thermal gradient plate
#' @param dayTL Average diurnal temperature at the bottom left side of the thermal gradient plate
#' @param dayTR Average diurnal temperature at the bottom left side of the thermal gradient plate
#' @param nightBL Average diurnal temperature at the bottom left side of the thermal gradient plate
#' @param nightBR Average diurnal temperature at the bottom left side of the thermal gradient plate
#' @param nightTL Average diurnal temperature at the bottom left side of the thermal gradient plate
#' @param nightTR Average diurnal temperature at the bottom left side of the thermal gradient plate
#' @param petri Number of Petri dishes in a column or a row.
#' @param method Leave blank to use average corner temperature values or use "precise" to create a temperature gradient based in individual corner temperatures
#' @param adjust tbd, but will be used to center temperature into Petri dish
#'
#' @return A graph with average Petri dish temperature
#' @export
#'
#' @examples
#' plot_tempgrad(dayBL=0,dayBR=0,dayTL=40,dayTR=40,nightBL=0,nightBR=40,nightTL=0,nightTR=40,petri=13)
#'
#' @importFrom ggplot2 ggplot aes geom_bar coord_flip geom_segment geom_point theme_dark geom_text scale_fill_distiller labs theme element_text element_blank
#'
plot_tempgrad<-function(dayBL="Diurnal bottom left temperature",
                   dayBR="Diurnal bottom right temperature",
                   dayTL="Diurnal top left temperature",
                   dayTR="Diurnal top right temperature",
                   nightBL="Nocturnal bottom left temperature",
                   nightBR="Nocturnal bottom right temperature",
                   nightTL="Nocturnal top left temperature",
                   nightTR="Nocturnal top right temperature",
                   petri="Number of petri in a column or row",
                   method="tbd",
                   adjust="tbd"
){
  let<-rep(LETTERS[seq(from=1,to=petri)],each=petri) #vector with as many letters as columns/rows
  grid<-paste0(let,1:13) #vector with al Petri dish labels
  if (method=="precise"){
    day_bot_row<-seq(dayBL,dayBR,length.out=petri)
    day_top_row<-seq(dayTL,dayTR,length.out=petri)
    night_top_row<-seq(nightTL,nightTR,length.out=petri)
    night_bot_row<-seq(nightBL,nightBR,length.out=petri)
    day_temp<-vector()
    night_temp<-vector()
    for (i in 1:petri) {
      dayt<-seq(day_top_row[i],day_bot_row[i],length.out=petri)
      nightt<-seq(night_top_row[i],night_bot_row[i],length.out=petri)
      day_temp <- c(day_temp, dayt)
      night_temp<-c(night_temp,nightt)
    }
  }
  else{
  day_temp<-rep(seq((dayTL+dayTR)/2,(dayBL+dayBR)/2,length.out=petri),time=petri)
  night_temp<-rep(seq((nightBL+nightTL)/2,(nightBR+nightTR)/2,length.out=petri),each=petri)
  }
  toplot<-data.frame(PD_ID=grid,day_temp=day_temp,night_temp=night_temp)
  ggplot2::ggplot(toplot,aes(day_temp,night_temp,z=(day_temp+night_temp)/2,label=round((day_temp+night_temp)/2,1)))+
    geom_segment(x=0,xend=40,y=0,yend=40,size=2,linetype="dashed")+
    geom_point(aes(fill=round((day_temp+night_temp)/2,1)),size=12,shape=21,stroke=1.1)+
    theme_dark()+
    geom_text(size=4)+
    scale_fill_distiller(palette = "Spectral", direction = -1)+
    labs(title="Average Petri dish temperature",x="Day Temperature",y="Night Temperature")+
    theme(plot.title =element_text(size=16),
          legend.title = element_blank(),
          axis.text.x = element_text(size=20),
          axis.text.y= element_text(size=20),
          axis.title = element_text(size=20) )+
    theme(legend.position = "right")
  }
}
