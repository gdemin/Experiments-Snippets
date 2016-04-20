options(stringsAsFactors = FALSE)
library(rvest)
library(dplyr)
library(magrittr)
library(stringr)

if (!dir.exists("pages")) dir.create("pages")
ids = c(mobile = 16, soft = 23, photo = 20, os = 22)

for (each in seq_along(ids)){
    id = ids[each]
    root = read_html(sprintf("http://forum.ixbt.com/?id=%s", id), encoding = "cp1251")
    root_text = repair_encoding(html_text(root))
    pages = str_extract_all(root_text, sprintf("id=%s:[\\d]+", id))[[1]] %>% gsub("id=","",.)
    
    counter = 1
    for (each_page in pages){
        Sys.sleep(5)
        page_content = read_html(sprintf("http://forum.ixbt.com/post.cgi?id=print:%s", each_page), encoding = "cp1251")
        page_content %>% 
            html_text %>%
            repair_encoding %>% 
            str_replace_all("document\\.writeln\\(.+?\\)","\\n") %>%
            str_replace_all("([À-ß])"," \\1") %>% 
            str_replace_all("\\s\\s"," ") %>% 
            strsplit("\n") %>%
            extract2(1) %>% 
            extract(-(1:35)) %>% 
            extract(-c(length(.)-1,length(.))) %>% 
            # str_join(collapse = "\n") %>% 
            writeLines(file(sprintf("pages/%s%s.txt", names(ids)[each], counter), encoding = "UTF8") )
        
        counter = counter + 1
        
    }

}