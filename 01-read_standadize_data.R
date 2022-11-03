# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# libraries
library("readxl")
library("tidyr")

# read culimo data
bni1 <- read.csv("data/culimo/culbase_bni.csv", sep = ";")
cvo1 <- read.csv("data/culimo/culbase_cvo.csv", sep = ";")
gfs1a <- read.csv("data/culimo/Culimo GFS2015.csv", sep = ";")
gfs1b <- read.csv("data/culimo/Culimo GFS2016.csv", sep = ";")
gfs1c <- read.csv("data/culimo/Culimo GFS2017.csv", sep = ";")

# merged data.frame
df_culimo <- data.frame(
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
  n_traps = 1,
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

# change comma to dots in latitude and longitude
df_culimo$latitude <- as.numeric(gsub(",", ".", gsub("\\.", "", df_culimo$latitude)))
df_culimo$longitude <- as.numeric(gsub(",", ".", gsub("\\.", "", df_culimo$longitude)))


# patho 2009
patho_2009 <- read_excel("data/pathosurveillance/Belegung Mücken-Freezer.xlsx", sheet = 2)
patho_2009_2 <- patho_2009[-1,]

# patho 2010
patho_2010 <- read_excel("data/pathosurveillance/Belegung Mücken-Freezer.xlsx", sheet = 3)
patho_2010_2 <- patho_2010[-1,]

# patho 2011
patho_2011 <- read_excel("data/pathosurveillance/Belegung Mücken-Freezer.xlsx", sheet = 4)
patho_2011_2 <- patho_2011[-1,]

# patho 2012
patho_2012 <- read_excel("data/pathosurveillance/Belegung Mücken-Freezer.xlsx", sheet = 5)
patho_2012_2 <- patho_2012[-1,]

# patho 2013
patho_2013 <- read_excel("data/pathosurveillance/03_2013_Mücken-Ergebnisse.xlsx", sheet = 1)
names(patho_2013) <- patho_2013[2, ]
patho_2013_2 <- patho_2013[-c(1:3), ]

# patho 2014
patho_2014 <- read_excel("data/pathosurveillance/03_2014_mücken_overview_results.xlsx", sheet = 1)
names(patho_2014) <- patho_2014[2, ]
patho_2014_2 <- patho_2014[-c(1:2), ]

# patho 2015
patho_2015 <- read_excel("data/pathosurveillance/03_2015_mücken_overview_results.xlsx", sheet = 1)
names(patho_2015) <- patho_2015[2, ]
patho_2015_2 <- patho_2015[-c(1:2), ]

# patho 2016
patho_2016 <- read_excel("data/pathosurveillance/Mückenliste_2016.xlsx", sheet = 1)


# df_culimo
df_patho <- data.frame(
  site = c(
    patho_2009_2$Standort,
    patho_2010_2$Standort,
    patho_2011_2$Standort,
    patho_2012_2$Standort,
    patho_2013_2$Gebiet,
    patho_2014_2$`Gebiet/Area`,
    patho_2015_2$`Gebiet/Area`,
    patho_2016$site
  ),
  method = "BG trap",
  species = c(
    patho_2009_2$Art,
    patho_2010_2$Art,
    patho_2011_2$Art,
    patho_2012_2$Art,
    patho_2013_2$Gattung,
    patho_2014_2$Gattung,
    patho_2015_2$Gattung,
    patho_2016$taxon
  ),
  sex = "female",
  number = c(
    patho_2009_2$Individuenanzahl,
    patho_2010_2$Individuenanzahl,
    patho_2011_2$Individuenanzahl,
    patho_2012_2$Individuenanzahl,
    patho_2013_2$Poolgröße,
    patho_2014_2$Poolgröße,
    patho_2015_2$Poolgröße,
    patho_2016$specimens
  )
)

sum(as.numeric(df_patho$number), na.rm = T)
sum(as.numeric(df_culimo$number), na.rm = T)

# unique sampling sites per species
df_un <- unique(df_patho[, c(1, 3, 5)])

GPS <- read.table("data/final_gps_table_newu.csv", sep = ";", header = T)
dimnames(GPS)[[2]] <- c(
  "row_no", "old", "site",
  "x", "y",
  "method"
)
df_patho2 <- merge(df_un, GPS, by = "site")
table(is.na(df_patho2$x))

#
df_all <- data.frame(
  latitude = c(
    df_culimo$latitude,
    df_patho2$y
  ),
  longitude = c(
    df_culimo$longitude,
    df_patho2$x
  ),
  species = c(
    df_culimo$species,
    df_patho2$species
  ),
  number = c(
    df_culimo$number,
    df_patho2$number
  )
)

# write table
write.table(df_all, "output/mosquitoes_ger_pa.csv",
  sep = ";", col.names = NA
)
