# This renders a table showing average course grade of male/female individuals

crsra_gradesummary <- function(groupby = "total") {
    message("Note that maximum grade possible is 1.")

    grading <- function(x, y, z) {
        temp <- z %>%
            dplyr::left_join(x, by=partner_user_id, `copy`=TRUE) %>%
            dplyr::left_join(y, by=partner_user_id, `copy`=TRUE) %>%
            dplyr::filter(!is.na(course_grade_overall))
        if (groupby == "total") {
            temp %>%
                dplyr::summarise(AvgGrade=mean(course_grade_overall))
        } else if (groupby == "gender"){
            temp %>%
                dplyr::filter(!is.na(reported_or_inferred_gender)) %>%
                dplyr::group_by(reported_or_inferred_gender) %>%
                dplyr::summarise(AvgGrade=mean(course_grade_overall)) %>%
                dplyr::arrange(desc(AvgGrade))
        } else if (groupby == "education"){
            temp %>%
                dplyr::filter(!is.na(educational_attainment)) %>%
                dplyr::group_by(educational_attainment) %>%
                dplyr::summarise(AvgGrade=mean(course_grade_overall)) %>%
                dplyr::arrange(desc(AvgGrade))
        } else if (groupby == "stustatus") {
            temp %>%
                dplyr::filter(!is.na(student_status)) %>%
                dplyr::group_by(student_status) %>%
                dplyr::summarise(AvgGrade=mean(course_grade_overall)) %>%
                dplyr::arrange(desc(AvgGrade))
        } else if (groupby == "empstatus") {
            temp %>%
                dplyr::filter(!is.na(employment_status)) %>%
                dplyr::group_by(employment_status) %>%
                dplyr::summarise(AvgGrade=mean(course_grade_overall)) %>%
                dplyr::arrange(desc(AvgGrade))
        } else if (groupby == "country") {
            temp %>%
                dplyr::filter(!is.na(country_cd)) %>%
                dplyr::group_by(country_cd) %>%
                dplyr::filter(n() >= 100) %>%
                dplyr::summarise(AvgGrade=mean(course_grade_overall)) %>%
                dplyr::arrange(desc(AvgGrade))
        } else {
            message("Please enter a valid value for 'groupby' attribute. Possible values are total, gender, education, stustatus, empstatus, and country.")
        }
    }

    gradetable <- purrr::map(1:numcourses, ~ grading(all_tables[[.x]][["course_memberships"]], all_tables[[.x]][["course_grades"]], all_tables[[.x]][["users"]]))
    names(gradetable) <- coursenames
    return(gradetable)
}
