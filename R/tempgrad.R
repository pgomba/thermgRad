#' Generate temperature gradient grid
#'
#' Taking into account thermal gradient plate corner temperatures this function return a data frame with the temperatures of each petri dish. Using the "precise" method returns a more accurate estimate of temperatures accross the thermal plate, while with the adjust parameter is possible to estimate the temperature at the center of each Petri dish
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
#' @return A dataframe with day and night temperatures for each thermal gradient plate
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
  if (method=="precise"){
    print("Work in progress. Try later!")
  }
  else{
  day_temp<-rep(seq((dayBL+dayBR)/2,(dayTL+dayTR)/2,length.out=petri),each=petri)
  night_temp<-rep(seq((nightBL+nightTL)/2,(nightBR+nightTR)/2,length.out=petri),times=petri)
  data.frame(day_temp,night_temp)
  }
}
