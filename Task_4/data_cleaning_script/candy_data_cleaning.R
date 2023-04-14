# Cleaning Script for Candy Excel Data 2015, 2016, 2017


library(tidyverse)
library(janitor)
library(readxl)

candy_2015 <- read_excel("raw_data/boing-boing-candy-2015.xlsx")
candy_2016 <- read_excel("raw_data/boing-boing-candy-2016.xlsx")
candy_2017 <- read_excel("raw_data/boing-boing-candy-2017.xlsx")

# For each individual data set I did the following coded below:
# - cleaned and formatted columns and column headings.
# - removed columns which I did not believe would be required to answer the given
#   analysis questions.
# - Removed any item columns (total 19) from data base that I did not consider to be "candy".
#   ("Candy" features sugar as a principal ingredient)
# - Removed any candy bars which were fictional
# - Removed any miscellaneous items from list.

# Candy_2015 Cleaning

candy_2015 <- clean_names(candy_2015)

candy_2015_concise <- candy_2015 %>% 
  select(how_old_are_you:york_peppermint_patties)

candy_2015_rename <- candy_2015_concise %>% 
  rename(age = how_old_are_you,
         trick_or_treating = are_you_going_actually_going_trick_or_treating_yourself,
         bonkers_the_candy = bonkers,
         licorice_yes_black = licorice)

candy_2015_rename_concise <- candy_2015_rename %>% 
  select(-box_o_raisins, -cash_or_other_forms_of_legal_tender, 
         -dental_paraphenalia, -generic_brand_acetaminophen, -glow_sticks, 
         -broken_glow_stick, -creepy_religious_comics_chick_tracts, -healthy_fruit, 
         -hugs_actual_physical_hugs, -kale_smoothie, -lapel_pins, -spotted_dick,
         -peterson_brand_sidewalk_chalk, -peanut_butter_jars, -white_bread, 
         -whole_wheat_anything, - minibags_of_chips, -pencils,
         - vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein,
         - joy_joy_mit_iodine, -vicodin, - senior_mints, -mint_juleps, -sweetums)

# candy_2016 Cleaning

candy_2016 <- clean_names(candy_2016)

candy_2016_concise <- candy_2016 %>% 
  select(are_you_going_actually_going_trick_or_treating_yourself:york_peppermint_patties)

candy_2016_rename <- candy_2016_concise %>% 
  rename(trick_or_treating = are_you_going_actually_going_trick_or_treating_yourself,
         gender = your_gender,
         age = how_old_are_you,
         country = which_country_do_you_live_in,
         state_province_county = which_state_province_county_do_you_live_in,
         dark_chocolate_hershey = hersheys_dark_chocolate
  )

candy_2016_rename_concise <- candy_2016_rename %>% 
  select(-bonkers_the_board_game, -boxo_raisins, -broken_glow_stick, 
         -cash_or_other_forms_of_legal_tender, -chardonnay, 
         -creepy_religious_comics_chick_tracts, -dental_paraphenalia,
         -generic_brand_acetaminophen, -glow_sticks, -healthy_fruit,
         -hugs_actual_physical_hugs, -kale_smoothie, - minibags_of_chips, -pencils,
         -person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes,
         -spotted_dick, -vicodin, -white_bread, -whole_wheat_anything,
         - vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein,
         -joy_joy_mit_iodine, -senior_mints, mint_juleps, -sweetums_a_friend_to_diabetes, 
         -senior_mints, -mint_juleps)

# candy_2017 Cleaning

candy_2017 <- clean_names(candy_2017)

candy_2017_concise <- candy_2017 %>% 
  select(q1_going_out:q6_york_peppermint_patties) 

candy_2017_rename_concise <- candy_2017_concise %>%
  rename(trick_or_treating = q1_going_out,
         gender = q2_gender,
         age = q3_age,
         country = q4_country,
         state_province_county = q5_state_province_county_etc,
         x100_grand_bar = q6_100_grand_bar,
         dark_chocolate_hershey = q6_hersheys_dark_chocolate
         
  )

