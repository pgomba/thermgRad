data<-thermgRad::tg_example

test_that("petri_grid works", {
  expect_equal(thermgRad::petri_grid(data)[2,2], 70)
})
