library(rvest)

job_desc <- list()

for (i in seq(44)){
  mainweb <- paste0("https://www.seek.co.nz/analyst-jobs?page=", i)
  joblist <- read_html(mainweb) %>% 
    html_nodes("article") %>% 
    html_nodes("h1") %>% 
    html_nodes("a") %>% 
    html_attr('href')
  for (job in joblist){
    url <- paste0("https://www.seek.co.nz", job)
    detail_extract <- read_html(url) %>% 
      html_nodes("article") %>% 
      html_text()
    job_desc <- c(job_desc,detail_extract)
  }
}

job_desc_unique <- unique(job_desc)
words <- "'work from home'|wfh|remotely|remote|flexibility|flexible work hours"


f <- 0
for (desc in job_desc_unique){
  i <- length(grep(words, desc, ignore.case = T, value = F))
  f <- f + i
}
f