candy_2017_rename_concise <- candy_2017_rename_concise %>% 
  select(-q6_bonkers_the_board_game, -q6_boxo_raisins, -q6_broken_glow_stick, 
         -q6_cash_or_other_forms_of_legal_tender, -q6_chardonnay, 
         -q6_creepy_religious_comics_chick_tracts, -q6_dental_paraphenalia,
         -q6_generic_brand_acetaminophen, -q6_glow_sticks, -q6_healthy_fruit,
         -q6_hugs_actual_physical_hugs, -q6_senior_mints, -q6_kale_smoothie, 
         -q6_minibags_of_chips, -q6_mint_juleps, -q6_pencils,
         -q6_real_housewives_of_orange_county_season_9_blue_ray,
         -q6_sandwich_sized_bags_filled_with_boo_berry_crunch,
         -q6_spotted_dick, -q6_vicodin, -q6_white_bread, -q6_whole_wheat_anything,
         -q6_vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein,
         -q6_joy_joy_mit_iodine, -q6_senior_mints, -q6_sweetums_a_friend_to_diabetes)

# Removed q6_ from all column names in 2017 dataset

q6_pattern <- "q6\\_"

colnames(candy_2017_rename_concise) <- 
  str_replace_all(colnames(candy_2017_rename_concise), q6_pattern, "" )


# performed full join to keep all data from the three data sets and format all 
# common columns together.

candy_2015_2016 <- full_join(candy_2015_rename_concise, candy_2016_rename_concise)

candy_2015_2016_2017 <- full_join(candy_2015_2016, candy_2017_rename_concise)

#colnames(candy_2015_2016_2017)

#Combined data cleaning

#To deal with age column I decided to only work with values that contained numbers, 
#decimals or were NA. The limitation of this approach is that some ages written in
#characters may have been omitted. However this was a fast way of removing comments
#written in the age column. 

age_pattern_extract <- "\\d+\\.?\\d*|NA"

# The above regex pattern was used to extract all numbers, numbers with decimals and NAs.
# \\d+ Matches one or more digits (0-9).
# \\.? Matches an optional decimal point .
# \\d*: Matches zero or more digits after the decimal point.
# anything that contained characters/letters was converted to NA and then to 0. 

age_cleaned <- candy_2015_2016_2017 %>% 
  mutate(age = str_extract(age, age_pattern_extract),
         age = as.numeric(ifelse(is.na(age), 0, age)))


# age_cleaned %>% 
#   group_by(age) %>% 
#   summarise(count = n()) %>% 
#   arrange(desc(count))

# converted any values that were zero or greater than 100 years to NAs as I didn't
# think anyone aged below this would go out or get their paretns to fill out the 
#survey. Similarly any values over 100 were omitted for similiar reasons.
# One limitation here is that I could maybe have beens stricter to encompass a more narrow
# age range.

candy_info_age_cleaned <- age_cleaned %>% 
  mutate(age = if_else(age < 1 | age > 100, NA, age))

# candy_info_age_cleaned %>% 
#    group_by(age) %>% 
#    summarise(count = n()) %>% 
#    arrange(desc(count))

#Below I renamed and re-organised columns structure, removed any additional columns missed
#first time around that were not candy but were missed in initial clean. 

candy_info_cleaned <- candy_info_age_cleaned %>% 
  rename(anon_brown_globs_orange_black_wrappers = 
           anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
         restaurant_candy = candy_that_is_clearly_just_the_stuff_given_out_for_free_at_restaurants,
         black_licorice = licorice_yes_black,
         chick_o_sticks = chick_o_sticks_we_don_t_know_what_that_is
  ) %>% 
  select(-mint_leaves)

candy_info_cleaned %>% 
  group_by(country) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

#organised country column and values which were not specific to a country
#Europe or N.America were converted to NA. Further formatted columns that were 
#duplicates.

