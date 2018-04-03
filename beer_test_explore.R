################################################################################
## prepare
################################################################################

# load packages
library(tidyverse)
library(explore)

# set proxy (if needed)
Sys.setenv(http_proxy = 'http://proxy.austria.local:8080')

################################################################################
## read data
################################################################################

# read data general
data_ge <- read_csv("https://raw.githubusercontent.com/rolkra/taste/master/beer_test_general.csv")
glimpse(data)

# read data unblinded
data_ub <- read_csv("https://raw.githubusercontent.com/rolkra/taste/master/beer_test_unblinded.csv")
glimpse(data_ub)

################################################################################
## analyse unblinded
################################################################################

# transform data (columns smell_* and taste_* as categories)
data_ub2 <- data_ub %>% gather(unblinded_test, score, smell_good:taste_good)
glimpse(data_ub2)

# calculate average score per category
data_ub3 <- data_ub2 %>% group_by(beer, unblinded_test) %>% summarize(mean_score = mean(score))
glimpse(data_ub3)

# plot 
data_ub3 %>%  ggplot(aes(x=unblinded_test, y=mean_score, fill=beer)) + 
  geom_col(position=position_dodge()) + 
  scale_fill_manual(values=c("darkgreen","orange")) +
  coord_flip()

# calculate diff
data_ub4 <- data_ub %>% 
  group_by(id) %>%
  summarize(smell_good_diff = max(smell_good) - min(smell_good),
            smell_sweet_diff = max(smell_sweet) - min(smell_sweet),
            smell_smoke_diff = max(smell_smoke) - min(smell_smoke),
            taste_heavy_diff = max(taste_heavy) - min(taste_heavy),
            taste_sweet_diff = max(taste_sweet) - min(taste_sweet),
            taste_bitter_diff = max(taste_bitter) - min(taste_bitter),
            taste_fresh_diff = max(taste_fresh) - min(taste_fresh),
            taste_harmony_diff = max(taste_harmony) - min(taste_harmony),
            taste_good_diff = max(taste_good) - min(taste_good)) %>% 
  mutate(smell_total_diff = smell_good_diff + smell_sweet_diff + smell_smoke_diff,
         taste_total_diff = taste_heavy_diff + taste_sweet_diff + taste_bitter_diff + 
           taste_fresh_diff + taste_harmony_diff + taste_good_diff) %>% 
  mutate(total_diff = smell_total_diff + taste_total_diff)

glimpse(data_ub4)


################################################################################
## explore data
################################################################################

data <- data_ge %>% inner_join(data_ub4, by="id")
glimpse(data)

## explore complete data
data %>%  explore()

# explore unblinded data
data_ub %>% 
  mutate(is_goesser = ifelse(beer == "Goesser", 1, 0),
         is_ottakringer = ifelse(beer == "Ottakringer", 1, 0)) %>% 
  explore()


################################################################################
## create model
################################################################################

# load packages
library(rpart)
library(rpart.plot)

# all attributes
data_model <- data
mod <- rpart(double_blinded_1 ~ ., 
             data = data_model,
             method = "class")

rpart.plot(mod)

# remove favorite beer
data_model <- data %>%  select(-favorite_beer)
mod <- rpart(double_blinded_1 ~ ., 
             data = data_model,
             method = "class")

rpart.plot(mod)

# select attributes
data_model <- data %>%  select(double_blinded_1, gender, smell_good_diff)
mod <- rpart(double_blinded_1 ~ ., 
             data = data_model,
             method = "class")

rpart.plot(mod)
