crsra_import <- function(rmd = TRUE, workdir = getwd()) {

    packages <- c("dplyr", "dbplyr" "DBI", "RPostgreSQL", "tidytext", "ggplot2", "reshape2", "reshape", "purrr", "plyr", "stringr", "tidytext", "rcorpora", "knitr")
    instapack <- function(pkg){
        new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
        if (length(new.pkg))
            install.packages(new.pkg, dependencies = TRUE)
        sapply(pkg, require, character.only = TRUE)
    }
    instapack(packages)

    proceedstatus <- readline("The following procedure to import your data may take a while. Do you want to proceed? (y/n): ")
    if (proceedstatus == "y") {
        # This is for disconnecting all databases since there is a max of 16
        lapply(dbListConnections(PostgreSQL()), dbDisconnect)
        dirnames <- list.dirs(path = workdir, full.names = FALSE)
        dirnames <- dirnames[-1] # to remove the first empty folder name (check if this line will be an issue in windows)

        #This is to check whether the working directory is pointing at the right folder.
        dircheck <- list.files(file.path(workdir, dirnames), full.names = FALSE, recursive = TRUE, include.dirs = FALSE, pattern = "course_branch_grades.csv")
        if (length(dircheck) == 0) {
            stop("Please make sure you have set your working directory to where the Coursera data dump is located.")
        }
        numcourses <<- length(dirnames)

        # This creates databases
        createdbname <- function(x) {
            temp1 <- paste("dropdb", x, sep = " ")
            system(temp1)
            temp1 <- paste("createdb", x, sep = " ")
            system(temp1)
        }
        purrr::map(1:numcourses, ~ createdbname(dirnames[[.x]]))

        # Populating databases using setup.sql and load.sql files and the .csv files
        populate <- function(x) {
            setwd(file.path(workdir, x))
            temp <- paste("psql -e -U postgres -d", x, sep = " ")
            temp1 <- paste(temp, "-f setup.sql", sep = " ")
            temp2 <- paste(temp, "-f load.sql", sep = " ")
            system(temp1)
            system(temp2)
        }
        purrr::map(1:numcourses, ~ populate(dirnames[[.x]]))
        setwd(workdir)


        # This is for connecting R to the databases
        # First connect to your Postgresql client
        # in terminal run the command createdb mydb, which will create a database named mydb (you can use dropdb mydb to delete a database)
        # Then use psql -e -U postgres -d mydb -f setup.sql (this will setup all the tables included in the course data export.)
        # Then run psql -e -U postgres -d mydb -f load.sql (this will import all csv files into PostgreSQL)
        #' dbListTables(con)
        #' dbListFields(con, 'peer_submissions')
        #db_list_tables(rprogdb)
        #src_tbls(rprogdb)

        drv <- dbDriver("PostgreSQL")
        courses <- purrr::map(1:numcourses, ~ dbConnect(drv, host='localhost',
                                                        port='5432',
                                                        dbname=dirnames[.x],
                                                        user='postgres',
                                                        password=''))

        courses <- unlist(courses, recursive = TRUE, use.names = TRUE)
        # Now you can call it by using course[[1]]
        # e.g. tbl(courses[[1]], "users")

        # assign(paste(tablenames[1], "df", sep = "_"), purrr::map(1:numcourses, ~ tbl(courses[[.x]], tablenames[1])))
        tablenames <<- dbListTables(courses[[1]])
        # create all the 99 tables
        assignment <- function(y) {
            assign(paste(y, "df", sep = "_"), purrr::map(1:numcourses, ~ tbl(courses[[.x]], y)))
        }
        all_tables <<- purrr::map(1:length(tablenames), ~ assignment(tablenames[[.x]]))
        coursenames <<- purrr::map(1:numcourses, ~ tbl_df(all_tables[[85]][[.x]])$course_name) # Extracts course names, 85 is the number of table associated with table courses
        names(courses) <- coursenames # Assigns course names to the list courses
        names(all_tables) <<- tablenames

        # Since there are duplicates for membership roles (there are rows with the same jhu_user_id but different membership roles), the following lines
        # will calculate the latest membership role and keep that for the jhu_user_id and delete all other rows.
        slicing <- function(x) {
            temp <- x %>%
                dplyr::filter(course_membership_role!="INSTRUCTOR") %>%
                dplyr::filter(course_membership_role!="MENTOR") %>%
                dplyr::group_by(jhu_user_id) %>%
                dplyr::filter(course_membership_ts == max(course_membership_ts))
                # dplyr::slice(which.max(as.Date(course_membership_ts, '%Y/%m/%d')))
        }
        if (rmd == TRUE) {
            all_tables[["course_memberships"]] <<- purrr::map(1:numcourses, ~ slicing(all_tables[["course_memberships"]][[.x]]))
        } else {
            message("Warning: There might be duplicate students since each student can take multiple roles")
        }
        message(paste0(numcourses, " database(s) created and running:"))
        print(paste0(coursenames))
    }
}
