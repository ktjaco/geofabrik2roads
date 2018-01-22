# geofabrik2shp

R Script to download and extract Canada OSM data, specifically road networks suitable for vehicles.

[Reference documentation](http://download.geofabrik.de/osm-data-in-gis-formats-free.pdf)

## Install Packages
**CKAN**

Some of these packages are not required, but it is ok to install them for future R GIS related tasks.

```R
install.packages(c("plyr","dplyr","sp","raster","rgeos","spatstat","rgdal","maptools"))
```

* plyr
* dplyr
* sp
* raster
* rgeos
* spatstat
* rgdal
* maptools

## Run
```sh
$ Rscript geo2roads.R
```
