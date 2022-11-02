# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read culimo data
bni1 <- read.csv("data/culimo/culbase_bni.csv", sep = ";")
cvo1 <- read.csv("data/culimo/culbase_cvo.csv", sep = ";")
gfs1a <- read.csv("data/culimo/Culimo GFS2015.csv", sep = ";")
gfs1b <- read.csv("data/culimo/Culimo GFS2016.csv", sep = ";")
gfs1c <- read.csv("data/culimo/Culimo GFS2017.csv", sep = ";")

# merged data.frame
df <- data.frame(
  latitude = c(
    bni1$S_Latitude,
    cvo1$S_Latitude,
    gfs1a$S_Latitude,
    gfs1b$S_Latitude,
    gfs1c$S_Latitude
  ),
  longitude = c(
    bni1$S_Longitude,
    cvo1$S_Longitude,
    gfs1a$S_Longitude,
    gfs1b$S_Longitude,
    gfs1c$S_Longitude
  ),
  species = c(
    bni1$V_SpeciesName,
    cvo1$V_SpeciesName,
    gfs1a$V_SpeciesName,
    gfs1b$V_SpeciesName,
    gfs1c$V_SpeciesName
  ),
  sex = c(
    bni1$V_GenderName,
    cvo1$V_GenderName,
    gfs1a$V_GenderName,
    gfs1b$V_GenderName,
    gfs1c$V_GenderName
  ),
  number = c(
    bni1$V_AnimalCount,
    cvo1$V_AnimalCount,
    gfs1a$V_AnimalCount,
    gfs1b$V_AnimalCount,
    gfs1c$V_AnimalCount
  )
)

write.table(df, "output/mosquitoes_ger_pa.csv", sep = ";", col.names = NA)
