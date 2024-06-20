# File:    Template for Plot Figures
# Author:  Faith Rolark
# Date:    06-14-2024

# LOAD DATASETS PACKAGES ###################################

# Packages for tidyr, ggplot2, rio
library(plyr)
library(ggalt)
library(ggforce)
library(rio)

# IMPORT DATA ##############################################
data <- import("D:/Faith/Documents/_RESEARCH/Wearable Sensors/Data and Analysis/Data and Figures/20221029_Data_ChannelWidth-PDMS.csv")
head(data)
data


# EXTRACT VARIABLES ########################################
n = 6  #no. of measurements per point

dataHour0 <- data[data$`Elapse Time [h]` %in% "0", ]
df <-data.frame(data)

# PLOTS ####################################################

science_theme = theme(#panel.grid.major = element_line(size = 0.5, color = "white"),
  panel.grid.minor = element_line(color = "white"), 
  panel.background = element_rect(fill="white"),
  axis.line = element_line(size = 0.7, color = "black"), 
  #legend.position = c(0.8,0.5), 
  axis.title = element_text(size = 20, family="Arial"),
  axis.text = element_text(size = 24, family="Arial"),
  legend.text = element_text(size = 20, family="Arial"),
  legend.title = element_text(size = 24, family="Arial"),
  panel.border = element_rect(colour = "black", fill=NA, size=3),
  text = element_text(color = "black"))


# Mean vs Nominal
ggplot(df) +
  geom_point(aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Printer), size=5) +
  geom_abline(intercept=0, slope=1, color = "black", size=1, linetype = "dashed") +
  # geom_smooth(method='lm', formula= Nominal.Dimension..um. ~ Mean.Value..um., se=FALSE, size=2)
  geom_smooth(formula = y ~ x, method = "lm", se = TRUE, aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Printer)) +
  scale_x_continuous(breaks = seq(0, 700, by = 100)) +
  scale_y_continuous(breaks = seq(0, 700, by = 100)) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width (um)") +
  ylab("Measured PDMS Channel Width (um)")