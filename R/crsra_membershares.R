#' The share of learners in each course based on specific characteristics.
#'
#' @param groupby A character string indicating the how to break down learners
#' in each course. The default is set to \code{roles} and returns the
#' share of students in each category such as Learner, Not Enrolled,
#' Pre-Enrolled Learner, Mentor, Browser, and Instructor.
#' Other values are \code{country} (for grouping based on country),
#' \code{language} (for grouping based on language), \code{gender}
#' (for grouping by gender), \code{education} (for grouping by
#' education level), \code{stustatus} (for grouping by student status),
#'  \code{empstatus} (for grouping by employment status), and \code{country}
#'  (for grouping by country). Note that this grouping uses the entries
#'  in the table \code{users} that is not fully populated so by grouping
#'   you lose some observations.
#' @return A table which indicates the total number and the share of students in each group for each course
#' @examples
#' crsra_memebershares(groupby = "country")
#' @export
crsra_membershares <- function(
    groupby = c("roles", "country", "language", "gender",
                "empstatus", "education", "stustatus")) {

    groupby = match.arg(groupby)
    varname = switch(groupby,
                     "roles" = "course_membership_role",
                     "country" = "country_cd",
                     "language" = "profile_language_cd",
                     "gender" = "reported_or_inferred_gender",
                     "empstatus" = "employment_status",
                     "education" = "educational_attainment",
                     "stustatus" = "student_status")

     membershares <- function(x, z) {
         temp <- z %>%
             dplyr::left_join(x, by = partner_user_id, `copy`=TRUE)
         temp$y = temp[[varname]]
         temp %>%
             dplyr::filter(!is.na(y)) %>%
             dplyr::group_by(y) %>%
             dplyr::summarise(Total=n()) %>%
             dplyr::mutate(Share=round(Total/sum(Total),2)) %>%
             dplyr::arrange(desc(Total))
     }
     membertable <- purrr::map(
         1:numcourses, ~ membershares(all_tables[[.x]][["course_memberships"]],
                                      all_tables[[.x]][["users"]]))
     names(membertable) <- coursenames
     return(membertable)
     #' ggplot(temp, aes(course_membership_role)) + geom_bar(aes(weight = freq))
 }

