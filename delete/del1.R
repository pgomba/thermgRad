library(devtools)
library(ggplot2)
library(magrittr)
library(dplyr)

build()

document()

check()
?devtools::check

install()

library(thermgRad)

use_pipe()
use_github_actions()

usethis::use_data_raw(name = 'tg_example')
build_manual(path = getwd())
