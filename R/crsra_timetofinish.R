#' Time that took each learner (in days) to finish a course
#'
#' @return A table containing \code{hashed_user_id}s with a column indicating the time (in days) that took each user to complete a course. The time is calculated as the difference between the last and first activity in the a course.
#' @examples
#' crsra_timetofinish()
#' @export crsra_timetofinish
#'
crsra_timetofinish <- function() {

    finishing <- function(x, y) {
        temp <- x %>%
            dplyr::filter(!is.na(course_progress_ts)) %>%
            dplyr::group_by(jhu_user_id) %>%
            dplyr::summarise(maxtime = max(course_progress_ts), mintime = min(course_progress_ts)) %>%
            dplyr::tbl_df() #%>%
            #dplyr::left_join(tbl_df(y), by=jhu_user_id, `copy`=TRUE) %>%
            #dplyr::filter(course_passing_state_id %in% c(1, 2))

        temp2 <- tbl_df(temp)
        temp2$timetofinish <- as.numeric(difftime(temp2$maxtime, temp2$mintime, units="days"))
        return(temp2)

    }

    timetofinish <- purrr::map(1:numcourses, ~ finishing(all_tables[[.x]][["course_progress"]], all_tables[[.x]][["course_grades"]]))
    names(timetofinish) <- coursenames
    return(timetofinish)

}


# temp <- all_tables[[1]][["course_progress"]] %>%
#     dplyr::filter(!is.na(course_progress_ts)) %>%
#     dplyr::group_by(jhu_user_id) %>%
#     dplyr::summarise(maxtime = max(course_progress_ts), mintime = min(course_progress_ts)) %>%
#     dplyr::tbl_df()
#     dplyr::left_join(tbl_df(all_tables[[1]][["course_grades"]]), by=jhu_user_id, `copy`=TRUE) %>%
#     dplyr::filter(course_passing_state_id %in% c(1, 2))
#
#
#     temp2 <- tbl_df(temp)
#     temp2$timetofinish <- as.numeric(difftime(temp2$maxtime, temp2$mintime, units="days"))
#     return(temp2)


