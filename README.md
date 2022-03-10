<!-- badges: start -->

[![R-CMD-check](https://github.com/pgomba/thermgRad/workflows/R-CMD-check/badge.svg)](https://github.com/pgomba/thermgRad/actions)

<!-- badges: end -->

# thermgRad

## Tools to visualize and analyze germination in temperature gradient plates

![](images/head_title.png)

`thermgRad` package aims to provide with tools to visualize and analyze germination experiments conducted using a temperature gradient plate (TGP) with a bidirectional setting (day/night cycle) and obtain cardinal temperatures for each of the temperature fluctuations thresholds across the thermal gradient plate.

This package also provides tools to mitigate common misconceptions on temperature analysis such as using TGP temperature settings as canon temperature for the experiment, assumption of corners having the same temperature or use of average temperatures between corners with supposedly equal temperatures.

A TGP set up to run between 5°C and 40°C will rarely achieve these temperatures on the top side of the metal plate and there will be also slight differences between corners intended to be at the same temperature (e.g. if set at 5°C, one of the cold corners might run at 6°C, while the opposite might run at 8°C) . It is thus recommended to log temperatures at the center of all four Petri dishes in each corner. This obviously can´t be done while the experiment is running, but these temperatures can be logged if the TGP runs empty for a few days before and after the experiment. Comparison between these logs is recommended. However, it is standard practice to record temperature on the four corners of the TGP while the experiment is running, which unless corrected, means temperatures used for the analysis are aligned with the left-bottom side of the Petri dish rather than the center of it. This package aims to provide with tools to realign temperatures to fit the center point of the Petri dish.
