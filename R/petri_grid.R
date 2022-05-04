#' Obtain T50, Germination Rate for each Petri dish in the thermal gradient
#'
#' This function transform an excel spreadshit cumulative germination data from every Petri dish into a grid containing petri dish label, T50 and Germination rate. See details to format the input data correctly. The last column must be the total number of viable seeds of each petri dish (germinated + fresh & mouldy after cut test). It does not have to be (necessarily) a 13 by 13 Petri dish grid
#'
#' @param x A data.frame, probably imported from an excel spreadsheet. See details for formatting
#'
#' @return A data frame with thermal plate T50 and GR values
#' @export
#' @details
#' Input for this function is a data frame with this format. Please note this table has a header and is relevant for the function for "Days" to be the header and not a row. This is because thermal plate germination data is probably recorded in a excel spreadsheet with this format
#'
#' | Day       | 1           | 3           | 6           | 8           | 12          | 15           | 17           | 22          | Total  |
#' | ------------- |:-------------:|:-------------:|:-------------:| :-------------:| :-------------:| :-------------:| :-------------:| :-------------:|  -----:|
#' | A1      | 0 | 0 | 0 | 6 | 10 | 12 | 17 | 17 | 21 |
#' | A2      | 0 | 0 | 0 | 3 | 10 | 10 | 10 | 11 | 19 |
#' | A3      | 0 | 0 | 0 | 3 | 4 | 5 | 5 | 5 | 20 |
#' | A4      | 0 | 12 | 15 | 15 | 18 | 20 | 20 | 20 | 20 |
#' | ...      | ... | ... | ... | ... | ... | ... | ... | ... | ... |
#' | M11      | 0 | 0 | 0 | 8 | 13 | 14 | 17 | 19 | 20 |
#' | M12      | 0 | 0 | 0 | 1 | 1 | 5 | 8 | 20 | 20 |
#' | M13      | 0 | 0 | 0 | 1 | 5 | 10 | 10 | 15 | 21 |
#' @md
#' @importFrom dplyr select mutate cur_data
#' @importFrom utils head tail
#' @importFrom rlang .data

petri_grid<-function(x){
  .=NULL
  germination<-(x)|>
    select(ncol(x)-1,ncol(x))|>
    mutate(germ=(cur_data()[[1]]/cur_data()[[2]])*100)|>
    select(.data$germ)

  days<-colnames(x)|>
    head(-1)|>
    tail(-1)|>
    as.numeric()

  germ_list<-(x)|>
    select(-1,-ncol(x))|>
    as.matrix()

  n<-(x)|>
    select(ncol(x))

  t50<-vector()

  GR<-vector()

  for (i in 1:nrow(germ_list)) {
    new_value<-coolbear(days,as.vector(germ_list[i,]),n[[i,1]])
    t50 <- c(t50, new_value)
    GR<-c(GR,1/new_value)
  }
  let<-rep(LETTERS[seq(from=1,to=sqrt(nrow(x)))],each=sqrt(nrow(x))) #vector with as many letters as columns/rows
  PD_ID<-paste0(let,1:sqrt(nrow(x)))
  data.frame(PD_ID,germination,t50,GR)
}
