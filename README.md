
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
<center>
<img src="images/scheme.png" width="672"/>
</center>

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
```

## Functions

### How is T<sub>50</sub> calculated?

T<sub>50</sub> values are obtained via `thermgRad::coolbear`, a function
adapting Coolbear et al. (1984) formula modified by Farooq et al.(2005).
<center>
<img src="images/coolbformula.png"/>
</center>

where N represents the number of sowed seeds (germinated + viable +
moldy) from a single replicate in all the experiments and n<sub>i</sub>
and n<sub>j</sub> are the number of seeds germinated adjacently to (N/2)
at time t<sub>i</sub> and t<sub>j</sub> respectively. An example:

``` r
scoring_days<-c(seq(1,20,2))
cumulative_germination<-c(0,0,0,6,7,12,18,23,23,23)
total_seeds<-25

thermgRad::coolbear(scoring_days,cumulative_germination,total_seeds) #Outputs T50
#> [1] 11.16667
```

Among other things, `thermgRad::petri_grid` loops `thermgRad::coolbear`
all over the template data frame to obtain T<sub>50</sub> values for
each Petri dish

### Visualizing your experiment

`thermgRad::plot_results` collects your experiments results and
temperatures and collects them on a Day/Night graph. It´s possible to
choose between showing average Petri dish temperature, average
temperature fluctuation and germination with parameter
`toplot= "average`,`toplot= "fluctuation`or`toplot= "germina"`.

``` r
data<-thermgRad::tg_example
thermgRad::plot_results(data, 0,0,40,40,0,40,0,40, petri=13, toplot= "germina")
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />
Input `?plot_results` in the R console for a list of parameters.
`0,0,40,40,0,40,0,40` refers to corner temperatures. The first four
number belong to daytime temperatures (Bottom left, Bottom right, Top
left and Top right) followed by nighttime temperatures (again, Bottom
left, Bottom right, Top left and Top right). `thermgRad:plot_results`
assumes you want to use average temperature between corners (e.g. If
during daytime the bottom left corner runs at 5°C, and the bottom right
corner runs at 8°C, the function will use 6.5°C). Enabling
`method="precise"` within the function creates a more accurate
temperature grid. The graph wont look as pretty, but analysis of
cardinal temperatures will be more accurate (which is the one that
matters).

``` r
data<-thermgRad::tg_example
thermgRad::plot_results(data, 0,3,40,38,0,38,2,39, petri=13, toplot= "fluctuation",method="precise")
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />
