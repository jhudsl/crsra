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
#' @return A table which indicates the total number and the share of
#' students in each group for each course
#' @examples
#' zip_file = system.file("extdata",
#' "fake_course_7051862327916.zip",
#' package = "crsra")
#' bn = basename(zip_file)
#' bn = sub("[.]zip$", "", bn)
#' res = unzip(zip_file, exdir = tempdir(), overwrite = TRUE)
#' example_import = crsra_import(workdir = tempdir())
#' res = crsra_membershares(
#' example_import,
#' groupby = "country")
#' @importFrom dplyr %>% filter group_by summarise mutate arrange
#' @importFrom dplyr left_join desc n
#' @importFrom purrr map2
#' @export
crsra_membershares <- function(
    all_tables,
    groupby = c("roles", "country", "language", "gender",
                "empstatus", "education", "stustatus")) {
    partner_user_id = attributes(all_tables)$partner_user_id

    all_tables = course_to_coursera_import(all_tables)

    groupby = match.arg(groupby)
    coursenames = names(all_tables)
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
    mems = lapply(all_tables, function(x) x$course_memberships)
    users = lapply(all_tables, function(x) x$users)

    membertable <- purrr::map2(
        mems, users, membershares)

    names(membertable) <- coursenames
    return(membertable)
}

