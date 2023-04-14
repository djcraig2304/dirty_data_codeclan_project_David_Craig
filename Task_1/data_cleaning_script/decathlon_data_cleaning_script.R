#decathlon.rds cleaning Script

library(tidyverse)
library(janitor)

decathlon <- read_rds("raw_data/decathlon.rds")

decathlon <- clean_names(decathlon)

# changed row name with athletes name to column, made all names lower case and 
# renamed columns to include measurement and measurement unit s = seconds, 
# m = metres. 

clean_decathlon <- decathlon %>%
  rownames_to_column(var = "name") %>%
  mutate(name = str_to_lower(name)) %>%
  rename("100m_time_s" = x100m,
         "long_jump_distance_m" = long_jump,
         "shot_put_distance_m" = shot_put,
         "high_jump_distance_m" = high_jump,
         "400m_time_s" = x400m,
         "110m_hurdles_time_s" = x110m_hurdle,
         "discus_distance_m" = discus,
         "pole_vault_height_m" = pole_vault,
         "javelin_throw_distance_m" = javeline,
         "1500m_time_s" = x1500m,
         "ranking" = rank,
         "total_points" = points
  )

write.csv(clean_decathlon, "clean_data/clean_decathlon.csv")
