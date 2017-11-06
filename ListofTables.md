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

## List of Table Names

For a list of all the tables in the data download, please click [here]().

## Example

## List of Functions


## Common mistakes

## Feedback/Questions

If you have any questions or feedback, please contact me at: hadavand.a[[at]]gmail[[dot]]com

## Meta
-   Please [report any issues or bugs](https://github.com/ahdvnd/crsra/issues).

-   License: MIT

-   To cite *crsra*, please use: Aboozar Hadavand (2017). crsra: A package for cleaning and analyzing Coursera on-demand data. https://github.com/ahdvnd/crsra

