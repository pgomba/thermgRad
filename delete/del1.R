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

library(thermgRad)
tg_example
x <- load("https://github.com/pgomba/thermgRad/blob/main/data-raw/tg_example.R")
y <- read.csv(text = x)

library(readxl)
temp2 <- read_excel("C:/Users/Pablo/Desktop/rose/temp2.xlsx")
write.csv2(temp2,"temp2.csv")


library(readr)
temp2 <- read_delim("https://raw.githubusercontent.com/pgomba/thermgRad/main/data-raw/tg_example.csv?token=GHSAT0AAAAAABRE3LFF7X74F7VPT2P2SNAGYRGROSA", delim = ";",
                    escape_double = FALSE, trim_ws = TRUE)
View(temp2)
View(temp2)

dput(temp2)

cardinal(a,1,4)

a<-x
library(tidyr)
library(thermgRad)
library(dplyr)
library(tidyverse)
library(devtools)
install()

