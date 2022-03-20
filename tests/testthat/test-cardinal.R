data<-thermgRad::tg_example

test_that("cardinal works", {
  expect_equal(thermgRad::cardinal(data,0,0,40,40,0,40,0,40,petri = 13,fs=0,fe=3), 'To = 20.12')
})
