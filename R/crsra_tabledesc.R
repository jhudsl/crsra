#' Returns description for a table
#'
#' @return The description for a table based on the
#' description provided by Coursera in the data exports
#' @examples
#' crsra_tabledesc("assessments")
#' @export
crsra_tabledesc <- function(x){
    table_names = names(crsa::tabdesc)
    x = match.arg(x, choices = table_names)
    crsa::tabdesc[x]
}







