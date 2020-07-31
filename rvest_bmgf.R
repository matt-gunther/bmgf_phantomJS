rm(list=ls())
library(rvest)
library(here)
library(readr)
library(dplyr)
setwd(here("R/bmgf"))

URLs <- ""

for(i in 1:84){
  # i <- 1
  js <- readr::read_lines("bmgf.js")
  page <- paste("page",i,sep="=")
  js[9] <- gsub(js[9], pattern = "page=2", rep= page)
  write(x = js, file = "temp.js")
  system("./phantomjs temp.js")
  
  read_html("bmgf.html")%>%
    html_nodes(".serif a") %>%
    html_attr("href") %>%
    append(x = URLs) -> URLs
}
URLs <- URLs[-1]
URLs <- URLs[-which(URLs == "#")]

lapply(URLs, function(URL){
  paste("https://www.gatesfoundation.org", URL, sep="")
}) -> URLs

CSS <- c(".articleWrapper h2", "#bodyregion_0_interiorarticle_0_lblDate",  "#bodyregion_0_interiorarticle_0_lblPurpose", "#bodyregion_0_interiorarticle_0_lblAmount", "#bodyregion_0_interiorarticle_0_lblTerm", "#bodyregion_0_interiorarticle_0_lblTopic", "#bodyregion_0_interiorarticle_0_lblRegion", "#bodyregion_0_interiorarticle_0_lblProgram", "#bodyregion_0_interiorarticle_0_lblLocation", "#bodyregion_0_interiorarticle_0_lblSite a")

grantees <- data.frame("grantee_name" = character(),
                       "date"= character(),	
                       "purpose"= character(),	
                       "amount"= character(),
                       "term"= character(),
                       "topic"= character(),
                       "regions_served"= character(),
                       "program"= character(),
                       "grantee_location"= character(),
                       "grantee_website"= character(),
                       stringsAsFactors=FALSE
                       )

###################################
# Scraping fields on each page listed in URLs
####################################
for(pg in 1:length(URLs)){
# for(pg in 1:10){
  new_row <- lapply(CSS, function(field){
    read_html(as.character(URLs[pg])) %>%
      html_nodes(field)%>%
      html_text() 
    })
  new_row[which(lapply(new_row, length) == 0)] <- NA
  names(new_row) <- names(grantees)
  grantees <- bind_rows(new_row, grantees)
  print(paste(pg,"/",length(URLs)))
  }

grantees
library(xlsx)
xlsx::write.xlsx(grantees, file = "bmgf.xlsx")
