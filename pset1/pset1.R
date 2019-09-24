library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
setwd("~/Uni/2019T3/econ3203")


# Question 1
df <- read_csv("data/pset1/anscombe.csv")

summary(df)

l1 <- lm(y1~x123, data = df)
l2 <- lm(y2~x123, data = df)
l3 <- lm(y3~x123, data = df)

summary(l1)
summary(l2)
summary(l3)

# 
# df %>% 
#   select(y1, y2, y3, x123) %>% 
#   gather("yversion", "yval", -x123) %>% 
#   ggplot(aes(x123, yval)) +
#   geom_point() + 
#   geom_smooth(method = "lm", se = F, color = "red") +
#   geom_point(df, aes(x4, y4)) +
#   geom_smooth(df, aes(x4, y4), method = "lm", se = F, color = "red") +
#   facet_wrap(~yversion)
df %>% 
  gather("xversion", "xval", x123, x4) %>% 
  gather("yversion", "yval", -xversion, -xval) %>% 
  filter((xversion == "x123" & yversion %in% c("y1", "y2", "y3")) | (xversion == "x4" & yversion == "y4")) %>% 
  ggplot(aes(xval, yval)) +
  geom_point() + 
  geom_smooth(method = "lm", se = F, color = "red") + 
  facet_wrap(~yversion) +
  labs(title = "Anscombe's quartet", y = "y value", x = "x value")

# Question 2


#tab seperator
play <- read_tsv("data/pset1/playbill.csv")

ggplot(play, aes(lastweek, currentweek)) +
  geom_point() +
  geom_smooth(method = "lm", se = 0.95)

playlm <- lm(currentweek ~ lastweek, data = play)
summary(playlm)

confint(playlm, "lastweek")

# a)
# yes as `1 is between 0.95 and 1.01

# b)
playlm
## no as the intercept is not equal to 10000

# c) 
predict(playlm, data.frame(lastweek = 400000), interval = "prediction")
# no, as it's not within  the predition interval

#d )

# yes as the slope is close to 1


## Question 3

