#' The share of learners in each course based on specific characteristics.
#'
#' @param groupby A character string indicating the how to break down learners in each course. The default is set to \code{roles} and returns the share of students in each category such as Learner, Not Enrolled, Pre-Enrolled Learner, Mentor, Browser, and Instructor. Other values are \code{country} (for grouping based on country), \code{language} (for grouping based on language), \code{gender} (for grouping by gender), \code{education} (for grouping by education level), \code{stustatus} (for grouping by student status), \code{empstatus} (for grouping by employment status), and \code{country} (for grouping by country). Note that this grouping uses the entries in the table \code{users} that is not fully populated so by grouping you lose some observations.
#' @return A table which indicates the total number and the share of students in each group for each course
#' @examples
#' crsra_memebershares(groupby = country)
#'


crsra_membershares <- function(groupby = "roles") {
     membershares <- function(x, z) {
         temp <- z %>%
             dplyr::left_join(x, by=partner_user_id, `copy`=TRUE)
         if (groupby == "roles") {
             temp %>%
                 dplyr::filter(!is.na(course_membership_role)) %>%
                 dplyr::group_by(course_membership_role) %>%
                 dplyr::summarise(Total=n()) %>%
                 dplyr::mutate(Share=round(Total/sum(Total),2)) %>%
                 dplyr::arrange(desc(Total))
         } else if (groupby == "country") {
             temp %>%
                 dplyr::filter(!is.na(country_cd)) %>%
                 dplyr::group_by(country_cd) %>%
                 dplyr::summarise(Total=n()) %>%
                 dplyr::mutate(Share=round(Total/sum(Total),2)) %>%
                 dplyr::arrange(desc(Total))
         } else if (groupby == "language") {
             temp %>%
                 dplyr::filter(!is.na(profile_language_cd)) %>%
                 dplyr::group_by(profile_language_cd) %>%
                 dplyr::summarise(Total=n()) %>%
                 dplyr::mutate(Share=round(Total/sum(Total),2)) %>%
                 dplyr::arrange(desc(Total))
         } else if (groupby == "gender") {
             temp %>%
                 dplyr::filter(!is.na(reported_or_inferred_gender)) %>%
                 dplyr::group_by(reported_or_inferred_gender) %>%
                 dplyr::summarise(Total=n()) %>%
                 dplyr::mutate(Share=round(Total/sum(Total),2)) %>%
                 dplyr::arrange(desc(Total))
         } else if (groupby == "empstatus") {
             temp %>%
                 dplyr::filter(!is.na(employment_status)) %>%
                 dplyr::group_by(employment_status) %>%
                 dplyr::summarise(Total=n()) %>%
                 dplyr::mutate(Share=round(Total/sum(Total),2)) %>%
                 dplyr::arrange(desc(Total))
         } else if (groupby == "education") {
             temp %>%
                 dplyr::filter(!is.na(educational_attainment)) %>%
                 dplyr::group_by(educational_attainment) %>%
                 dplyr::summarise(Total=n()) %>%
                 dplyr::mutate(Share=round(Total/sum(Total),2)) %>%
                 dplyr::arrange(desc(Total))
         } else if (groupby == "stustatus") {
             temp %>%
                 dplyr::filter(!is.na(student_status)) %>%
                 dplyr::group_by(student_status) %>%
                 dplyr::summarise(Total=n()) %>%
                 dplyr::mutate(Share=round(Total/sum(Total),2)) %>%
                 dplyr::arrange(desc(Total))
         } else {
             message("Please enter a valid value for 'groupby' attribute. Possible values are roles, country, language, gender, empstatus, education, and stustatus")
         }

     }
     membertable <- purrr::map(1:numcourses, ~ membershares(all_tables[[.x]][["course_memberships"]], all_tables[[.x]][["users"]]))
     names(membertable) <- coursenames
     return(membertable)
     #' ggplot(temp, aes(course_membership_role)) + geom_bar(aes(weight = freq))
 }

