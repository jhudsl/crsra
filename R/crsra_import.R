#' Imports all the .csv files into one list consisting of all the courses and all the tables within each course.
#'
#' @param workdir A character string vector indicating the directory where all the unzipped course directories are stored.
#' @examples
#' crsra_import()



crsra_import <- function(workdir = getwd()) {

    packages <- c("dplyr", "readr", "data.table", "reshape2", "reshape", "purrr", "plyr", "stringr", "tidytext", "rcorpora", "knitr")
    instapack <- function(pkg){
        new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
        if (length(new.pkg))
            install.packages(new.pkg, dependencies = TRUE)
        sapply(pkg, require, character.only = TRUE)
    }
    suppressMessages(suppressWarnings(instapack(packages)))


    proceedstatus <- readline("The following procedure to import your data may take a while. Do you want to proceed? (y/n): ")
    if (proceedstatus == "y") {
        # This is for disconnecting all databases since there is a max of 16
        workdir <- getwd()
        dirnames <- list.dirs(path = workdir, full.names = FALSE)
        dirnames <- dirnames[-1] # to remove the first empty folder name (check if this line will be an issue in windows)
        #This is to check whether the working directory is pointing at the right folder.
        dircheck <- list.files(file.path(workdir, dirnames), full.names = FALSE, recursive = TRUE, include.dirs = FALSE, pattern = "course_branch_grades.csv")
        if (length(dircheck) == 0) {
            stop("Please make sure you have set your working directory to where the Coursera data dump is located.")
        }
        numcourses <<- length(dirnames)

        ########################################################################

        # creates a list and populates it with each course and all the tables for each course
        populate <- function(x, y) {
            setwd(file.path(workdir, x))
            names = list.files(pattern="*.csv")
            tablenames <<- sub(pattern = "(.*)\\..*$", replacement = "\\1", basename(names))
            suppressMessages(suppressWarnings(all <- purrr::map(1:length(tablenames), ~ read_csv(names[.x]))))
            # names(all) <- tablenames
            # all[["peer_review_part_free_responses"]] <- as_data_frame(all[["peer_review_part_free_responses"]]) %>%
            #    dplyr::select("peer_assignment_id", "peer_assignment_review_schema_part_id", "peer_review_id", "peer_review_part_free_response_text")
        }
        all_tables <<- purrr::map(1:numcourses, ~ populate(dirnames[[.x]]))
        setwd(workdir)

        # this changes the table names and corrects the columns of the table "peer_review_part_free_responses"
        for (i in 1:numcourses) {
            names(all_tables[[i]]) <<- tablenames
            all_tables[[i]][["peer_review_part_free_responses"]] <<- as_data_frame(all_tables[[i]][["peer_review_part_free_responses"]]) %>%
                dplyr::select("peer_assignment_id", "peer_assignment_review_schema_part_id", "peer_review_id", "peer_review_part_free_response_text")
        }

        coursenames <<- purrr::map(1:numcourses, ~ all_tables[[.x]][["courses"]]$course_name) # Extracts course names, 85 is the number of table associated with table courses
        names(all_tables) <<- coursenames # Assigns course names to the list courses
        partner_user_id <<- colnames(all_tables[[1]][["users"]])[1]



        # Since there are duplicates for membership roles (there are rows with the same jhu_user_id but different membership roles), the following lines
        # will calculate the latest membership role and keep that for the jhu_user_id and delete all other rows.
        # if (rmd == TRUE) {
        #     for (i in 1:numcourses) {
        #         all_tables[[i]][["course_memberships"]] <<- all_tables[[i]][["course_memberships"]] %>%
        #             dplyr::filter(course_membership_role!="INSTRUCTOR") %>%
        #             dplyr::filter(course_membership_role!="MENTOR") %>%
        #             dplyr::group_by(jhu_user_id) %>%
        #             dplyr::filter(course_membership_ts == max(course_membership_ts))
        #     }
        # } else {
        #     message("Warning: There might be duplicate students since each student can take multiple roles")
        # }
        message(" The following courses are loaded:")
        print(paste0(coursenames))
    }
}
