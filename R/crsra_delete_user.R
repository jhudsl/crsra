#' Deletes a specific user from all tables in the data in case Coursera data
#' privacy laws require you to delete a specific (or set of) user(s) from your
#' data.
#' @param all_tables A list from \code{\link{crsra_import_course}} or
#' \code{\link{crsra_import}}
#' @param users A vector of user ids to delete
#' @examples
#' crsra_delete_user(all_tables, users = "9d5e1394")
#' @return A list that contains all the tables within each course.
#' @export
#' @importFrom dplyr

crsra_delete_user <- function(
    all_tables,
    users){

    m <- attributes(all_tables)$partner_user_id

    delete_users <- function(x)
        {
        if(m %in% colnames(x)){
            x <- x[x[, m] != users, ]
            } else {
                x <- x
            }
        }

    all_tables.deleted <- suppressWarnings(purrr::map(1:100, ~ delete_users(all_tables[[1]][[.x]])))
    names(all_tables.deleted) <- names(all_tables[[1]])
    return(all_tables.deleted)

    }


#crsra_delete_user(course_data, users = "e921665b")
