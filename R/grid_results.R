devtools::document()
devtools::check()

data<-tg_example

head(grid_results(data,0,2,40,39,0,40,3,41,petri=13,method = "precise",adjust = TRUE))
