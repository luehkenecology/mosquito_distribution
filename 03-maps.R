# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# libraries
library(geodata)

# read table
df <- read.table("output/mosquitoes_ger_pa.csv", 
                 sep = ";", header = T, row.names = 1)

# map germany
germany <- getData('GADM', country='DEU', level=1)

# 
plot(germany)





