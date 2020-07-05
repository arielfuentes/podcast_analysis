#parameters
library(tibble)
library(dplyr)
source("code/get_data.R", encoding = "UTF-8")
alias <- c("VeC", "UNO", "MdG", "MChig")
elem <-  c(".icon-micro", ".icon-stair")
url <- c('https://cl.ivoox.com/es/podcast-vida-cristo-ipch_sq_f1870725_1.html', 
         "https://cl.ivoox.com/es/podcast-iglesia-uno_sq_f1805492_1.html",
         "https://cl.ivoox.com/es/podcast-mar-gracia_sq_f1874313_1.html",
         "https://cl.ivoox.com/es/podcast-mision-chiguayante_sq_f1399540_1.html")

values <- lapply(X = elem, 
                 FUN = function(x) lapply(X = url, 
                                          FUN = function(y) pod_rnk_stat(x, y)
                 )
)
names(values) <- elem
rnk_df <- tibble(podcast = alias, 
                 `n episod` = unlist(values[[1]]), 
                 ranking = unlist(values[[2]])
) %>%
  mutate(idx = ranking*`n episod`/100000) %>%
  arrange(idx)

VeC <- pod_raw("Vida en Cristo_Ipch") %>%
  mutate(tipo_epis = case_when(str_detect(name, "Estudio") == T ~ "Estudio Bíblico",
                                          str_detect(name, "El Nos") == T ~ "Devocional",
                                          TRUE ~ "Sermón")
         )
