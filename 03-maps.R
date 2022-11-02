# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read table
df <- read.table("output/mosquitoes_ger_pa.csv", 
                 sep = ";", header = T, row.names = 1)


