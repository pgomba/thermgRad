
<!-- README.md is generated from README.Rmd. Please edit that file -->

# thermgRad

<!-- badges: start -->

[![R-CMD-check](https://github.com/pgomba/thermgRad/workflows/R-CMD-check/badge.svg)](https://github.com/pgomba/thermgRad/actions)
<!-- badges: end -->

## Tools to visualize and analyze germination in temperature gradient plates

![](images/head_title.png)

`thermgRad` package aims to provide with tools to visualize and analyze
germination experiments conducted using a temperature gradient plate
(TGP) with a bidirectional setting (day/night cycle) and obtain cardinal
temperatures for each of the temperature fluctuations thresholds across
the thermal gradient plate.

## Installation

You can install the development version of thermgRad from
[GitHub](https://github.com/) with:

``` r
#install.packages("devtools")
#devtools::install_github("pgomba/thermgRad") 
library(thermgRad)
```

## What data does the package require?

Temperature: `thermgRad` needs average day and night corner
temperatures. These are better recorded with an external temperature
logger, since temperatures on the top side of the plate differ from
those used in the TGP settings. If possible, I think is better to record
corner temperatures in the center of each corner Petri dish (either log
the temperature before or after the experiment). But `thermgRad`
provides the necessary tools to transform corner temperatures to corner
Petri dish center temperatures (which depends on Petri dish cover
radio).

<img src="images/scheme.png" width="672"/>

Germination: `thermgRad` requires, for each Petri dish:

-   Petri dish ID

-   Cumulative germination

-   Total number of seeds in the Petri dish (germinated + moldy + viable
    after cut test)

-   Day for each germination record

The data frame format containing all this information is a bit
restrictive, but an example to how it should be formatted prior to load
the data frame can be seen running the following code:

``` r
View(thermgRad::tg_example) 
#or
head(thermgRad::tg_example)
#>   DAYS 4 5 6 7  8  9 10 11 12 13 14 15 16 17 18 20 22 24 26 28 30 32 35 38 42
#> 1   A1 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
#> 2   A2 0 0 0 0  0  1  1  2  3  3  3  3  3  4  6  6  7  8  9 10 10 11 11 11 11
#> 3   A3 0 0 0 2  3  6  7  7  9  9  9 11 11 11 11 13 13 14 14 14 14 15 15 15 15
#> 4   A4 0 0 2 5  7  9  9 10 10 11 11 11 11 11 12 12 12 13 13 13 13 13 13 13 13
#> 5   A5 0 0 2 5 11 12 13 14 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15
#> 6   A6 0 0 0 4 11 14 14 14 14 14 15 15 15 15 16 16 16 16 16 16 16 16 16 16 16
#>   45 48 total
#> 1  0  0    20
#> 2 11 14    20
#> 3 15 15    20
#> 4 14 14    19
#> 5 15 16    20
#> 6 16 16    20
```
