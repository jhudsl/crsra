#' List of tables a variable appears in
#'
#' @param x The name of the variable
#' @return A list of tables that a specific variable appears in
#' @examples
#' crsra_whichtable("assessment_id")
#'
crsra_whichtable <- function(x){
    if (exists("all_tables")==FALSE){
        stop("Please import the data first using crsra_import() command!")
    } else {
        m <- 0
        for (i in 1:100){
            if (x %in% colnames(all_tables[[1]][[i]])){
                print(tablenames[[i]])
                m <- m + 1
            }
        }
        if (m==0){
            print("There is no table that includes such variable. Please check the spelling!")
        }
    }
}
