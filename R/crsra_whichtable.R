
crsra_whichtable <- function(x){
    if (exists("all_tables")==FALSE){
        stop("Please import the data first using crsra_import() command!")
    } else {
        for (i in 1:100){
            if (x %in% colnames(all_tables[[1]][[i]])){
                print(tablenames[[i]])
            }
        }
    }
}
