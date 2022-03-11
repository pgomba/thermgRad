<!-- badges: start -->

[![R-CMD-check](https://github.com/pgomba/thermgRad/workflows/R-CMD-check/badge.svg)](https://github.com/pgomba/thermgRad/actions)

<!-- badges: end -->

# thermgRad

## Tools to visualize and analyze germination in temperature gradient plates

![](images/head_title.png)

`thermgRad` package aims to provide with tools to visualize and analyze germination experiments conducted using a temperature gradient plate (TGP) with a bidirectional setting (day/night cycle) and obtain cardinal temperatures for each of the temperature fluctuations thresholds across the thermal gradient plate.

## Installation

```{r}
install.packages("devtools")
devtools::install_github("pgomba/thermgRad") 
library(thermgRad)
```

## What data does the package require?

Temperature: `thermgRad` needs average day and night corner temperatures. These are better recorded with an external temperature logger, since temperatures on the top side of the plate differ from those used in the TGP settings. If possible, I think is better to record corner temperatures in the center of each corner Petri dish (either log the temperature before or after the experiment). But `thermgRad` provides the necessary tools to transform corner temperatures to corner Petri dish center temperatures (which depends on Petri dish cover radio).

<img src="images/scheme.png" width="672"/>

Germination: `thermgRad` requires, for each Petri dish:

-   Petri dish ID

-   Cumulative germination

-   Total number of seeds in the Petri dish (germinated + moldy + viable after cut test)

-   Day for each germination record

The data frame format containing all this information is a bit restrictive, but an example to how it should be formatted prior to load the data frame can be seen running the following code:

```{r}
View(thermgRad::tg_example)
```
