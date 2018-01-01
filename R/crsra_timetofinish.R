


# This calcualtes the time to finish a course by a student

crsra_timetofinish <- function() {

    finishing <- function(x, y) {
        temp <- x %>%
            dplyr::filter(!is.na(course_progress_ts)) %>%
            dplyr::group_by(jhu_user_id) %>%
            dplyr::summarise(maxtime = max(course_progress_ts), mintime = min(course_progress_ts)) %>%
            dplyr::left_join(y, by = "jhu_user_id") %>%
            dplyr::filter(course_passing_state_id %in% c(1, 2))

        temp2 <- tbl_df(temp)
        temp2$timetofinish <- as.numeric(difftime(temp2$maxtime, temp2$mintime, units="days"))
        return(temp2)

    }

    timetofinish <- purrr::map(1:numcourses, ~ finishing(all_tables[["course_progress"]][[.x]], all_tables[["course_grades"]][[.x]]))
    names(timetofinish) <- coursenames
    return(timetofinish)

}








