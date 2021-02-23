library(rgee)
library(sf)
library(raster)
library(dplyr)
library(rgdal)
library(leaflet)
library(leaflet.extras)
library(rgee)
library(mapview)
library(tmap)
library(tmaptools)
library(mapview) 
library(tidyverse)
setwd("C:/Users/Usuario/Desktop/Mapas_R/")
dir <- "C:/Users/Usuario/Desktop/Mapas_R/"
list_shp <- list.files(dir,pattern = ".shp")
colonia <- read_sf("amapolar_wgs84.shp")
colonia_sp <- colonia %>% as_Spatial()
names <- colonia$Uso_Suelo %>% unique()
n1 <- names[1]
n2 <- names[2]
n3 <- names[3]
names1 <- colonia[colonia$Uso_Suelo=="Vivienda",] %>% unique()
Colores <- c("#a6cee3", "#1f78b4", "#b2df8a") 
color_html <- colorFactor(Colores,domain=names)
color1 <- c("#a6cee3")
color2 <- c("#1f78b4")
color3 <- c("#b2df8a")
color1_html_1 <- colorFactor(color1,domain=n1)
color2_html_2 <- colorFactor(color2,domain=n2)
color3_html_3 <- colorFactor(color3,domain=n3)
#vistas filtradas
filtro <- colonia %>% dplyr::filter(Uso_Suelo=="Vivienda") %>% as_Spatial()
filtro2 <- colonia %>% dplyr::filter(Uso_Suelo=="Baldio") %>% as_Spatial()
filtro3 <- colonia %>% dplyr::filter(Uso_Suelo== "Urbanizacion")  %>% as_Spatial()

#mapa vista 
map1 <- leaflet() %>% addTiles() %>% addPolygons(data = filtro,
                                                fillColor = topo.colors(1,alpha = NULL),
                                                weight = 0.5,
                                                label =  ~Uso_Suelo,
                                                popup = ~Area,
                                                group = "Viviendas") 
map2 <- map1 %>% addPolygons(data = filtro2,
                             fillColor = topo.colors(2,alpha = NULL),
                             weight = 0.5,
                             label =  ~Uso_Suelo,
                             popup = ~Area,
                             group = "Baldio") 
map3 <- map2 %>% addPolygons(data = filtro3,
                             fillColor = topo.colors(4,alpha = NULL),
                             weight = 0.5,
                             label =  ~Uso_Suelo,
                             popup = ~Area,
                             group = "Urbanizacion") 
map_final <- map3 %>% addDrawToolbar(targetGroup = "tablas", 
                                     editOptions = editToolbarOptions(selectedPathOptions = selectedPathOptions())) %>% 
                                     addLayersControl(overlayGroups = c("Viviendas","Baldio","Urbanizacion","tablas"),
                                     options = layersControlOptions(collapsed = TRUE))  

