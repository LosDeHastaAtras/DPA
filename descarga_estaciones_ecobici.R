library(RJSONIO)

# client_id = "577_4jumf047jam88ksscgkk84sgskwgws0w8ooo4gw84kswk4kokg"
# client_secret = "1c6nfmvo702s008w0o8gw008k80c8cskogcs0w08s4k0wcokog"

URL_acces_token <- "https://pubsbapi.smartbike.com/oauth/v2/token?client_id=577_4jumf047jam88ksscgkk84sgskwgws0w8ooo4gw84kswk4kokg&client_secret=1c6nfmvo702s008w0o8gw008k80c8cskogcs0w08s4k0wcokog&grant_type=client_credentials"

acces_token_list <- fromJSON(RCurl::getURL(URL_acces_token))

acces_token <- acces_token_list$access_token
refresh_token <- acces_token_list$refresh_token

URL_estaciones <- paste0(
  "https://pubsbapi.smartbike.com/api/v1/stations.json?access_token=",
  acces_token
)
dir <- fromJSON(RCurl::getURL(URL_estaciones))

lista_estaciones <- lapply(1:length(dir$stations), function(i) {
  datos_estacion <- dir$stations[[i]]
  cols <- c(
    datos_estacion$id,
    datos_estacion$name,
    datos_estacion$address,
    ifelse(is.null(datos_estacion$zipCode), NA, datos_estacion$zipCode),
    ifelse(is.null(datos_estacion$districtCode), NA, datos_estacion$districtCode),
    ifelse(is.null(datos_estacion$districtName), NA, datos_estacion$districtName),
    datos_estacion$location[1],
    datos_estacion$location[2]
  )
  return(cols)
})

df_estaciones <- as.data.frame(do.call("rbind", lista_estaciones))

