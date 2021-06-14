## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----imports, echo=TRUE, warning=FALSE, message=FALSE-------------------------
library(ggplot2)
library(visR)

## ----globalSetup--------------------------------------------------------------
# Constants
DATASET <- paste0("NCCTG Lung Cancer Dataset (from survival package ", 
                  packageVersion("survival"), ")")

# Save original options()
old <- options()  

# Global formatting options
options(digits = 3)

# Global ggplot settings
theme_set(theme_bw())

# Global table settings 
options(DT.options = list(pageLength = 10, 
                          language = list(search = 'Filter:'), 
                          scrollX = TRUE))

lung_cohort <- survival::lung

# Change gender to be a factor and rename some variables to make output look nicer
lung_cohort <- lung_cohort %>%  
  dplyr::mutate(sex = as.factor(ifelse(sex == 1, "Male", "Female")))  %>%  
  dplyr::rename(Age = "age", Sex = "sex", Status = "status", Days = "time")

# Restore original options()
options(old)

## ----table1_get_default-------------------------------------------------------
# Select variables of interest and change names to look nicer
lung_cohort_tab1 <- lung_cohort %>%  
  dplyr::select(Age, Sex) 

# Create a table one
tab1 <- get_tableone(lung_cohort_tab1)

# Render the tableone
render(tab1, title = "Overview over Lung Cancer patients", datasource = DATASET)

## ----table1_render_default----------------------------------------------------
# Use wrapper functionality to create and display a tableone
tableone(lung_cohort_tab1, title = "Overview over Lung Cancer patients", datasource = DATASET)

## ----table1_get_options-------------------------------------------------------
# Create and render a tableone with a stratifier and without displaying the total
tableone(lung_cohort_tab1, strata = "Sex", overall = FALSE,
         title = "Overview over Lung Cancer patients", datasource = DATASET)


## ----table1_render_options_dt-------------------------------------------------
# Create and render a tableone with with dt as an engine
tableone(lung_cohort_tab1, strata = "Sex", overall = FALSE,
         title = "Overview over Lung Cancer patients", datasource = DATASET, 
         engine = "dt")

## ----table1_render_options_kable----------------------------------------------
# Create and render a tableone with with kable as an engine and html as output format
tableone(lung_cohort_tab1, strata = "Sex", overall = FALSE, 
         title = "Overview over Lung Cancer patients", datasource = DATASET, 
         engine = "kable", output_format="html")

## ----km_est-------------------------------------------------------------------
# Select variables of interest and change names to look nicer
lung_cohort_survival <- lung_cohort %>%  
  dplyr::select(Age, Sex, Status, Days)  

# For the survival estimate, the censor must be 0 or 1
lung_cohort_survival$Status <- lung_cohort_survival$Status - 1

# Estimate the survival curve
lung_suvival_object <- lung_cohort_survival %>% 
  estimate_KM(strata = "Sex", CNSR = "Status", AVAL = "Days")
lung_suvival_object

## ----km_tab-------------------------------------------------------------------
# Create a risktable
rt <- get_risktable(lung_suvival_object)

# Display the risktable
render(rt, title = "Overview over survival rates of Lung Cancer patients", datasource = DATASET)

## ----km_tab_options_1---------------------------------------------------------
# Display a summary of the survival estimate
render(lung_suvival_object  %>% get_summary(), title = "Summary", datasource = DATASET)


## ----km_tab_options_2---------------------------------------------------------
# Display test statistics associated with the survival estimate
render(lung_suvival_object  %>% get_pvalue(), title = "P-values", datasource = DATASET)

## ----km_tab_options_3---------------------------------------------------------
# Display qunatile information of the survival estimate
render(lung_suvival_object  %>% get_quantile(), title = "Quantile Information", datasource = DATASET)


## ----km_tab_options_4---------------------------------------------------------
# Display a cox model estimate associated with the survival estimate
#render(lung_suvival_object  %>% get_COX_HR(), title = "COX estimate", datasource = DATASET)

## ----km_plot_1----------------------------------------------------------------
# Create and display a Kaplan-Meier from the survival object
gg <- visr(lung_suvival_object)
gg 

## ----km_plot_2----------------------------------------------------------------
# Add a confidence interval to the Kaplan-Meier and display the plot
gg %>% add_CI() 

## ----km_plot_3----------------------------------------------------------------
# Add a confidence interval and the censor ticks to the Kaplan-Meier and display the plot
gg %>% add_CI() %>% add_CNSR(shape = 3, size = 2)

## ----km_add-------------------------------------------------------------------
# Add a confidence interval and the censor ticks and a risktable to the Kaplan-Meier and display the plot
gg %>% add_CI() %>% add_CNSR(shape = 3, size = 2) %>% add_risktable()

