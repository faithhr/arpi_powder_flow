# File:    20220701_Data_ShrinkageMass_03
# Author:  Faith Rolark
# Date:    07-01-2022

# LOAD DATASETS PACKAGES ###################################

# Packages for plyr, ggalt, ggforce, rio
library(plyr)
library(dplyr)
library(ggalt)
library(ggforce)
library(rio)
library(RColorBrewer)

# IMPORT DATA ##############################################

data <- import("D:/Faith/Documents/_RESEARCH/Wearable Sensors/Data and Analysis/Data and Figures/20221205_Data_MassPDMSTreatments.csv")
head(data)
data

df <-data.frame(data)

# ANALYSIS #################################################

averagePercentMass <- df %>% group_by(Material, Treatment) %>% summarize(value=mean(Percent.Mass.Change), sd=sd(Percent.Mass.Change))

# PLOTS ####################################################

science_theme = theme(#panel.grid.major = element_line(size = 0.5, color = "white"),
  panel.grid.minor = element_line(color = "white"), 
  panel.background = element_rect(fill="white"),
  axis.line = element_line(size = 0.7, color = "black"),
  legend.position = c(0.45,0.75), 
  axis.title = element_text(size = 20, family="Arial"),
  axis.text = element_text(size = 20, family="Arial"),
  legend.text = element_text(size = 14, family="Arial"),
  legend.title = element_text(size = 18, family="Arial"),
  panel.border = element_rect(colour = "black", fill=NA, size=3),
  text = element_text(color = "black"))

ggplot(averagePercentMass) +
  geom_hline(yintercept=0) +
  geom_bar(aes(x=Treatment, y=value, fill=Material), stat="identity", color="black", size=1, position=position_dodge()) +
  geom_errorbar(aes(x=Treatment, ymin=value-sd, ymax=value+sd, fill=Material), position=position_dodge(0.9), width=0.3, color="black", alpha=1, size=1.2) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Surface Treatments") +
  ylab("Percent Change of Mold Mass [%]")

detach("package:datasets", unload = TRUE)
dev.off()
cat("\014")
