pod_raw <- function(pdc){
  #libraries
  library(spotifyr)
  library(tibble)
  library(dplyr)
  #api connection
  Sys.setenv(SPOTIFY_CLIENT_ID = '####')
  Sys.setenv(SPOTIFY_CLIENT_SECRET = '####')
  access_token <- get_spotify_access_token()
  #get podcast
  podcast <- search_spotify(pdc, 
                            type = "episode", 
                            market = "cl", 
                            include_meta_info = T,
                            limit = 50)
  as_tibble(podcast$episodes$items) %>%
    select(description, duration_ms, name, release_date) %>%
    na.omit() %>%
    arrange(release_date) %>%
    mutate(dur_min = duration_ms/60000, 
           release_date = as.Date.character(release_date, format = "%Y-%m-%d"), 
           Mes = months(release_date), 
           Año = as.numeric(format(release_date,'%Y'))
           ) 
    
}

pod_rnk_stat <- function(elem, url){
  #libraries
  library(rvest)
  library(stringr)
  library(xml2)
  #get value
  extr_elem(elem, url)
}

extr_elem <- function(elem, url){
  #library
  library(stringr)
  #get value
  as.numeric(
    str_trim(
      unique(
        html_text(
          html_nodes(read_html(url),
                     elem
                     )
          )
        ),
      side = "both"
      )
  )
}
