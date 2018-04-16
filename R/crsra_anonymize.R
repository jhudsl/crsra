#' Anonymizes ID variables (such as Partner hashed user ids) throughout
#' the data set. The function is based on the function \code{digest} from the
#' package \code{digest}.
#'
#' @param all_tables A list from \code{\link{crsra_import_course}} or
#' \code{\link{crsra_import}}
#' @param cols_to_mask A vector of user ids to mask.
#' @param algorithm The algorithms to be used for anonymization;
#' currently available choices are crc32, which is also the default,
#' md5, sha1, sha256, sha512, xxhash32, xxhash64 and murmur32.
#' @examples
#' crsra_anonymize(all_tables, cols_to_mask = "jhu_user_id",
#' algorithm = "sha1")
#' @return A list that contains all the tables within each course.
#' @export
#' @importFrom digest dplyr data.table

crsra_anonymize <- function(
    all_tables,
    cols_to_mask = attributes(all_tables)$partner_user_id,
    algorithm = "crc32") {

    anonymize <- function(x){
        unq_hashes <- vapply(unique(x), function(object) digest(object, algo=algorithm), FUN.VALUE="", USE.NAMES=TRUE)
        unname(unq_hashes[x])
        }

    makesample <- function(x) {
        if(cols_to_mask %in% colnames(x))
        {
            x <- tbl_df(as.data.table(x)[,cols_to_mask := lapply(.SD, anonymize),.SDcols=cols_to_mask,with=FALSE])
            } else {
            x <- tbl_df(as.data.table(x))
            }
        }

    all_tables.encrypted <- suppressWarnings(purrr::map(1:100, ~ makesample(all_tables[[1]][[.x]])))
    names(all_tables.encrypted) <- names(all_tables[[1]])
    return(all_tables.encrypted)
    }

