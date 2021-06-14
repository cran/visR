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
DATASET <- paste0("Analysis data - time to event")

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

# load data set adtte already adhering to the CDISC ADaM standard 
data(adtte)

# Restore original options()
options(old)


## ----table1_get_default-------------------------------------------------------
# Display a summary table (e.g. tableone)
tableone(adtte[,c("TRTP", "AGE")],
         title = "Demographic summary" , datasource = DATASET)

## ----km_est-------------------------------------------------------------------
# Estimate a survival object
survfit_object <-  estimate_KM(adtte, strata = "TRTP")
survfit_object

## ----km_tab_options_1---------------------------------------------------------
# Display test statistics associated with the survival estimate
render(survfit_object  %>% get_pvalue(), title = "P-values", datasource = DATASET)


## ----km_plot_1----------------------------------------------------------------
# Create and display a Kaplan-Meier from the survival object and add a risktable
visr(survfit_object) %>% add_CI() %>% add_risktable()

