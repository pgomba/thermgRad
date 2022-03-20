library(testthat)

data<-thermgRad::tg_example

cardinal<-function(data="template dataframe",
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
                   fs= "lower thershold of fluctuation values",
                   fe= "higher threshold of fluctuation values"){
  grid<-petri_grid(data)
  temp<-grid_results(data,dayBL,dayBR,dayTL,dayTR,nightBL,nightBR,nightTL,nightTR,petri,method,adjust)
  grid_temp<-left_join(grid,temp,by="PD_ID")%>%
    filter(between(.data$fluc,fs,fe))%>%
    drop_na()

  print(grid_temp)

  show(ggplot(grid_temp,aes(x=.data$average,y=.data$GR))+
         geom_point(size=5))


  selectGR <- 7

  put_sub<-replace(grid_temp$GR,1:selectGR-1,"sub")
  put_supra<-replace(put_sub,(selectGR+1):length(put_sub),"supra")
  grid_temp$cardinal_labels<-replace(put_supra,selectGR,"both")

  sub_sum<-summary(lm(data=grid_temp,GR~average,subset=(cardinal_labels=="sub"|cardinal_labels=="both")))
  sub_a<-sub_sum$coefficients[2,1] #ax + b
  sub_b<-sub_sum$coefficients[1,1]
  supra_sum<-summary(lm(data=grid_temp,GR~average,subset=(cardinal_labels=="supra"|cardinal_labels=="both")))
  supra_a<-supra_sum$coefficients[2,1] #ax + b
  supra_b<-supra_sum$coefficients[1,1]

  inter<-(supra_b-sub_b)/(sub_a-supra_a) #y=y

  eq_sub<- paste0("Suboptimal eq: y = ",round(sub_a,3),"x",ifelse(sign(sub_b==1), " + ", " - "),round(sub_b,3),", R.rsq = ",round(sub_sum$r.squared,3), ", p-value = ",round(sub_sum$coefficients[2,4],4))
  eq_supra<- paste0("Supraoptimal eq: y = ",round(supra_a,3),"x",ifelse(sign(supra_b==1), " + ", " - "),round(supra_b,3),", R.rsq = ",round(supra_sum$r.squared,3), ", p-value = ",round(supra_sum$coefficients[2,4],4))

  show(ggplot(grid_temp,aes(x=.data$average,y=.data$GR,colour=.data$cardinal_labels))+
         scale_color_manual(values=c("Green","#377EB8","#880808"))+
         geom_point(size=4,shape=21,fill="White",stroke=2)+
         stat_function(fun = function(x) sub_a*x + sub_b, geom='line',xlim=c(((-sub_b)/sub_a),inter+1),colour = "#377EB8",linetype = 1,size=1)+
         stat_function(fun = function(x) supra_a*x + supra_b, geom='line',xlim=c(inter-1,((-supra_b)/supra_a)),colour = "#880808",linetype = 1,size=1)+
         scale_y_continuous(limits = c(0,max(grid_temp$GR*1.2)))+
         scale_x_continuous(limits = c(((-sub_b)/sub_a)-1,((-supra_b)/supra_a)+1))+
         theme_classic()+
         geom_hline(yintercept = 0,linetype = 5)+
         labs(colour="Germ. rate", x="Average temperature", y="Germination rate")+
         theme(text = element_text(size=16))
  )

  print(eq_sub)
  print(eq_supra)
  print(paste("Tb =",round((-sub_b)/sub_a),3))
  print(paste("Tc =",round((-supra_b)/supra_a),3))
  print(paste("To =",round(inter,3)))

}

test_that("cardinal works", {
  expect_equal(thermgRad::cardinal(data,0,0,40,40,0,40,0,40,petri = 13,fs=0,fe=3), 'To = 20.12')
})
