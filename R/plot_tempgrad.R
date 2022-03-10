#' Plots thermal gradient temperature for each Petri dish
#'
#' Similar to tempgrad(), this function outputs a plot representing average temperature or temperature fluctuation for each petri dish
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
#' @param toplot Decides between plotting average Petri dish temperature (="average") or fluctuation (="fluctuation")
#'
#' @return A graph with average Petri dish temperature or temperature fluctuation
#' @export
#
#' @importFrom ggplot2 ggplot aes geom_bar geom_segment geom_point theme_dark geom_text scale_fill_distiller labs theme element_text element_blank
#' @importFrom magrittr %>%
#' @example
#' plot_tempgrad(0,0,40,40,0,40,0,40,petri=13,toplot = "average")
#'
plot_tempgrad<-function(x="Template with cumulative germination data",
                        dayBL="Diurnal bottom left temperature",
                        dayBR="Diurnal bottom right temperature",
                        dayTL="Diurnal top left temperature",
                        dayTR="Diurnal top right temperature",
                        nightBL="Nocturnal bottom left temperature",
                        nightBR="Nocturnal bottom right temperature",
                        nightTL="Nocturnal top left temperature",
                        nightTR="Nocturnal top right temperature",
                        petri="Number of petri in a column or row",
                        method="tbd",
                        adjust="tbd",
                        toplot="show average temperature or temperature fluctuation"){

  let<-rep(LETTERS[seq(from=1,to=petri)],each=petri) #vector with as many letters as columns/rows
  grid<-paste0(let,1:petri) #vector with al Petri dish labels

  germin<-((x[ncol(x)-1])/(x[ncol(x)]))*100
  names(germin)[length(names(germin))]<-"germ"

  if (method=="precise"){
    day_bot_row<-seq(dayBL,dayBR,length.out=petri)
    day_top_row<-seq(dayTL,dayTR,length.out=petri)
    night_top_row<-seq(nightTL,nightTR,length.out=petri)
    night_bot_row<-seq(nightBL,nightBR,length.out=petri)

    v_day<-vector()
    v_night<-vector()

    for (i in 1:petri) {
      day_temp<-seq(day_top_row[i],day_bot_row[i],length.out=petri)
      night_temp<-seq(night_top_row[i],night_bot_row[i],length.out=petri)
      v_day <- c(v_day, day_temp)
      v_night<-c(v_night,night_temp)
    }
    temp_grid<-data.frame(PD_ID=grid,day_temp=v_day,night_temp=v_night,average=(v_day+v_night)/2,fluc=round(v_day-v_night,2),abs_fluc=round(abs(v_day-v_night),2),germ=germin)
    print(temp_grid)
  }
  else{
    day_temp <- rep(seq((dayTL+dayTR)/2,(dayBL+dayBR)/2,length.out=petri),time=petri)
    night_temp <- rep(seq((nightBL+nightTL)/2,(nightBR+nightTR)/2,length.out=petri),each=petri)
    temp_grid <- data.frame(PD_ID=grid,day_temp=day_temp,night_temp=night_temp,average=(day_temp+night_temp)/2,fluc=round(day_temp-night_temp,2),abs_fluc=round(abs(day_temp-night_temp),2),germ=germin)
    print(temp_grid)
    }

  day_temp<-temp_grid$day_temp
  night_temp<-temp_grid$night_temp

  if (toplot=="average"){
    z<-(day_temp+night_temp)/2
    label<-round(z,1)
    tit<-"Average temperature"
  }
  if (toplot=="germina"){
    z<-temp_grid$germ
    label<-round(temp_grid$germ,1)
    tit<-"Germination %"
  }
  if (toplot=="fluctuation"){
    z<-round(abs(day_temp-night_temp),1)
    label<-round(z,1)
    tit<-"Temperature fluctuation"
  }
  ggplot2::ggplot(temp_grid,aes(night_temp,day_temp,z=z,label=label))+
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

