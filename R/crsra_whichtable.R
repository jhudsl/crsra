#' Returns a list of tables a variable appears in
#'
#' @return A list of tables that a specific variable appears in
#' @examples
#' crsra_whichtable("assessment_id")
#' crsra_whichtable
#'
crsra_whichtable <- function(
    all_tables,
    table_name){

    all_tables = course_to_coursera_import(all_tables)
    inside = lapply(all_tables, function(L) {
        res = sapply(L, function(x) {
            any(table_name %in% colnames(x))
        })
        names(res)[res]
    })
    inside
}
