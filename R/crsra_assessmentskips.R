
# This renders a table that shows the share of male/female individuals and their skipping categories.
crsra_assessmentskips <- function(bygender = FALSE, wordcount = TRUE, n = 20) {
    
    skippers <- function(x, y, z) {
        temp <- z %>% 
            dplyr::left_join(x, by="jhu_user_id", `copy`=TRUE) %>%
            dplyr::left_join(y, by="jhu_user_id", `copy`=TRUE) %>%
            dplyr::filter(!is.na(peer_skip_type))
        
        if (bygender == TRUE) {
            temp %>%
                dplyr::filter(!is.na(reported_or_inferred_gender)) %>% 
                dplyr::group_by(peer_skip_type, reported_or_inferred_gender) %>%
                dplyr::summarise(n = n()) %>%
                dplyr::mutate(freq = n / sum(n))   
        } else {
            temp %>%
                dplyr::group_by(peer_skip_type) %>%
                dplyr::summarise(n = n()) %>%
                dplyr::mutate(freq = n / sum(n)) 
        }
                
    }
    skiptable <- purrr::map(1:numcourses, ~ skippers(all_tables[["course_memberships"]][[.x]], all_tables[["peer_skips"]][[.x]], all_tables[["users"]][[.x]]))
    names(skiptable) <- coursenames
    
    if (wordcount == TRUE) {
        stopwords <- corpora("words/stopwords/en")$stopWords
        
        word_cloud <- function(x) {
            x <- tbl_df(x)
            words <- tibble::tibble(title = x$peer_comment_text) %>%
                unnest_tokens(word, title) %>%
                dplyr::filter(!word %in% stopwords) %>%
                dplyr::count(word, sort = TRUE)
            list(knitr::kable(words[1:n,]))
            
        }
        
        word_count <- purrr::map(1:numcourses, ~ word_cloud(all_tables[["peer_comments"]][[.x]]))
        names(word_count) <- coursenames
        
        return(list(skiptable, word_count))
    } else {
        return(skiptable)
    }

}


# afinn <- get_sentiments("afinn")
# gh <- tbl_df(all_tables[["peer_comments"]][[1]])
# sentiment_score <- tibble::tibble(title = gh$peer_comment_text) %>%
#     dplyr::mutate(saved_title = title) %>%
#     unnest_tokens(word, title) %>%
#     dplyr::inner_join(afinn) %>%
#     dplyr::group_by(saved_title) %>%
#     dplyr::summarize(sentiment = sum(score)) %>%
#     dplyr::filter(!is.na(sentiment))


