# **CodeClan Dirty Data Project Task 1 - Decathlon Data**

### **Introduction** 

The `decathlon.rds` data set contains information relating to two athletics 
competitions, the Decastar athletics event and the Olympic Games. The data set 
contains entries containing athlete names, time and distances from various 
events in the decathlon, the competition name and the rank of each athlete from
the competition. I am working with this data set as part of my CodeClan Professional 
Data Analysis course with the purpose to improve my data analysis skills in R
I have acquired over my first four weeks of the course and acquire further 
insights into the data.

### **Aims** 

The aims of the task were as follows:

* Clean the `decathlon.rds` data set into a workable format.
* Answer 5 analysis questions.

### **Data** 

The `decathlon.rds` data set contains 41 rows with row names with the names of 
individual athletes as well as column names: `x100m`, `long_jump`, `shot_put`, 
`high_jump`, `x400m`, `x110m_hurdle`, `discus` , `pole_vault`, `javeline`, `x1500m`,
`rank`, `points` and `competition`. All of these columns contain integer or numerical 
variables except `competition` with contains categorical variables. The `decathlon.rds`
raw data file can be found in the raw data folder.

### **Packages and Libraries** 

A new R.file (named `decathlon_data_cleaning_script.R`) was created and the
libraries required for cleaning and analysis were loaded into the 
`decathlon_data_cleaning_script.R` file. The libraries used were `tidyverse`, 
and `janitor`. These were already installed in RStudio so the `library()` function 
was used however if the package is not 
installed please use the `install.packages()` function in the console to install 
the required libraries prior to loading the libraries. 

### **Cleaning the dataset** 

The raw data, decathlon.rds, file was read into the R script and saved as a 
variable, decathlon_info. I examined the data and saw that the athlete names
were formatted as row names so I first converted this row into a column using 
the `rownames_to_column()` function and then converted all the characters in the 
name column to lower case (`str_to_lower()` function). I then renamed the columns
to include the unit of measurement, metres(`m`) or seconds(`s`). There were no 
missing values in the data so no action was required to address this. 
This was assigned to the variable, `clean_decathlon` and then written into csv 
format and saved in the `clean_data` folder.

### **Analysis Questions** 

All code and answers to the following questions alongside additional annotations are available in the `dirty_data_project_decathlon_analysis.rmd` file stored in 
the documentation_and_analysis folder. 

Below I will give a brief overview to my approach to each question using the 
`clean_decathlon.cvs` file. The library used for this analysis was tidyverse.

**Question 1. Who had the longest long jump seen in the data?**

I selected, (`select()`), the `name` and `long_jump_distance_m` columns, arranged these columns in
descending order (`arrange(desc())`) and selected (`head()`) the top row from this table.

**Answer**:
Clay has the longest long jump in the data (7.96 m).

**Question 2. What was the average 100m time in each competition?**

I grouped the data set by (`group_by()`) the `competition` column, calculated the mean value 
(`mean()`) from the `100m_time_s` column and produced a summary table with `summarise()`.

**Answer**: 
From the table: The average 100m time in Decastar was 11.17538 and in the 
Olympic Games was 10.91571.

**Question 3. Who had the highest total points across both competitions?**

To find the athlete with the highest total points from both competitions I 
I selected (`select()`) the `name` and `total_points` columns, arranged them in descending order
(`arrange(desc())`) according to `total_points` and selected the top values using (`head()`).

**Answer**:
Sebrle had the highest total points (8893) across both competitions.

**Question 4. What was the shot-put scores for the top three competitors in each competition?**

I grouped by (`group_by()`) the competition, used the `slice_min()` function to select the 3 slices 
ordered by ranking relating to each tournament and then selected `competition`, 
`ranking` and `shot_put_distance_m` columns, `select()`.

**Answer**:
For the shot put in the Decastar event the first place athlete threw 14.83m,
second place threw 14.26m and third place threw 14.77m.
For the shot put in the OympicG event the first place athlete threw 16.36m,
second place threw 15.23m and third place threw 15.93m.


**Question 5. What was the average points for competitors who ran the 400m in less than 50 seconds vs. those than ran 400m in more than 50 seconds? **

To answer this question I created a new 400m_category column using the `mutate()` 
and the `ifelse()` functions. If the 400m time was less than 50s it would return 
`400m_less_than_50s` or it would return `400m_more_than_50s`. I then grouped by these
this new column and then found the mean total_points.

**Answer**:
For `400m_less_than_50s` the average total points was	8120.483 for `400m_more_than_50s`	the average total points was 7727.167.

### **Conclusions** 
I managed to clean the `decathlon.rds` dataset, convert it to csv format and 
answer all the analysis questions using functions contained within the tidyverse
library. The information and instructions given in this document alongside the code
contained in the dirty_data_project_analysis.Rmd should allow this analysis to be 
reproduced. Furthermore the clean data csv file produced could also be used for 
further analysis and answer further questions relating to this dataset. 




 
 
