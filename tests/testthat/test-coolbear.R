test_that("T50 ", {
  expect_equal(coolbear(seq(1,10,1),c(0,0,0,0,0,6,10,15,18,20),20),7)
  expect_equal(round(coolbear(seq(1,10,1),c(0,0,0,0,0,6,12,15,18,20),20),3),6.667)
  expect_equal(coolbear(seq(1,10,1),c(0,0,0,0,0,6,6,6,6,9),20),NA)
})
