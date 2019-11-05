library(leaflet)

df = data.frame(
  "codigo" 		= c(123,456,789,987,654,321,111,888,555, 444),
  "loja" 		= c("Loja A","Loja B","Loja C","Loja D","Loja E","Loja F","Loja G", "Loja H", "Loja I", "Loja J"),
  "bandeira" 	= c("Bandeira X","Bandeira Y","Bandeira X","Bandeira Y","Bandeira Z","Bandeira X","Bandeira X", "Bandeira Z", "Bandeira Y", "Bandeira Z"),
  "valor" 		= c(158847.7,76374.8,131559.5,43526.3,69344.8,85491.7,140182.8,43834.6,53368.7,43467.8),
  "lucro" 		= c(15884.7,7637.4,13155.9,4352.6,6934.4,8549.1,1318.2,1383.4,5336.8,4346.7),
  "lat" 		= c(-23.550520, -23.565480, -23.539210, -23.619480, -23.524370, -23.585610, -23.572140, -23.531570, -23.603080, -23.612780),
  "long" 		= c(-46.633308, -46.651570, -46.454300, -46.708580, -46.677200, -46.641720, -46.709280, -46.789890, -46.661580, -46.597240)
)

quantidadeLojas <- paste(
  "<h3>Lojas - Vendas Por Bandeira</h3>",
  "<p>Quantidade de Lojas:", nrow(df), "</p>",
  "<p><small>Obs: Cor da circunferência = Bandeira <br /> Diâmetro = Valor de Vendas</small></p>"
)

pal <- colorFactor(c("blue", "red", "green"), domain = c("Bandeira X", "Bandeira Y", "Bandeira Z"))

m <- leaflet(df) %>% addProviderTiles(providers$CartoDB.Positron) %>%
  addControl(quantidadeLojas, position = "topright") %>%
  setView(lng = -46.633308, lat = -23.550520, zoom = 11) %>%
  addCircleMarkers(
    radius = ~valor/10000,
    color = ~pal(bandeira),
    stroke = FALSE, fillOpacity = 0.5,
    popup=~paste0("<div style='text-align:center; margin-top:15px;'><h2 style='color:#44C993;'>", loja, " - ", codigo,"</h2><i>", bandeira, "</i>" 
                  , "<div style='background-color:#F9F9F9; margin-top: 20px;'>"
                  , "<p style='border-bottom:2px solid white; padding: 10px; margin: 0;'>", "<b>Vendas:</b> R$ ", formatC(valor, format = "f", digits = 1), "</p>"
                  , "<p style='border-bottom:2px solid white; padding: 10px; margin: 0;'>","<b>Lucro:</b> R$ ", formatC(lucro, format = "f", digits = 1), "</p>"
                  , "<p style='border-bottom:2px solid white; padding: 10px; margin: 0;'>","<b>Margem PDV:</b> ",  paste0(formatC(100 * (lucro/valor), format = "f", digits = 1), "%"), "</p>"
                  , "</div>"
                  , "<nav id='menu' style='text-align:center; margin-top:20px; margin-bottom:5px; font-weight:bold; border-top: 1px solid #f0f0f0; padding-top: 10px;'>
										    <ul style='padding:0px;margin:0px;list-style:none;'>
										        <li style='display: inline;'><a href='' target = '_parent' style='padding: 5px 15px;display: inline-block;color: black;text-decoration: none; background-color: #44C993; color: white;'>Vendas</a></li>
												<li style='display: inline;'><a href='' target = '_parent' style='padding: 5px 15px;display: inline-block;color: black;text-decoration: none; background-color: #44C993; color: white;'>Tendência</a></li>
										        <li style='display: inline;'><a href='' target = '_parent' style='padding: 5px 15px;display: inline-block;color: black;text-decoration: none; background-color: #44C993; color: white;'>Ficha</a></li>
										    </ul>
										</nav>"
                  ,"</div>"
    )
  ) %>%
  addLegend("bottomright", pal = pal, values = ~bandeira,
            title = "Bandeiras",
            opacity = 1
  )
