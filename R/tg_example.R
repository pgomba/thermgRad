#' Load example
#'
#' Loads a dataframe which can be used as an example to try out the functions
#'
#' @return an example data frame
#' @export
#'
#' @importFrom readr read_delim
#'
#' @examples
#' df<-tg_example()
#'
tg_example<-function(){
  x<-"https://raw.githubusercontent.com/pgomba/thermgRad/main/data-raw/tg_example.csv?token=GHSAT0AAAAAABRE3LFF7X74F7VPT2P2SNAGYRGROSA"
  read_delim(x, delim = ";",escape_double = FALSE, trim_ws = TRUE)

}

