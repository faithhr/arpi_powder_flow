# File:    20220701_Data_ChannelWidth_02
# Author:  Faith Rolark
# Date:    07-01-2022

# LOAD DATASETS PACKAGES ###################################

# Packages for tidyr, ggplot2, rio
library(plyr)
library(dplyr)
library(ggalt)
library(ggforce)
library(rio)

# IMPORT DATA ##############################################
data <- import("D:/Faith/Documents/_RESEARCH/Wearable Sensors/Data and Analysis/Data and Figures/20221205_Data_ChannelWidth-Mold-PDMS.csv")
head(data)
data

dataHour0 <- data[data$`Elapse Time [h]` %in% "0", ]
df <-data.frame(dataHour0)
dfPlot <- df %>%
  group_by(Printer, Type) %>%
  select(Printer, Type, Nominal.Dimension..um., Mean.Value..um., Standard.Error.of.Mean, Percent.Change, Standard.Error.of.Percent.Change,)

# PLOTS ####################################################

science_theme = theme(#panel.grid.major = element_line(size = 0.5, color = "white"),
  panel.grid.minor = element_line(color = "white"), 
  panel.background = element_rect(fill="white"),
  axis.line = element_line(size = 0.7, color = "black"), 
  legend.position = c(0.25,0.8), 
  axis.title = element_text(size = 20, family="Arial"),
  axis.text = element_text(size = 0, family="Arial"),
  legend.text = element_text(size = 20, family="Arial"),
  legend.title = element_text(size = 0, family="Arial", color="white"),
  panel.border = element_rect(colour = "black", fill=NA, size=3),
  text = element_text(color = "black"))

# Mean vs Nominal (B9)
ggplot(subset(dfPlot, Printer == "B9")) +
  geom_point(aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Type), size=7) +
  geom_abline(intercept=0, slope=1, color = "black", size=1, linetype = "dashed") +
  geom_errorbar(aes(x=Nominal.Dimension..um., 
                    ymin=Mean.Value..um.-Standard.Error.of.Mean, 
                    ymax=Mean.Value..um.+Standard.Error.of.Mean),
                    width=30, color="black", size=1, position=position_dodge()) +
  xlim(0,850) +
  ylim(0,850) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width [um]") +
  ylab("Measured PDMS Channel Width [um]") +
  annotate("text", label = "B9", x = 0, y = 800, size = 8, colour = "black", hjust = 0)

df2<-subset(dfPlot, Printer == "B9")[!(subset(dfPlot, Printer == "B9"))$Nominal.Dimension..um.==30 | (subset(dfPlot, Printer == "B9"))$Nominal.Dimension..um.==50]
df2<-subset(subset(dfPlot, Printer == "B9"), Nominal.Dimension..um.!=30 & Nominal.Dimension..um.!=50)



# Mean vs Nominal (B9, FOR TYLER)
ggplot(subset(df2, Printer == "B9")) +
  geom_point(aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Type), size=7) +
  geom_abline(intercept=0, slope=1, color = "black", size=1, linetype = "dashed") +
  geom_errorbar(aes(x=Nominal.Dimension..um., 
                    ymin=Mean.Value..um.-Standard.Error.of.Mean, 
                    ymax=Mean.Value..um.+Standard.Error.of.Mean),
                width=30, color="black", size=1, position=position_dodge()) +
  xlim(0,700) +
  ylim(0,700) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal") +
  ylab("Measured") +
  annotate("text", label = "[um]", x = 550, y = 50, size = 8, colour = "black", hjust = 0)


# Mean vs Nominal (Form2)
ggplot(subset(dfPlot, Printer == "Form2")) +
  geom_point(aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Type), size=7) +
  geom_abline(intercept=0, slope=1, color = "black", size=1, linetype = "dashed") +
  geom_errorbar(aes(x=Nominal.Dimension..um., 
                    ymin=Mean.Value..um.-Standard.Error.of.Mean, 
                    ymax=Mean.Value..um.+Standard.Error.of.Mean),
                    width=30, color="black", alpha=1, size=1, position=position_dodge()) +
  xlim(0,850) +
  ylim(0,850) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width [um]") +
  ylab("Measured PDMS Channel Width [um]") +
  annotate("text", label = "Form 2", x = 0, y = 800, size = 8, colour = "black", hjust = 0)

# Mean vs Nominal (Form3)
ggplot(subset(dfPlot, Printer == "Form3")) +
  geom_point(aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Type), size=7) +
  geom_abline(intercept=0, slope=1, color = "black", size=1, linetype = "dashed") +
  geom_errorbar(aes(x=Nominal.Dimension..um., 
                    ymin=Mean.Value..um.-Standard.Error.of.Mean, 
                    ymax=Mean.Value..um.+Standard.Error.of.Mean),
                    width=30, color="black", alpha=1, size=1, position=position_dodge()) +
  xlim(0,850) +
  ylim(0,850) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width [um]") +
  ylab("Measured PDMS Channel Width [um]") +
  annotate("text", label = "Form 3", x = 0, y = 800, size = 8, colour = "black", hjust = 0)

# Mean vs Nominal (Phrozen)
ggplot(subset(dfPlot, Printer == "Phrozen")) +
  geom_point(aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Type), size=7) +
  geom_abline(intercept=0, slope=1, color = "black", size=1, linetype = "dashed") +
  geom_errorbar(aes(x=Nominal.Dimension..um., 
                    ymin=Mean.Value..um.-Standard.Error.of.Mean, 
                    ymax=Mean.Value..um.+Standard.Error.of.Mean),
                    width=30, color="black", alpha=1, size=1, position=position_dodge()) +
  xlim(0,850) +
  ylim(0,850) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width [um]") +
  ylab("Measured PDMS Channel Width [um]") +
  annotate("text", label = "Phrozen", x = 0, y = 800, size = 8, colour = "black", hjust = 0)

## Work in progress

# Mean vs Nominal (No regression) (All)
ggplot(dfPlot) +
  geom_point(aes(x=Nominal.Dimension..um., y=Mean.Value..um., color=Printer), size=5) +
  geom_abline(intercept=0, slope=1, color = "black", size=1, linetype = "dashed") +
  scale_x_continuous(breaks = seq(0, 700, by = 100)) +
  scale_y_continuous(breaks = seq(0, 700, by = 100)) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width [um]") +
  ylab("Measured PDMS Channel Width [um]")

# Percent Change Bar (All)
ggplot(dfPlot) +
  geom_hline(yintercept=0) +
  geom_bar(aes(x=Nominal.Dimension..um., y=Percent.Change, fill=Printer), stat="identity", color="black", size=1, position=position_dodge()) +
  geom_errorbar(aes(x=Nominal.Dimension..um., ymin=Percent.Change-Standard.Error.of.Percent.Change, ymax=Percent.Change+Standard.Error.of.Percent.Change, fill=Printer), position=position_dodge(0.9), width=0.3, color="black", alpha=1, size=1.2) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Surface Treatments") +
  ylab("Percent Change of Channel Width [%]")

# Percent Change vs Nominal (All)
ggplot(dfPlot) +
  geom_point(aes(x=Nominal.Dimension..um., y=Percent.Change, color=Printer), size=5) +
  scale_x_continuous(breaks = seq(0, 700, by = 100)) +
  scale_y_continuous(breaks = seq(0, 1500, by = 250)) +
  scale_color_brewer(palette = "Paired") +
  science_theme +
  xlab("Nominal PDMS Channel Width (um)") +
  ylab("Percent Change in Width (%)")


detach("package:datasets", unload = TRUE)
dev.off()
cat("\014")
