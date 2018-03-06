
# crsra

[![Travis build
status](https://travis-ci.org/jhudsl/crsra.svg?branch=master)](https://travis-ci.org/jhudsl/crsra)

muschellij2 badges:

[![Travis build
status](https://travis-ci.org/muschellij2/crsra.svg?branch=master)](https://travis-ci.org/muschellij2/crsra)

This in an R package for cleaning and some preliminary analysis of
Coursera research data exports. The package helps import and organize
all the tables in R. It also run some preliminary analysis on the data.
Note that this package is still under development and the auther
appreciates feedback and suggestions.

## Setup

to install this package, you will need to install `devtools`. install
the [devtools package](https://CRAN.R-project.org/package=devtools),
available from CRAN. I strive to keep the master branch on GitHub
functional and working properly.

``` r
library("devtools")
devtools::install_github("jhudsl/crsra", build_vignettes = TRUE)
```

``` r
library(crsra)
zip_file = file.path("inst", 
                     "extdata", 
                     "fake_course_7051862327916.zip")
bn = basename(zip_file)
bn = sub("[.]zip$", "", bn)
res = unzip(zip_file, exdir = tempdir(), overwrite = TRUE)
workdir = file.path(tempdir(), bn)
example_course_import = crsra_import_course(workdir)
```

    ## Warning in crsra_import_course(workdir): Data set courses may still have
    ## some data errors

``` r
save(example_course_import, 
     file = file.path("data", "example_course_import.rda"),
     compress = "xz")
```

<!-- ## Update -->

## Importing Data

In order to import your data dump into R, first point your working
directory to the directory that contains all the unzipped course
folders. Then execute the command `crsra_import()`. If you are not
pointing to the correct directory, you will receive a warning and the
execution will be halted. Note that the data import may take some time
if the course data is large and there are several courses in your
working directory. Also note that by running the `crsra_import()`
command, you import all tables for each individual course into R in a
list called `all_tables`. <!--
In the data, you may find users who have taken multiple roles in a specific course. For instance, they may start as a "Browser" and end up as a "Learner." In order to have a better understanding of the data, you can filter data to keep only user's most recent role. In order to apply this, pass `crsra_import(rmd = TRUE)` instead to remove duplicate roles.
-->

## Calling Tables

For a list of all the tables in the data download, please click
[here](https://github.com/jhudsl/crsra/blob/master/ListofTables.md). All
tables can be called using
`all_tables[["course_name"]][["table_name"]]`. For instance, if you like
to call the table `peer_comments` in the course Regression Models, you
can simply execulte `all_tables[["Regression
Models"]][["peer_comments"]]`. To see a list of courses imported by the
`crsra_import()` command check the variable `coursenames`. To see a list
of all the tables check the variable `tablenames`.

## List of Functions

For user convenience, a few other functions are added to the package in
addition to the main `crsra_import()` function. A list of functions and
their descriptions is provided
below:

| Function                | Description                                                                                                                                                                                                                                    |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `crsra_membershares`    | Returns a summary of the total number and the shares of users in each course broken down by factors such as roles, country, language, gender, employment status, education level, and student status.                                          |
| `crsra_gradesummary`    | Returns total grade summary or broken down by the factors mentioned above.                                                                                                                                                                     |
| `crsra_progress`        | Summarizes, for each course item, the total number and the share of users who stopped the course at that specific course item. The function ranks course items by their attrition.                                                             |
| `crsra_assessmentskips` | Users may “skip” reviewing a submission if there is a problem with it. This function categorizes skips by their type such as “inappropriate content”, “plagiarism”, etc. The function also returns list of mostly used words in peer comments. |
| `crsra_timetofinish`    | Calculates the time to finish a course for each user.                                                                                                                                                                                          |

## Example

In order to look at the number of students who passed a specific course
item (course item `67c1O`) in the course “Regression Models” and their
average grade in a specific course.

``` r
library(dplyr)

all_tables[["Regression Models"]][["course_item_grades"]] %>%
    dplyr::filter(course_item_id == "67c1O") %>% 
    dplyr::filter(course_item_passing_state_id == 2) %>% 
    dplyr::summarise(n = n(), grade = mean(course_item_grade_verified))

## A tibble: 1 x 2
##      n     grade
##   <int>    <dbl>
## 1  8640 0.9556052
```

<!--- ## Common mistakes --->

## Feedback/Questions

If you have any questions or feedback, please contact me at:
hadavand.a\[\[at\]\]gmail\[\[dot\]\]com

## Meta

  - Please [report any issues or
    bugs](https://github.com/jhudsl/crsra/issues).

  - License: MIT

  - To cite *crsra*, please use: Aboozar Hadavand, Jeff T Leek (2017).
    crsra: A package for cleaning and analyzing Coursera research data
    exports. <https://github.com/jhudsl/crsra>
