#' Frequencies of skipping an peer-assessed submission
#'
#' @param bygender A logical value indicating whether results should be broken down by gender
#' @param wordcount A logical value indicating whether word count should be shown in the results; default is true
#' @param n An integer indicating the number of rows for the word count
#' @return The outputs are frequency tables (tibble).and are shown for each specific course
#' @examples
#' crsra_assessmentskips(example_course_import)
#' crsra_assessmentskips(example_course_import, bygender = TRUE, n = 10)
#' @export
#' @importFrom rcorpora corpora
#' @importFrom tibble tibble
#' @importFrom tidytext unnest_tokens
#' @importFrom knitr kable

# This renders a table that shows the share of male/female individuals and their skipping categories...
crsra_assessmentskips <- function(
    all_tables,
    bygender = FALSE, wordcount = TRUE, n = 20) {

    partner_user_id = attributes(all_tables)$partner_user_id
    all_tables = course_to_coursera_import(all_tables)
    numcourses = length(all_tables)
    coursenames = names(all_tables)

    skippers <- function(x, y, z) {
        temp <- z %>%
            dplyr::left_join(x, by=partner_user_id, `copy`=TRUE) %>%
            dplyr::left_join(y, by=partner_user_id, `copy`=TRUE) %>%
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
    skiptable <- purrr::map(1:numcourses, ~ skippers(all_tables[[.x]][["course_memberships"]], all_tables[[.x]][["peer_skips"]], all_tables[[.x]][["users"]]))
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

        word_count <- purrr::map(1:numcourses, ~ word_cloud(all_tables[[.x]][["peer_comments"]]))
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


