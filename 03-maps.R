# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# libraries
library(raster)
library(sp)

# read table
df <- read.table("output/mosquitoes_ger_pa.csv",
  sep = ";", header = T, row.names = 1
)

# read map germany
germany <- getData("GADM", country = "DEU", level = 1)

# coordinates
df_xy <- data.frame(
  x = df$longitude,
  y = df$latitude
)

# SpatialPointsDataFrame file
points_all_recent <- SpatialPointsDataFrame(
  coords = df_xy[!is.na(df_xy[, 1]), ],
  data = df[!is.na(df_xy[, 1]), ],
  proj4string = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 ")
)

# fig sampling sites
png(
  file = "figs/sampling_sites.png", width = 4, height = 6.5,
  units = "in", res = 1000
)
plot(germany)
plot(points_all_recent, pch = 19, add = T)
dev.off()
