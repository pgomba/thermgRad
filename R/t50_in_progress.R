#' Find and plot cardinal temperatures
#'
#' Find and plot cardinal temperatures after selecting a temperature fluctuation threshold
#'
#' @param data A template dataframe
#' @param fs Lower fluctuation threshold
#' @param fe Higher fluctuation thresholds
#'
#' @return A plot with cardinal temperatures
#' @export
#' @importFrom dplyr left_join filter between
#' @importFrom ggplot2 geom_point stat_function scale_y_continuous
#' @importFrom tidyr drop_na
#' @importFrom methods show
#' @importFrom stats lm
#' @examples
cardinal<-function(data="template dataframe",
                   fs= "lower thershold of fluctuation values",
                   fe= "higher threshold of fluctuation values"){
  grid<-petri_grid(data)
  temp<-tempgrad(0,0,40,40,0,40,0,40,petri = 13)
  grid_temp<-left_join(grid,temp,by="PD_ID")%>%
    filter(between(fluc,fs,fe))%>%
    drop_na()

  print(grid_temp)

  show(ggplot(grid_temp,aes(x=average,y=GR))+
    geom_point(size=5))


  selectGR <- as.numeric(readline(prompt="Enter common temperature PD_ID number: "))

  put_sub<-replace(grid_temp$GR,1:selectGR-1,"sub")
  put_supra<-replace(put_sub,(selectGR+1):length(put_sub),"supra")
  grid_temp$cardinal_labels<-replace(put_supra,selectGR,"both")

  summary(lm(data=grid_temp,GR~average,subset=(cardinal_labels=="sub"|cardinal_labels=="both")))
  summary(lm(data=grid_temp,GR~average,subset=(cardinal_labels=="supra"|cardinal_labels=="both")))

  ggplot(grid_temp,aes(x=average,y=GR))+
    geom_point(size=5)+
    stat_function(fun = function(x) 0.006045*x + 0.051165, geom='line',xlim=c(10,29),colour = "#377EB8",linetype = 1,size=1)+
    stat_function(fun = function(x) -0.010718*x + 0.361416, geom='line',xlim=c(10,29),colour = "#377EB8",linetype = 1,size=1)+
    scale_y_continuous(limits = c(0,0.3))

}


