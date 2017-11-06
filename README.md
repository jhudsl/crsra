# crsra

This in an R package for cleaning and some preliminary analysis of Coursera on-demand data. The package helps create relational tables in R rather than directly importing bulky .csv files. It also run some preliminary analysis on the data. Note that this package is still under development and the auther appreciates feedback and suggestions.

## Setup

to install this package, you will need to install `devtools`.
install the [devtools package](https://CRAN.R-project.org/package=devtools), available from CRAN. I strive to keep the master branch on GitHub functional and working properly.

``` r
#install.packages("devtools")
devtools::install_github("ahdvnd/crsra", build_vignettes = TRUE)
```

This package is written in R and while it creates databases in PostgreSQL (postgres), it requires minimum knowledge of Linux or database management. However, to use the package you will need to have Postgres installed on your machine. 
PostgreSQL has a community of online resources on how to download, install, and use it. Here are some resources:

- http://postgresguide.com/

- http://www.postgresql.org/docs/9.5/static/tutorial.html

- http://www.postgresqltutorial.com/


## Installation
Once postgres is installed, make sure it is running and that you see the green light showing the posgres is running. Without postgres running you will not be able to import the data.

To install PostGreSQL, please refer to the [official documentation](https://wiki.postgresql.org/wiki/Detailed_installation_guides)

Then, follow the 'first steps' tutorial [here](https://wiki.postgresql.org/wiki/First_steps)

unzip files and set your working directory to the folder that contains the data dump (all the unzipped folders).

## Dependencies

## Update

## Why Postgres

If you look at the headers that are supplied in the .html files, you see that some of these contain header specifications that are illegal in e.g. MySQL. Additionally, PostGreSQL can import CSV files pretty painlessly. Of course, you can choose to not use these header files and use another database.

## Importing Data

In order to import your data dump into R, first point your working directory to the directory that contains all the unzipped course folders. Then execute the command `crsra_import()`. If you are not pointing to the correct directory, you will receive a warning and the execution will be halted. Note that the data import may take some time if the course data is large and there are several courses in your working directory. Also note that by running the `crsra_import()` command, you don't actually import any tables into R. Instead, you create a local database for easilty accessing all the tables and courses in your data. After the process is complete, you can access the tables in each course as follows.

In the data, you may find users who have taken multiple roles in a specific course. For instance, they may start as a "Browser" and end up as a "Learner." In order to have a better understanding of the data, we can filter data to keep only user's most recent role. In order to apply this, pass `crsra_import(rmd = TRUE)` instead to remove duplicate roles.

## Calling Tables

For a list of all the tables in the data download, please click [here](https://github.com/ahdvnd/crsra/blob/master/ListofTables.md). All tables can be called by the name `all_tables`. For instance, if you like to call the table `peer_comments`, you can simply execulte `all_tables[["peer_comments"]]`. If you would like to call the table for one of the courses, you may run `all_tables[["peer_comments"]][[1]]`. `1` is the first course imported in the data dump. To see the order of courses imported, check `coursenames`.

## List of Courses

If you are importing data for multiple courses (or a specialization), you do not have to specify the names of the courses. *crsra* will automatically load the courses names from the `courses` table incuded in the data dump of each course. To see a list of all the courses imported, you can call them by `coursenames`.

## List of Functions

For user convenience, a few other functions are added to the package in addition to the main `crsra_import()` function. A list of functions and their descriptions is provided below:

| Function | Description |
|----------|-------------------------------------------------------------------|
| crsra_membershares | Returns a summary of the total number and the shares of users in each course broken down by factors such as roles, country, language, gender, employment status, education level, and student status. |
| crsra_gradesummary | Returns total grade summary or broken down by the factors mentioned above. |
| crsra_progress | Summarizes, for each course item, the total number and the share of users who stopped the course at that specific course item. The function ranks course items by their attrition. |
| crsra_assessmentskips | Users may "skip" reviewing a submission if there is a problem with it. This function categorizes skips by their type such as "inappropriate content", "plagiarism", etc. The function also returns list of mostly used words in peer comments. |
| crsra_timetofinish | Calculates the time to finish a course for each user. |

## Example

In this example we would like to look at the number of students who passed a specific course item (course item `9W3Y2`) and their average grade in a specific course.

```r
library(dplyr)

all_tables[["course_item_grades"]][[1]] %>% #1 is the course number associated with the course *Getting and Cleaning Data* in our example.
    dplyr::filter(course_item_id == "9W3Y2") %>% 
    dplyr::filter(course_item_passing_state_id == 2) %>% 
    dplyr::summarise(n = n(), grade = mean(course_item_grade_verified))
    
# Source:   lazy query [?? x 2]
# Database: postgres 9.6.5 [postgres@localhost:5432/data_cleaning_1507238182695]
#      n     grade
#  <dbl>     <dbl>
#1 17639 0.9719599
```

## Common mistakes

## Feedback/Questions

If you have any questions or feedback, please contact me at: hadavand.a[[at]]gmail[[dot]]com

## Meta
-   Please [report any issues or bugs](https://github.com/ahdvnd/crsra/issues).

-   License: MIT

-   To cite *crsra*, please use: Aboozar Hadavand (2017). crsra: A package for cleaning and analyzing Coursera on-demand data. https://github.com/ahdvnd/crsra

