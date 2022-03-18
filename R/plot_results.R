#' Plots thermal gradient temperature for each Petri dish
#'
#' Similar to tempgrad(), this function outputs a plot representing average temperature or temperature fluctuation for each petri dish
#'
#' @param x germination data template
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
#' @param adjust adjust temperature to center of Petri dish
#' @param toplot Decides between plotting average Petri dish temperature (="average") or fluctuation (="fluctuation")
#'
#' @return A graph with average Petri dish temperature, temperature fluctuation or germination
#' @export
#
#' @importFrom ggplot2 ggplot aes geom_bar geom_segment geom_point theme_dark geom_text scale_fill_distiller labs theme element_text element_blank
#'
plot_results<-function(x="Template with cumulative germination data",
                        dayBL="Diurnal bottom left temperature",
                        dayBR="Diurnal bottom right temperature",
                        dayTL="Diurnal top left temperature",
                        dayTR="Diurnal top right temperature",
                        nightBL="Nocturnal bottom left temperature",
                        nightBR="Nocturnal bottom right temperature",
                        nightTL="Nocturnal top left temperature",
                        nightTR="Nocturnal top right temperature",
                        petri="Number of petri in a column or row",
                        method="average corners temperature or use these independently",
                        adjust="adjust temperature to center of Petri dish",
                        toplot="show average temperature or temperature fluctuation"){

  let<-rep(LETTERS[seq(from=1,to=petri)],each=petri) #vector with as many letters as columns/rows
  grid<-paste0(let,1:petri) #vector with al Petri dish labels

  if (adjust==TRUE){
    #day corrections
    d_horiz_down<-((abs(dayBL-dayBR)/petri)*-sign(dayBL-dayBR))/2
    d_horiz_up<-((abs(dayTL-dayTR)/petri)*-sign(dayTL-dayTR))/2
    d_verti_left<-((abs(dayBL-dayTL)/petri)*-sign(dayBL-dayTL))/2
    d_verti_right<-((abs(dayBR-dayTR)/petri)*-sign(dayBR-dayTR))/2
    #night corrections
    n_horiz_down<-((abs(nightBL-nightBR)/petri)*-sign(nightBL-nightBR))/2
    n_horiz_up<-((abs(nightTL-nightTR)/petri)*-sign(nightTL-nightTR))/2
    n_verti_left<-((abs(nightBL-nightTL)/petri)*-sign(nightBL-nightTL))/2
    n_verti_right<-((abs(nightBR-nightTR)/petri)*-sign(nightBR-nightTR))/2
    #apply day corrections
    dBL<-dayBL+d_horiz_down+d_verti_left
    dBR<-dayBR-d_horiz_down+d_verti_right
    dTL<-dayTL+d_horiz_up-d_verti_left
    dTR<-dayTR-d_horiz_up-d_verti_right
    #apply night corrections
    nBL<-nightBL+n_horiz_down+n_verti_left
    nBR<-nightBR-n_horiz_down+n_verti_right
    nTL<-nightTL+n_horiz_up-n_verti_left
    nTR<-nightTR-n_horiz_up-n_verti_right
  }else{
    dBL<-dayBL
    dBR<-dayBR
    dTL<-dayTL
    dTR<-dayTR
    nBL<-nightBL
    nBR<-nightBR
    nTL<-nightTL
    nTR<-nightTR
  }

germin<-((x[ncol(x)-1])/(x[ncol(x)]))*100
names(germin)[length(names(germin))]<-"germ"

  if (method=="precise"){
    day_bot_row<-seq(dBL,dBR,length.out=petri)
    day_top_row<-seq(dTL,dTR,length.out=petri)
    night_top_row<-seq(nTL,nTR,length.out=petri)
    night_bot_row<-seq(nBL,nBR,length.out=petri)

    v_day<-vector()
    v_night<-vector()

    for (i in 1:petri) {
      day_temp<-seq(day_top_row[i],day_bot_row[i],length.out=petri)
      night_temp<-seq(night_top_row[i],night_bot_row[i],length.out=petri)
      v_day <- c(v_day, day_temp)
      v_night<-c(v_night,night_temp)
    }
    temp_grid<-data.frame(PD_ID=grid,day_temp=v_day,night_temp=v_night,average=(v_day+v_night)/2,fluc=round(v_day-v_night,2),abs_fluc=round(abs(v_day-v_night),2),germ=germin)
    head(temp_grid) #obsolete print check
  }
  else{
    day_temp <- rep(seq((dTL+dTR)/2,(dBL+dBR)/2,length.out=petri),time=petri)
    night_temp <- rep(seq((nBL+nTL)/2,(nBR+nTR)/2,length.out=petri),each=petri)
    temp_grid <- data.frame(PD_ID=grid,day_temp=day_temp,night_temp=night_temp,average=(day_temp+night_temp)/2,fluc=round(day_temp-night_temp,2),abs_fluc=round(abs(day_temp-night_temp),2),germ=germin)
    head(temp_grid) #obsolete print check
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
  if (toplot=="daytemp"){
    z<-round(day_temp)
    label<-round(z,1)
    tit<-"Day temperatures"
  }
  if (toplot=="nighttemp"){
    z<-round(night_temp)
    label<-round(z,1)
    tit<-"Night temperatures"
  }
  res<-ggplot2::ggplot(temp_grid,aes(night_temp,day_temp,z=z,label=label))+
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
  res
  }

