library(tidyverse)
library(sf)

## Get limits of PNac Guadarrama
# data from https://www.miteco.gob.es/es/parques-nacionales-oapn/red-parques-nacionales/sig/parques-nacionales.html
pn <- st_read("/Users/ajpelu/Downloads/limites_red/desc_Red_PN_LIM_Enero2023/Limite_PN_p_b.shp")

gnac <- pn |> 
  filter(str_detect(d_Nom_Parq, "Guadarrama")) |> # Ojo existen 2, uno es la zona de Especial Proteccion
  filter(d_Nom_Parq == "Parque Nacional de la Sierra de Guadarrama")

st_write(gnac, "data/geoinfo/pnac_guadarrama_limites.shp")

## Get limits of Pnat Guadarrama (Castilla y Leon)
# Data from https://datosabiertos.jcyl.es/web/jcyl/set/es/medio-ambiente/la-red-espacios-naturales-cyl/1284687312196

cl <- st_read("/Users/ajpelu/Downloads/ps.ren_cyl/ps.ren_cyl.shp")

gnat <- cl |> 
  filter(str_detect(nombre, "Guadarrama")) |> 
  filter(nombre == "Sierra Norte de Guadarrama") 

st_write(gnat, "data/geoinfo/pnat_guadarrama_limites.shp")

## ZEPAS 
# data from: https://www.miteco.gob.es/es/biodiversidad/servicios/banco-datos-naturaleza/informacion-disponible/rednatura_2000_desc.html
# Según esto https://sig.mapama.gob.es/Docs/PDFServicios/RedNatura2000.pdf A=ZEPA, B=ZEC/LIC C= ZEC/LIC + ZEPA
rnat <- st_read("/Users/ajpelu/Downloads/rn2000-shp/Es_Lic_SCI_Zepa_SPA_Medalpatl_202401.shp") |> 
  filter(AC %in% c("CASTILLA Y LEÓN", "COMUNIDAD DE MADRID")) |> 
  mutate(tipo_name = case_when(
    TIPO == "A" ~ "ZEPA", 
    TIPO == "B" ~ "ZEC/LIC", 
    TIPO == "C" ~ "ZEPA y ZEC/LIC")
    )
    
st_write(rnat, "data/geoinfo/red_natura.shp")





