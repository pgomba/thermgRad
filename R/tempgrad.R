#' Generate temperature gradient grid
#'
#' Taking into account thermal gradient plate corner temperatures this function return a data frame with day and night temperatures for each petri dish, their average temperature and the temperature fluctuation. Using the "precise" method returns a more accurate estimate of temperatures across the thermal plate, while with the adjust parameter is possible to estimate the temperature at the center of each Petri dish
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
#' @return A data frame with day and night temperatures, average temperature and temperature fluctuation for each Petri dish
#' @export
#'
#' @examples
#' tempgrad(dayBL=0,dayBR=0,dayTL=40,dayTR=40,nightBL=0,nightBR=40,nightTL=0,nightTR=40,petri=13)
#'
tempgrad<-function(dayBL="Diurnal bottom left temperature",
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
    v_day<-vector()
    v_night<-vector()
    for (i in 1:petri) {
      day_temp<-seq(day_top_row[i],day_bot_row[i],length.out=petri)
      night_temp<-seq(night_top_row[i],night_bot_row[i],length.out=petri)
      v_day <- c(v_day, day_temp)
      v_night<-c(v_night,night_temp)
    }
    data.frame(PD_ID=grid,day_temp=v_day,night_temp=v_night,average=(v_day+v_night)/2,fluctuation=round(abs(v_day-v_night),2))
  }
  else{
  day_temp<-rep(seq((dayTL+dayTR)/2,(dayBL+dayBR)/2,length.out=petri),time=petri)
  night_temp<-rep(seq((nightBL+nightTL)/2,(nightBR+nightTR)/2,length.out=petri),each=petri)
  data.frame(PD_ID=grid,day_temp=day_temp,night_temp=night_temp,average=(day_temp+night_temp)/2,fluctuation=round(abs(day_temp-night_temp),2))
  }
}
