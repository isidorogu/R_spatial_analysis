###################################
# Cargando librerias 
####################################
library(tidyverse)
library(pacman)


pacman::p_load(sf, hrbrthemes, lwgeom, rnaturalearth, maps, mapdata, 
               spData, tigris, tidycensus, leaflet, tmap, tmaptools)

library(maps)

states<-map_data("france")
  
ggplot(states, aes(long, lat, group = group))+geom_polygon(fill = "blue")

worldcities<-maps::world.cities

mexico<-
  world.cities %>% 
  filter(country.etc == "Mexico")


ggplot(mexico, aes(long, lat, group = country.etc))+geom_polygon(fill = "white")


mexico_estatal<-st_read("areas_geoestadisticas_estatales.shp")


ggplot(mexico_estatal)+geom_sf(fill = "lightsteelblue")+theme_bw()+geom_sf(data = mexico_estatal_centroide)

mexico_estatal_centroide<-mexico_estatal %>% st_centroid()
