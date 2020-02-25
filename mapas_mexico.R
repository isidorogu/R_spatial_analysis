# 
library(tidyverse)
library(data.table)
library(maps)
library(sf)
library(leaflet)
library(tmap)
library(tmaptools)
library(spData)

# Cargando el archivo de mapas estatales 
mexico_estatal<-st_read("./mapas_estatales")

# Mapa con el plot basico
plot(mexico_estatal)

ggplot(mexico_estatal)+geom_sf()

mexico_municipal<-st_read("./mapas_municipales")


ggplot(mexico_municipal)+geom_sf()+geom_sf(data= mexico_estatal) + theme_bw()


mexico_localidades<-st_read("./mapas_localidades_rurales_urbanas")

ggplot(mexico_localidades)+geom_sf(aes(group = CVE_ENT))


rm(mexico_localidades)

load("~/Banorte/Productividad Sucursales/Analisis/Bases/base_con_latlon.RData")
rm(banamex, santander)



ggplot(mexico_estatal)+geom_sf()+geom_point(data = bancomer, aes(lon, lat))

bancomer<-st_as_sf(bancomer, coords = c("lon", "lat"))


ggplot(bancomer)+geom_point(aes(lon, lat))

bancomer<-
  bancomer %>% 
  filter(lon< -88 , lat > 10)


mexico_estatal<-st_transform(mexico_estatal, crs = 4326)

summary(bancomer$lat)
summary(bancomer$lon)









  ?tm_shape
tm_shape(mexico_estatal)+tm_borders()+tm_dots()+tm_fill(col = "lightsteelblue")+tm_style("classic")

zoom_chiapas<-st_bbox(mexico_estatal %>% filter(NOM_ENT == "Chiapas")) %>% st_as_sfc()

mapa<-tm_shape(mexico_estatal)+tm_polygons()+tm_shape(zoom_chiapas)+tm_polygons()

library(grid)

print(mapa, vp = viewport(0.8,0.26), width = 0.5, height = 0.5)

ggplot(bancomer)+geom_point(aes(lat, lon))+geom_sf(data = mexico_estatal)

bancomer<-
  bancomer %>% 
  mutate(NOM_ENT = str_to_lower(ESTADO))

bancomer<-
  bancomer %>%
  group_by(NOM_ENT) %>%
  arrange(NOM_ENT) %>%
  mutate(n_sucursales = n())


bancomer$CVE_ENT<-group_indices(bancomer, bancomer$n_sucursales)

bancomer<-
  bancomer %>% 
  mutate(CVE_ENT = as_factor(as.character(CVE_ENT)))

bancomer<-
  left_join(bancomer, mexico_estatal, by = "CVE_ENT")


tm_sh

bancomer<-st_as_sf(bancomer)

tm_shape(bancomer)+tm_polygons()+tm_dots()
