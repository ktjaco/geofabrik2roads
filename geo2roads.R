library(plyr)
library(dplyr)
library(sp)
library(raster)
library(rgeos)
library(spatstat)
library(rgdal)     
library(maptools)

#gather urls for provinces/territories
urls <- c("http://download.geofabrik.de/north-america/canada/alberta-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/british-columbia-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/manitoba-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/new-brunswick-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/newfoundland-and-labrador-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/northwest-territories-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/nova-scotia-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/nunavut-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/ontario-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/prince-edward-island-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/quebec-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/saskatchewan-latest-free.shp.zip",
          "http://download.geofabrik.de/north-america/canada/yukon-latest-free.shp.zip")

#destination folder
dest <- c("C:/temp/alberta-latest-free.shp.zip",
          "C:/temp/british-columbia-latest-free.shp.zip",
          "C:/temp/manitoba-latest-free.shp.zip",
          "C:/temp/new-brunswick-latest-free.shp.zip",
          "C:/temp/newfoundland-and-labrador-latest-free.shp.zip",
          "C:/temp/northwest-territories-latest-free.shp.zip",
          "C:/temp/nova-scotia-latest-free.shp.zip",
          "C:/temp/nunavut-latest-free.shp.zip",
          "C:/temp/ontario-latest-free.shp.zip",
          "C:/temp/prince-edward-island-latest-free.shp.zip",
          "C:/temp/quebec-latest-free.shp.zip",
          "C:/temp/saskatchewan-latest-free.shp.zip",
          "C:/temp/yukon-latest-free.shp.zip")

#download osm shp files
for(i in seq_along(urls)){
  
  download.file(urls[i], dest[i], mode="wb")
  
}

#create list of zip files
zipFiles <- list.files(path = "C:/temp/", pattern = "*.zip", full.names = TRUE)

#unzip files
for(i in zipFiles){
 
  output <- gsub(".zip", "", i)
  
  dir.create(output)
  
  unzip(i, exdir = output, overwrite = FALSE)
  
  newZip <- list.files(path=output, full.names=TRUE)
  
}

#read shp files
ab <- readOGR(dsn = "C:/temp/alberta-latest-free.shp", layer = "gis.osm_roads_free_1")
bc <- readOGR(dsn = "C:/temp/british-columbia-latest-free.shp", layer = "gis.osm_roads_free_1")
mb <- readOGR(dsn = "C:/temp/manitoba-latest-free.shp", layer = "gis.osm_roads_free_1")
nb <- readOGR(dsn = "C:/temp/new-brunswick-latest-free.shp", layer = "gis.osm_roads_free_1")
nl <- readOGR(dsn = "C:/temp/newfoundland-and-labrador-latest-free.shp", layer = "gis.osm_roads_free_1")
nt <- readOGR(dsn = "C:/temp/northwest-territories-latest-free.shp", layer = "gis.osm_roads_free_1")
ns <- readOGR(dsn = "C:/temp/nova-scotia-latest-free.shp", layer = "gis.osm_roads_free_1")
nu <- readOGR(dsn = "C:/temp/nunavut-latest-free.shp", layer = "gis.osm_roads_free_1")
on <- readOGR(dsn = "C:/temp/ontario-latest-free.shp", layer = "gis.osm_roads_free_1")
pe <- readOGR(dsn = "C:/temp/prince-edward-island-latest-free.shp", layer = "gis.osm_roads_free_1")
qc <- readOGR(dsn = "C:/temp/quebec-latest-free.shp", layer = "gis.osm_roads_free_1")
sk <- readOGR(dsn = "C:/temp/saskatchewan-latest-free.shp", layer = "gis.osm_roads_free_1")
yk <- readOGR(dsn = "C:/temp/yukon-latest-free.shp", layer = "gis.osm_roads_free_1")

#combine shp files
canada <- rbind(ab, bc, mb, nb, nl, nt, ns, nu, on, pe, qc, sk, yk)

canada_roads <- subset(canada, !fclass %in% c('bridgeway',
                                              'cycleway',
                                              'footway',
                                              'path',
                                              'steps'))

writeOGR(obj = canada_roads, dsn = "C:/temp/Canada_Roads.shp", layer = "Canada_Roads", driver="ESRI Shapefile")
