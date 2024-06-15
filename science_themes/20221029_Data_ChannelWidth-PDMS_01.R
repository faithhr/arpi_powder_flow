# File:    20220701_Data_ChannelWidth_02
# Author:  Faith Rolark
# Date:    07-01-2022

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

n = 6  #no. of measurements per point

dataHour0 <- data[data$`Elapse Time [h]` %in% "0", ]
df <-data.frame(dataHour0)

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
  
# Mean vs Nominal (No regression)
ggplot(df) +
  geom_point(aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Printer), size=5) +
  geom_abline(intercept=0, slope=1, color = "black", size=1, linetype = "dashed") +
  scale_x_continuous(breaks = seq(0, 700, by = 100)) +
  scale_y_continuous(breaks = seq(0, 700, by = 100)) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width (um)") +
  ylab("Measured PDMS Channel Width (um)")

# Percent Change vs Nominal
ggplot(df) +
  geom_point(aes(x=Nominal.Dimension..um., y=Percent.Change, color=Printer), size=5) +
  scale_x_continuous(breaks = seq(0, 700, by = 100)) +
  scale_y_continuous(breaks = seq(0, 1500, by = 250)) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width (um)") +
  ylab("Percent Change in Width (%)")

# Correction Factor vs Nominal
ggplot(df) +
  geom_point(aes(x=Nominal.Dimension..um., y=Correction.Factor, color=Printer), size=5) +
  scale_x_continuous(breaks = seq(0, 700, by = 100)) +
  scale_y_continuous(breaks = seq(0, 20, by = 4)) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width (um)") +
  ylab("Correction Factor)")

# Analysis
# dataB9 <- subset(df, Printer == "B9")
# linearreg = lm(formula = dataB9$Mean.Value..um. ~ dataB9$Nominal.Dimension..um. + Printer, data = dataB9)
# summary(linearreg)
# 
# linearreg = lm(formula = df$Mean.Value..um. ~ df$Nominal.Dimension..um, data = subset(df, Printer == "F2"))
# summary(linearreg)
# 
# linearreg = lm(formula = df$Mean.Value..um. ~ df$Nominal.Dimension..um, data = subset(df, Printer == "Ph"))
# summary(linearreg)
# 
# subset(df, Printer == "B9")
# 
# linearreg = lm(formula = df$Mean.Value..um. ~ df$Nominal.Dimension..um + Printer, data = df)
# linearreg
# 
# linearreg = lm(formula = df$Mean.Value..um. ~ Printer, data = df)
# linearreg
# ##
# 
# models <- dlply(df, "Printer", function(dfmodels)
# lm(Nominal.Dimension..um. ~ Mean.Value..um., data = dfmodels))
# ldply(models, coef)
# l_ply(models, summary, .print = TRUE)

# Separate dataframe into subsets
dataB9 = subset(df, Printer == "B9")
dataF2 = subset(df, Printer == "F2")
dataF3 = subset(df, Printer == "F3")
dataPh = subset(df, Printer == "Ph")

# Run linear regression on each subset
linearB9 = lm(formula = dataB9$Mean.Value..um. ~ dataB9$Nominal.Dimension..um, data = dataB9)
linearF2 = lm(formula = dataF2$Mean.Value..um. ~ dataF2$Nominal.Dimension..um, data = dataF2)
linearF3 = lm(formula = dataF3$Mean.Value..um. ~ dataF3$Nominal.Dimension..um, data = dataF3)
linearPh = lm(formula = dataPh$Mean.Value..um. ~ dataPh$Nominal.Dimension..um, data = dataPh)

summary(linearB9)
summary(linearF2)
summary(linearF3)
summary(linearPh)

detach("package:datasets", unload = TRUE)
dev.off()
cat("\014")
