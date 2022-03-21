data<-thermgRad::tg_example

test_that("plot_results works", {
  plot<-plot_results(data,3,6,40,38,4,39,7,40,petri=13,method = "precise",toplot="average")
  expect_equal(plot$data$fluc[5], 21.67)
  expect_equal(plot$labels$title, "Average temperature")

  plot2<-plot_results(data,3,6,40,38,4,39,7,40,petri=13,method = "precise",toplot="fluctuation")
  expect_equal(plot2$data$germ[20], 89.47368,tolerance = 0.00001)
  expect_equal(plot2$labels$title, "Temperature fluctuation")

  plot3<-plot_results(data,3,6,40,38,4,39,7,40,petri=13,method = "precise",adjust=TRUE,toplot="germina")
  expect_equal(plot3$data$PD_ID[28], "C2")
  expect_equal(plot3$labels$title, "Germination %")

  plot4<-plot_results(data,3,6,40,38,4,39,7,40,petri=13,toplot="daytemp")
  expect_equal(plot4$data$PD_ID[40], "D1")
  expect_equal(plot4$labels$title, "Day temperatures")

  plot5<-plot_results(data,3,6,40,38,4,39,7,40,petri=13,toplot="nighttemp")
  expect_equal(plot5$labels$title, "Night temperatures")

})
