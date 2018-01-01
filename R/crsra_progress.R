
crsra_progress <- function(){
    proceedstatus <- readline("The following procedure to import your data may take a while since the table course_progress is likely to be large. Do you want to proceed? (y/n): ")
    if (proceedstatus == "y") {

        # this is for ordering course items withing lessons and modules
        ordering <- function(x, y, z) {
            temp <<- x %>%
                dplyr::left_join(y, by = "course_lesson_id", `copy`=TRUE) %>%
                dplyr::left_join(z, by = "course_module_id", `copy`=TRUE) %>%
                dplyr::arrange(course_module_order, course_lesson_order, course_item_order) %>%
                dplyr::mutate(item_rank = row_number())
        }

        itemorder <<- purrr::map(1:numcourses, ~ ordering(all_tables[[.x]][["course_items"]], all_tables[[.x]][["course_lessons"]], all_tables[[.x]][["course_modules"]]))

        progress <- function(x, y){

            temp <- x %>%
                dplyr::filter(!is.na(course_progress_ts)) %>%
                dplyr::group_by(.[[3]]) %>% # 3 is the index of the column referring to partner_user_id
                dplyr::filter(course_progress_ts == max(course_progress_ts)) %>% # only to record the last activity
                dplyr::left_join(y, by = "course_item_id", `copy`=TRUE) %>% # so that we know the name of the course item
                dplyr::group_by(item_rank) %>%
                dplyr::summarise(Total=n()) %>%
                dplyr::arrange(desc(Total)) %>%
                dplyr::mutate(Share=round(Total/sum(Total), 2)) %>%
                dplyr::left_join(y, by = "item_rank") %>%
                dplyr::select(item_rank, Total, Share, course_item_name, course_lesson_name, course_module_name)
            }

        last_activity <- purrr::map(1:numcourses, ~ progress(all_tables[[.x]][["course_progress"]], itemorder[[.x]]))
        names(last_activity) <- coursenames
        return(last_activity)

    }
}





