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
data <- import("C:/Users/faith/OneDrive - NU/Documents/_2 RESEARCH/2.19 Analysis Scripts/arpi_powder_flow/export/IN718 Bead Height/exp1_IN718 1RPM_off-on_CLEAN_WITH_DELAY.csv")
head(data)
data

fitted_data <- import("C:/Users/faith/OneDrive - NU/Documents/_2 RESEARCH/2.19 Analysis Scripts/arpi_powder_flow/export/IN718 Bead Height/exp1_IN718 1RPM_off-on_FOPDT.csv")
head(fitted_data)
fitted_data


data <- import("C:/Users/faith/OneDrive - NU/Documents/_2 RESEARCH/2.19 Analysis Scripts/arpi_powder_flow/export/IN718 Bead Height/exp3_IN718 1RPM_on-off_CLEAN_WITH_DELAY.csv")
head(data)
data

fitted_data <- import("C:/Users/faith/OneDrive - NU/Documents/_2 RESEARCH/2.19 Analysis Scripts/arpi_powder_flow/export/IN718 Bead Height/exp3_IN718 1RPM_on-off_FOPDT.csv")
head(fitted_data)
fitted_data


# EXTRACT VARIABLES ########################################
df <-data.frame(data)

fitted_df <-data.frame(fitted_data)

# PLOTS ####################################################

science_theme = theme(#panel.grid.major = element_line(size = 0.5, color = "white"),
  panel.grid.minor = element_line(color = "white"), 
  panel.background = element_rect(fill="white"),
  axis.line = element_line(size = 0.7, color = "black"), 
  #legend.position = c(0.8,0.5), 
  axis.title = element_text(size = 20, family="Arial", face="bold"),
  axis.text = element_text(size = 20, family="Arial", face="bold", color = "black"),
  legend.text = element_text(size = 20, family="Arial"),
  legend.title = element_text(size = 24, family="Arial"),
  panel.border = element_rect(colour = "black", fill=NA, size=3),
  text = element_text(color = "black"),
  aspect.ratio=0.8
  )

# Scatter Plot
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

# Line Plot
ggplot() +
  geom_line(data=df, aes(x=Time, y=Height), linewidth=2, color = "#3366FF") +
  #geom_line(data=fitted_df, aes(x=Time, y=Height), linewidth=2, color="red") +
  #annotate("rect", xmin = -Inf, xmax = 1.428, ymin = -Inf, ymax = Inf, alpha = .4) +
  #geom_segment(aes(x = 3.89, y = -Inf, xend = 3.89, yend = 0.32), color="black", linetype="dotted", linewidth=2) +
  #geom_segment(aes(x = -Inf, y = 0.32, xend = 3.89, yend = 0.32), color="black", linetype="dotted", linewidth=2) +
  #xlim(0,12) +
  scale_x_continuous(expand = c(0,0.4)) +
  scale_x_continuous(breaks = seq(0, 12, by = 3),expand = c(0,0.4)) +
  scale_y_continuous(breaks = seq(0, 12, by = 0.1)) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Time (s)") +
  ylab("Height (mm)")

# Line Plot
ggplot() +
  geom_line(data=df, aes(x=Time, y=Height), linewidth=2, color = "#3366FF") +
  geom_line(data=fitted_df, aes(x=Time, y=Height), linewidth=2, color="red") +
  #annotate("rect", xmin = 1.428, xmax = Inf, ymin = -Inf, ymax = Inf, alpha = .4) +
  geom_segment(aes(x = 3.32, y = -Inf, xend = 3.32, yend = 0.22), color="black", linetype="dotted", linewidth=2) +
  geom_segment(aes(x = -Inf, y = 0.22, xend = 3.32, yend = 0.22), color="black", linetype="dotted", linewidth=2) +
  #xlim(0,12) +
  scale_x_continuous(expand = c(0,0.4)) +
  scale_x_continuous(breaks = seq(0, 12, by = 3),expand = c(0,0.4)) +
  scale_y_continuous(breaks = seq(0, 12, by = 0.1)) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Time (s)") +
  ylab("Height (mm)")




