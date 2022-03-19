#input
data<-thermgRad::tg_example

test_that("grid_results works", {
  expect_equal(grid_results(data, 0,3,40,38,0,38,2,39, petri=13)[5,5], 25.5)
  expect_equal(grid_results(data, 0,3,40,38,0,38,2,39, petri=13)[10,4], 5.9375)
  expect_equal(grid_results(data, 0,3,40,38,0,38,2,39, petri=13,method="precise")[10,4], 5.25)
  expect_equal(grid_results(data, 0,3,40,38,0,38,2,39,method="precise",adjust=TRUE, petri=13)[43,3], 11.49519,tolerance = 0.00001)


  })
5.9375
