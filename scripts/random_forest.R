### Random Forest using Dalex ###

rm(list=ls())

library(devtools)
P <- rprojroot::find_rstudio_root_file

#import data
gef_data <- read.csv(P("data/gef_analysis_data.csv"))
smol_gef <- gef_data %>%
  select(ln_gef6,lnGDP,
           governmenteffectivenessestimate,
           average_population_density,
           agriculturallandoflandarea,
           average_forestarealandarea,
           GDP_CO2,
           CO2_Ems,countries)

#Create regression to predict gef6
library(DALEX)
library(ranger)

gef_data_imputed <- missRanger::missRanger(smol_gef)
  reg1 <- ranger(ln_gef6~lnGDP +
                   governmenteffectivenessestimate+
                   average_population_density +
                   agriculturallandoflandarea +
                   average_forestarealandarea +
                   GDP_CO2+
                   CO2_Ems,
                 gef_data_imputed)
  
#create explainer
  reg1_explain <- explain(reg1, data=gef_data, y=gef_data$ln_gef6)

#prediction
  gef_prediction <- predict_parts(reg1_explain) #needs 3 arguments





