data<-thermgRad::tg_example
germin<-((data[ncol(data)-1])/(data[ncol(data)]))*100
test_that("plot results is doing fine", {
  expect_equal(nrow(germin), 169)
})
