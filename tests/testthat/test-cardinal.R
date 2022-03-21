original_test_mode <- getOption('thermgRad.test_mode')
options('thermgRad.test_mode' = TRUE)
data<-thermgRad::tg_example

test_that("cardinal works", {
  expect_equal(cardinal(data,5,8,40,38,5,39,6,40,petri=13,fs=0,fe=3), "To = 24.386")
  expect_equal(cardinal(data,0,0,40,40,0,40,0,40,petri=13,fs=0,fe=3), "To = 20.12")
})

options('thermgRad.test_mode' = original_test_mode)

