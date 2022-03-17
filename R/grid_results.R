#' Generate grid with results
#'
#' Taking into account thermal gradient plate corner temperatures this function return a data frame with day and night temperatures for each petri dish, their average temperature, the temperature fluctuation or the final germination %. Using the "precise" method returns a more accurate estimate of temperatures across the thermal plate, while with the adjust parameter is possible to estimate the temperature at the center of each Petri dish
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
#' @param adjust use "adjust=TRUE" to adjust temperature to Petri dish center.
#'
#'
#' @return A data frame with day and night temperatures, average temperature and temperature fluctuation for each Petri dish
#' @export
#'
#' @examples
#' data<-tg_example
#' grid_results(data, 0,3,40,38,0,38,2,39, petri=13)
#'
#'
grid_results<-function(x ="Template with cumulative germination data",
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
                       adjust="adjust temperature to center of Petri dish"){

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
  }else
    {
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
  temp_grid
  }else{
  day_temp <- rep(seq((dTL+dTR)/2,(dBL+dBR)/2,length.out=petri),time=petri)
  night_temp <- rep(seq((nBL+nTL)/2,(nBR+nTR)/2,length.out=petri),each=petri)
  temp_grid <- data.frame(PD_ID=grid,day_temp=day_temp,night_temp=night_temp,average=(day_temp+night_temp)/2,fluc=round(day_temp-night_temp,2),abs_fluc=round(abs(day_temp-night_temp),2),germ=germin)
  temp_grid
 }
}