candy_country_cleaned <- candy_info_cleaned %>% 
  mutate(country = ifelse(
    country %in% c("USA", "United States of America", "United States", "US", 
                   "states", "usa", "Usa", "us", "united states", "United states",
                   "Us", "U.S.", "U.S.A", "united states of america	", "America", 
                   "america", "u.s.", "Murica", "US of A", "Unites States", 
                   "USA! USA! USA!", "United State", "Sub-Canadian North America... 'Merica", 
                   "The United States", "USSA", "United Sates", "United Stated", 
                   "'merica", "Ahem....Amerca", "Alaska", "California", 
                   "I pretend to be from Canada, but I am really from the United States.", 
                   "New Jersey", "New York", "North Carolina", "Pittsburgh", 
                   "The United States of America", "The Yoo Ess of Aaayyyyyy", 
                   "U S", "U.s.", "UNited States", 
                   "USA (I think but it's an election year so who can really tell)", 
                   "USA USA USA", "USA USA USA USA", "USA USA USA!!!!", "USA!", 
                   "USA! USA!", "USA!!!!!!", "USA? Hard to tell anymore..", 
                   "USAA", "USAUSAUSA","USa", "Unied States",
                   "United States of America", "United Statea", "United Statss", 
                   "United Stetes", "United staes", "United ststes", "Units States", 
                   "murrika", "the best one - usa", "u s a", "u.s.a.", "uSA", 
                   "unite states", "united States", "united ststes", "usas", 
                   "U.S.A.", "united states of america", "United States of America", 
                   "Merica"), 
    "United States of America", country),
    country = ifelse(
      country %in% c("UK", "Scotland", "uk", "England","Uk", "U.K.", 
                     "United Kingdom", "United Kindom", "United kingdom", "england"), 
      "United Kingdom", country),
    country = ifelse(
      country %in% c("Canada", "canada", "CANADA", "Canada`"), "Canada", country
    ), 
    country = ifelse(
      country %in% c("Germany", "germany"), "Germany", country
    ),
    country = ifelse(
      country %in% c("Australia", "australia"), "Australia", country
    ),
    country = ifelse(
      country %in% c("Netherlands", "netherlands", "The Netherlands"), 
      "The Netherlands", country),
    country = ifelse(
      country %in% c("France", "france"), 
      "France", country),
    country = ifelse(
      country %in% c("Sweden", "sweden"), 
      "Sweden", country),
    country = ifelse(
      country %in% c("Korea", "South Korea"), 
      "South Korea", country), 
    country = ifelse(
      country %in% c("Spain", "españa", "spain"), 
      "Spain", country),
    country = ifelse(
      str_detect(country, "[0-9]"), NA, country),
    country = ifelse(
      country %in% c("Trumpistan", "A", "A tropical island south of the equator", 
                     "Atlantis", "Can", "Canae", "Cascadia","Denial", "Earth", 
                     "Europe", "Fear and Loathing", "I don't know anymore",
                     "N. America", "Narnia", "Neverland", "Not the USA or Canada",
                     "See above", "Somewhere", "The republic of Cascadia", 
                     "UD", "god's country", "insanity lately", "one of the best ones",
                     "soviet canuckistan", "there isn't one for old men",
                     "this one", "unhinged states", "cascadia", "endland", "EUA"
      ),
      NA, country),
    country = ifelse(
      country == "UAE", "UAE", str_to_title(country))
  )

# checked content of country column still not perfect as I have two 
#"United States of America" but one only contains one entry so left this as is 
# for now as this shouldn't have a great effect on further analysis.  
# The rest of the countries were organised and converted to title case except "UAE". 
# candy_country_cleaned %>% 
#   group_by(country) %>% 
#     summarise(count = n()) %>% 
#     arrange(desc(count))

#examined sex column for any unusual values
# candy_country_cleaned %>% 
# group_by(gender) %>% 
#      summarise(count = n()) %>% 
#      arrange(desc(count))
#all values reasonable so no further cleaning was required.


# Finally I reordered the columns so that all candy ratings were  columns to the 
# right of gender,country,state_province_county columns.

candy_country_cleaned <- candy_country_cleaned %>%
relocate(gender,country,state_province_county, .before = butterfinger) 

write_csv(x = candy_country_cleaned, "clean_data/combined_candy_clean.csv")

# After reviewing analysis questions I also wrote the individually cleaned data
# sets for each year as CSV files.
write_csv(x = candy_2015_rename_concise, "clean_data/candy_2015_clean.csv")

write_csv(x = candy_2016_rename_concise, "clean_data/candy_2016_clean.csv")

write_csv(x = candy_2017_rename_concise, "clean_data/candy_2017_clean.csv")
