---
layout: default
title: How-To Use R via the Terminal
parent: How-To Articles
nav_order: 16
---

# How-To Use R via the Terminal

## Overview

R is a powerful programming language and environment designed for statistical computing, data analysis, and graphics, making it essential for data science. While RStudio is a popular integrated development environment (IDE) that enhances the user experience with features like syntax highlighting, debugging, and visualization tools, you can interact with R directly via the command line without using RStudio. This allows users to run R scripts, execute commands, and manage R packages through a terminal interface without the need for a Open OnDemand Talapas Desktop session.

## Loading R

To load R into your current environment, you first must choose which version of R you wish to run. Currently on Talapas2, there are a few versions from which to choose from. To see which options are available, within the terminal, enter the following command and then the `tab` key twice:

`$ module load R/`

This will then display a list of all the current versions of R available on Talapas2. Complete the command by entering the version you would like to use (as seen below with 4.3.3) and press enter.

`$ module load R/4.3.3`

Note: R/4.3.3 is the latest version of R currently on Talapas and is the version with the most pre-installed library options.

## Interacting with R

There are two primary ways to interact with R via the command line: running R interactively or executing R scripts. Running R interactively via the command line provides an experience similar to RStudio, where users can enter R commands and see immediate results within the terminal, making it ideal for exploratory data analysis and quick computations. Alternatively, users can write R code in an `.R` file and run it using the `Rscript` command, such as `Rscript example.R`. This method is suitable for automating tasks, running batch jobs, and sharing reproducible scripts. Both approaches offer flexibility and cater to different workflows.

## Interactive R Session

To work interactively with R in a RStudio style workflow, simply initiate an R session by loading your preferred R version and entering the command:

`$ R`

Once in the interactive R session, you can perform data analysis, create visualizations, manipulate data, and run statistical tests just as you would in RStudio. To exit the interactive session, you can type `q()` and press Enter, returning to the normal command line interface.

### Loading Libraries Interactively

To load libraries interactively, use the `library()`command. An example of this is seen below:

```R
> library(rio)
>
> print(.packages())
[1] "rio"       "stats"     "graphics"  "grDevices" "utils"     "datasets"
[7] "methods"   "base"
```

After running `print(.packages())`, we can see that our library “rio” was successfully loaded.

If you are unsure if a required library is available in the version of R being used, you can run the commands:

```R
> installed_packages <- installed.packages()
> print(installed_packages[, "Package"])
```

This will output a list of **ALL** available libraries and you can see if your desired library is present in the list. As mentioned, this may be a very large list depending on which R is being used.

## Using an `.R` script and `Rscript`

Using R with an `.R` file allows you to write your R code in a script and execute it non-interactively with the `Rscript` command, eliminating the need to enter an interactive R session. To do this, you create a text file with an `.R` extension (e.g., `my_script.R`) and write your R code inside it.

### Creating an `.R`script

Creating an R script is fairly straight forward. This script can contain R commands, including data manipulation, analysis, and visualization instructions. To do this, first create the script file:

`$ touch my_script.R`

Note: replace “my_script” with your desired file name

Next, with your preferred text-editor, open the file and begin to add your R code:

`$ vim my_script.R`

### Loading libraries via `.R` script

Similar to Python, R offers a plethora of libraries for data processing, visualization, and manipulation. It is essential to load these libraries in your `.R` script if they are needed. To ensure proper execution, load the required libraries at the beginning of your script, which prevents issues with commands not being available/not found due to missing libraries. This ensures that all necessary libraries are loaded initially, allowing your script to run without interruptions or errors related to unavailable functions.

An example of this is shown below:

```R
library(rio)
library(dplyr)
library(ade4)
library(broom)
library(reshape2)
```

### Verifying libraries loaded successfully

To verify that all specified libraries were loaded properly, you can add a `print((.packages()))` line to your `.R` file which will print a list of all currently loaded libraries to the terminal. Continuing from the previous example of loaded libraries, adding `print((.packages()))` produces the following output:

```R
 [1] "reshape2"  "broom"     "ade4"      "dplyr"     "rio"       "stats"
 [7] "graphics"  "grDevices" "utils"     "datasets"  "methods"   "base"
```

Once your script is ready, add `q()` at the end of the file, save and exit. You can now run it from the command line by using the `Rscript` R command:

`$ Rscript my_script.R`

This command executes the entire script and outputs the results to the terminal or a specified output file.

An example a completed `my_script.R` loading the above libraries (only “rio” is needed to perform the following task) and then importing and extracting the last column from `input_test.csv` file into `output_test.csv` is provided below:

```R
library(rio)
library(dplyr)
library(ade4)
library(broom)
library(reshape2)

print((.packages()))
data <- import("input_test.csv")

last_column <- data[, ncol(data), drop = FALSE]
export(last_column, "output_test.csv")

q()
```
