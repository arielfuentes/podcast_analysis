source("code/wrg_dt.R", encoding = "UTF-8")
library(rmarkdown)
render(input = "code/AE Podcast VeC.Rmd", 
       output_file =  "Análisis_Podcast_VeC.html", 
       output_dir = "output/", 
       encoding = "utf-8")
