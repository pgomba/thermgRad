data<-thermgRad::tg_example

test_that("plot_results works", {
  plot<-plot_results(data,3,6,40,38,4,39,7,40,petri=13,method = "precise",toplot="average")
  expect_equal(plot$data$fluc[5], 21.67)
  expect_equal(plot$labels$title, "Average temperature")

  plot2<-plot_results(data,3,6,40,38,4,39,7,40,petri=13,method = "precise",toplot="fluctuation")
  expect_equal(plot2$data$germ[20], 89.47368,tolerance = 0.00001)
  expect_equal(plot2$labels$title, "Temperature fluctuation")

})
