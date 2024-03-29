% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/petri_grid.R
\name{petri_grid}
\alias{petri_grid}
\title{Obtain T50, Germination Rate for each Petri dish in the thermal gradient}
\usage{
petri_grid(x)
}
\arguments{
\item{x}{A data.frame, probably imported from an excel spreadsheet. See details for formatting}
}
\value{
A data frame with thermal plate T50 and GR values
}
\description{
This function transform an excel spreadshit cumulative germination data from every Petri dish into a grid containing petri dish label, T50 and Germination rate. See details to format the input data correctly. The last column must be the total number of viable seeds of each petri dish (germinated + fresh & mouldy after cut test). It does not have to be (necessarily) a 13 by 13 Petri dish grid
}
\details{
Input for this function is a data frame with this format. Please note this table has a header and is relevant for the function for "Days" to be the header and not a row. This is because thermal plate germination data is probably recorded in a excel spreadsheet with this format\tabular{lccccccccr}{
   Day \tab 1 \tab 3 \tab 6 \tab 8 \tab 12 \tab 15 \tab 17 \tab 22 \tab Total \cr
   A1 \tab 0 \tab 0 \tab 0 \tab 6 \tab 10 \tab 12 \tab 17 \tab 17 \tab 21 \cr
   A2 \tab 0 \tab 0 \tab 0 \tab 3 \tab 10 \tab 10 \tab 10 \tab 11 \tab 19 \cr
   A3 \tab 0 \tab 0 \tab 0 \tab 3 \tab 4 \tab 5 \tab 5 \tab 5 \tab 20 \cr
   A4 \tab 0 \tab 12 \tab 15 \tab 15 \tab 18 \tab 20 \tab 20 \tab 20 \tab 20 \cr
   ... \tab ... \tab ... \tab ... \tab ... \tab ... \tab ... \tab ... \tab ... \tab ... \cr
   M11 \tab 0 \tab 0 \tab 0 \tab 8 \tab 13 \tab 14 \tab 17 \tab 19 \tab 20 \cr
   M12 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \tab 5 \tab 8 \tab 20 \tab 20 \cr
   M13 \tab 0 \tab 0 \tab 0 \tab 1 \tab 5 \tab 10 \tab 10 \tab 15 \tab 21 \cr
}
}
