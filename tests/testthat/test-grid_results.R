#input

data<-thermgRad::tg_example
petri<-13
dayBL<-5
dayBR<-7
dayTL<-40
dayTR<-39
nightBL<-5
nightBR<-39
nightTL<-7
nightTR<-39

#functions
let<-rep(LETTERS[seq(from=1,to=petri)],each=petri)
grid<-paste0(let,1:petri)
n_horiz_down<-((abs(nightBL-nightBR)/petri)*-sign(nightBL-nightBR))/2
n_verti_right<-((abs(nightBR-nightTR)/petri)*-sign(nightBR-nightTR))/2
d_verti_left<-((abs(dayBL-dayTL)/petri)*-sign(dayBL-dayTL))/2
nBR<-nightBR-n_horiz_down+n_verti_right

test_that("grid_results works", {
  expect_equal(let[8], "A")
  expect_equal(grid[21],"B8")
  expect_equal(d_verti_left,1.346154, tolerance=0.000001)
  expect_equal(nBR,37.69231, tolerance=0.00001)
    })
