## Set working directory
setwd("/Users/swkim728/Desktop/wesleyan/spring_2019/qac201/PROJECT")
## Install necessary packages
library(readr)
library(dplyr)
library(descr)
library(ggplot2)
library(gridExtra)
library(ggridges)
library(Hmisc)

## read in financial well-being survey data
cfpb = read_csv("NFWBS_PUF_2016_data.csv")

## removing observations with missing data
cfpb_full = cfpb %>%
  filter(SWB_2 != "-4" & SWB_2 != "-1") %>%
  filter(SWB_3 != "-4" & SWB_3 != "-1") %>%
  filter(CHANGEABLE != "-1") %>%
  filter(GOALCONF != "-1") %>%
  filter(PEM != "-1")


## factorizing columns
cols = c("SWB_2", "SWB_3", "CHANGEABLE", "GOALCONF", "PEM", 
         "generation", "fpl", "PPEDUC", "PPGENDER", "PPETHM")
cfpb_full[cols] = lapply(cfpb_full[cols], as.factor)

## Setting labels for response factors
labels_7 = c("Strongly disagree", "Disagree", "Somewhat disagree",
             "Neither",
             "Somewhat agree", "Agree", "Strongly agree")
labels_4 = c("Not at all confident", "Not very confident",
             "Somewhat confident", "Very confident")
labels_gen = c("Pre-Boomer", "Boomer", "Gen X", "Millenial")
labels_fpl = c("<100% FPL", "100%-199% FPL", "200%+ FPL")

levels(cfpb_full$SWB_2) = labels_7
levels(cfpb_full$SWB_3) = labels_7
levels(cfpb_full$CHANGEABLE) = labels_7
levels(cfpb_full$PEM) = labels_7
levels(cfpb_full$GOALCONF) = labels_4
levels(cfpb_full$generation) = labels_gen
levels(cfpb_full$fpl) = labels_fpl
cfpb_full$fpl = factor(cfpb_full$fpl, levels = c("200%+ FPL", "100%-199% FPL", "<100% FPL"))


## Association between "I am optimistic about my future" and FWBscore
lm_SWB_2 = lm(data = cfpb_full, FWBscore ~ SWB_2 + generation)
summary(lm_SWB_2)
## Association between "If I work hard today, I will be successful in the future" and FWBscore
lm_SWB_3 = lm(data = cfpb_full, FWBscore ~ SWB_3)
summary(lm_SWB_3)

## Does this significance survive even when accounting for other background variables?
mlm_SWB_2 = lm(data = cfpb_full, FWBscore ~ SWB_2 + PPEDUC + fpl + PPGENDER + PPETHM + generation)
summary(mlm_SWB_2)

mlm_SWB_3 = lm(data = cfpb_full, FWBscore ~ SWB_3 + PPEDUC + fpl + PPGENDER + PPETHM + generation)
summary(mlm_SWB_3)

## Comparing against generation
mlm_SWB_gen = lm(data = cfpb_full, FWBscore ~ SWB_2 + fpl)
summary(mlm_SWB_gen)



## VISUALIZATIONS
plotdata = cfpb_full %>%
  group_by(SWB_2, fpl) %>%
  summarize(n = n(),
            mean = mean(FWBscore),
            sd = sd(FWBscore),
            se = sd/sqrt(n))
pd = position_dodge(0.2)
ggplot(plotdata, aes(x = SWB_2,
                     y = mean,
                     group = fpl,
                     color = fpl)) +
  geom_point(position = pd, size = 3, alpha = 0.7) +
  geom_line(position = pd, size = 1, alpha = 0.7) +
  geom_errorbar(aes(ymin  =mean - se, 
                    ymax = mean+se), 
                width = .1, position = pd, alpha = 0.7) +
  labs(x = "I am optimistic about my future",
       y = "Financial well-being scale score",
       color = "Generation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 25, hjust = 1),
        axis.title.x = element_text(margin = margin(t = 20)),
        axis.title.y = element_text(margin = margin(r = 20)))


## RIDGEPLOT
ggplot(cfpb_full, 
       aes(x = FWBscore, y = SWB_2, fill = SWB_2)) +
  geom_density_ridges(alpha = 0.7) + 
  coord_cartesian(clip = "off") +
  labs(y = "\"I am optimistic about my future\"",
       x = "Financial well-being scale score \n",
       title = "Financial Well-Being Score by Optimism \n") +
  theme_minimal() +
  theme(legend.position = "none", 
        plot.title = element_text(size = 90, face = "bold"),
        axis.text = element_text(size = 40),
        axis.text.y = element_text(angle = 35),
        axis.title = element_text(size = 60, face = "bold"),
        axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 40, b = 0, l = 0)))

ggplot(cfpb_full, 
       aes(x = FWBscore, y = SWB_2, fill = SWB_2)) +
  geom_density_ridges(alpha = 0.7) + 
  facet_grid(fpl ~ .) +
  coord_cartesian(clip = "off") +
  labs(y = "\"I am optimistic about my future\"",
       x = "\n Financial well-being scale score \n",
       title = "Financial Well-Being Score and Optimism by Poverty Level \n") +
  theme_minimal() +
  theme(legend.position = "none", 
        plot.title = element_text(size = 90, face = "bold"),
        axis.text = element_text(size = 40),
        axis.text.y = element_text(angle = 35),
        axis.title = element_text(size = 60, face = "bold"),
        axis.title.x = element_text(margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 40, b = 0, l = 0)),
        strip.text.y = element_text(size = 40))


describe(cfpb_full$SWB_2)
summary(cfpb_full$SWB_2)
summary(cfpb_full$FWBscore)
describe(cfpb_full$FWBscore)






