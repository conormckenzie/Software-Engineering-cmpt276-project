course_urls <- readLines("http://code.sfu.ca/undergrad/course-outlines/course-outlines-1181.html")
course_urls <- course_urls[grep(".*outlines\\.html.*", course_urls)]
course_urls <- gsub(".*(www\\.sfu.*[a-z][0-9][0-9][0-9]).*", "\\1", course_urls)
course_urls <- course_urls[grep(".*(www\\.sfu.*[a-z][0-9][0-9][0-9]).*", course_urls)]
#add "HTTPS"
course_urls <- paste("https://",course_urls)
#remove blank
course_urls <- gsub("[[:blank:]]", '', course_urls)

#initialize data frame
course_data <- data.frame(url=character(), number=character(), term=character(), 
                          textbook=character(), ISBN=character(),stringsAsFactors = FALSE)

#Read html and store them into data frame "course_data"
scrape_html <- function(html){
  
  course_page=suppressWarnings(readLines(html))
  number <- gsub("[[:blank:]]*<h1 id=\\\"name\\\">([A-Za-z0-9]*[[:blank:]][0-9]*)[[:blank:]]*-[[:blank:]]([A-Z]*[[:blank:]][0-9]*).*", "\\2", course_page[grep("<h1 id=\"name\">.*</h1>", course_page)])
  
  term <- gsub("[[:blank:]]*<h1 id=\\\"name\\\">([A-Za-z0-9]*[[:blank:]][0-9]*)[[:blank:]]*-[[:blank:]]([A-Z]*[[:blank:]][0-9]*).*", "\\1", course_page[grep("<h1 id=\"name\">.*</h1>", course_page)])
  
  reading_block <- grep("READING", course_page)
  
  reading <- course_page[as.numeric(reading_block):as.numeric(reading_block+10)]
  reading <- toString(reading)
  #remove HTML tags
  reading <- gsub("<[^>]*>", "", reading)
  #remove commas
  reading <- gsub(",", '', reading)
  #remove blanks
  reading <- gsub("[[:blank:]]{2,}",'', reading)
  #remove "required Reading
  reading <- gsub("REQUIRED READING:", '', reading)
  
  #remove ISBN
  ISBN <- gsub(".*ISBN:[[:blank:]]([0-9]*)","\\1", reading)
  reading <- gsub("&amp;", "", reading)
  reading <- gsub("(.*)ISBN:[[:blank:]]([0-9]*)", "\\1", reading)
  return(c(html, number, term, reading, ISBN))
}

for(i in seq(0:length(course_urls))){
  try(course_data[nrow(course_data)+1,] <- scrape_html(course_urls[i]), silent=TRUE)
}

write.csv(course_data, file="books.csv")
