test_that("T50 ", {
  expect_equal(coolbear(seq(1,10,1),c(0,0,0,0,0,6,10,15,18,20),20),7)
  expect_equal(round(coolbear(seq(1,10,1),c(0,0,0,0,0,6,12,15,18,20),20),3),6.667)
  expect_equal(coolbear(seq(1,10,1),c(0,0,0,0,0,6,6,6,6,9),20),NA)
  expect_equal(coolbear(c(2,4,6,8,10,12,14,16,18,20,22,24,26,28,30),c(13,13,15,15,16,16,16,16,16,16,16,16,16,16,16),25),1))
})
