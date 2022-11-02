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
  method = "BG trap",
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

###
library("readxl")

# patho 2013
patho_2013 <- read_excel("data/patho_new/03_2013_Mücken-Ergebnisse.xlsx", sheet = 1)
names(patho_2013) <- patho_2013[2, ]
patho_2013_2 <- patho_2013[-c(1:3), ]

# patho 2014
patho_2014 <- read_excel("data/patho_new/03_2014_mücken_overview_results.xlsx", sheet = 1)
names(patho_2014) <- patho_2014[2, ]
patho_2014_2 <- patho_2014[-c(1:2), ]

# patho 2015
patho_2015 <- read_excel("data/patho_new/03_2015_mücken_overview_results.xlsx", sheet = 1)
names(patho_2015) <- patho_2015[2, ]
patho_2015_2 <- patho_2015[-c(1:2), ]

# change comma to dots in latitude and longitude
df$latitude <- as.numeric(gsub(",", ".", gsub("\\.", "", df$latitude)))
df$longitude <- as.numeric(gsub(",", ".", gsub("\\.", "", df$longitude)))

# unique sampling sites per species
df_un <- unique(df[, 1:3])

write.table(df_un, "output/mosquitoes_ger_pa.csv",
  sep = ";", col.names = NA
)
