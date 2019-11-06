library(leaflet)

  # Dataframe de lojas
  df = data.frame(
    "codigo" 		= c(123,456,789,987,654,321,111,888,555, 444),
    "loja" 		= c("Loja A","Loja B","Loja C","Loja D","Loja E","Loja F","Loja G", "Loja H", "Loja I", "Loja J"),
    "bandeira" 	= c("Bandeira X","Bandeira Y","Bandeira X","Bandeira Y","Bandeira Z","Bandeira X","Bandeira X", "Bandeira Z", "Bandeira Y", "Bandeira Z"),
    "estado" 		= c("SP","SP","SP","SP","SP","SP","SP","SP","SP","SP"),
    "cidade" 		= c("São Paulo","São Paulo","São Paulo","São Paulo","São Paulo","São Paulo","São Paulo","São Paulo","São Paulo","São Paulo"),
    "lat" 		= c(-23.550520, -23.565480, -23.539210, -23.619480, -23.524370, -23.585610, -23.572140, -23.531570, -23.603080, -23.612780),
    "long" 		= c(-46.633308, -46.651570, -46.454300, -46.708580, -46.677200, -46.641720, -46.709280, -46.789890, -46.661580, -46.597240)
  )
  
  # Renomeia as colunas da tabela
  names(df) <- c("Código", "Loja", "Bandeira", "Estado", "Cidade", "Lat", "Long")
  
  quantidadeLojas <- paste(
    "<p>",
    "Quantidade de Lojas:", nrow(df), "</p>"
  )
  
  icon <- awesomeIcons(
    icon = 'shopping-cart',
    markerColor = ifelse(
      test = df$Bandeira == "Bandeira X", 
      yes = "blue", 
      no = ifelse(
        test = df$Bandeira == "Bandeira Y",  
        yes = "red",  
        no = "green"  
      )
    )
  )
  
  m <- leaflet(df) %>% addProviderTiles(providers$Stamen.TonerLite) %>%
    addControl(quantidadeLojas, position = "topright") %>%
    setView(lng = -46.633308, lat = -23.550520, zoom = 9) %>%
    addAwesomeMarkers(~Long, ~Lat, icon = icon, clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = TRUE),
                      popup=~paste0("Loja: ", Loja, "<br>")
    )
  
