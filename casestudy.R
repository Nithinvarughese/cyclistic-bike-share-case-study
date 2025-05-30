library(tidyverse)
library(readr)
library(lubridate)



divvy_2019 <- read_csv("Divvy_Trips_2019_Q1 - Divvy_Trips_2019_Q1.csv")
divvy_2020 <- read_csv("Divvy_Trips_2020_Q1 - Divvy_Trips_2020_Q1.csv")

colnames(divvy_2019)
colnames(divvy_2020)

 

divvy_2019 <- read_csv("Divvy_Trips_2019_Q1 - Divvy_Trips_2019_Q1.csv") %>%
  mutate(
    started_at = as_datetime(started_at),  # Ensure datetime format
    ended_at = as_datetime(ended_at)
  )

divvy_2020 <- read_csv("Divvy_Trips_2020_Q1 - Divvy_Trips_2020_Q1.csv") %>%
  mutate(
    started_at = as_datetime(started_at),  # Convert character to datetime
    ended_at = as_datetime(ended_at)
  )

divvy_clean <- bind_rows(divvy_2019, divvy_2020) %>%
  # Remove empty rows in critical columns
  drop_na(ride_id, started_at, ended_at, member_casual) %>%
  
  # Calculate ride length (minutes)
  mutate(
    ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")),
    
    # Add day of week (character + numeric)
    day_of_week = weekdays(started_at),
    day_of_week_num = wday(started_at)
  ) %>%
  
  # Filter invalid durations
  filter(
    ride_length > 1,       # Minimum 1 minute
    ride_length < 1440     # Maximum 24 hours
  ) %>%
  
  # Standardize member labels (if needed)
  mutate(
    member_casual = case_when(
      member_casual == "Subscriber" ~ "member",
      member_casual == "Customer" ~ "casual",
      TRUE ~ tolower(member_casual)  # Force lowercase
    )
  )

divvy_clean %>%
  group_by(member_casual, day_of_week, day_of_week_num) %>%
  summarise(
    number_of_rides = n(),
    avg_duration = mean(ride_length),
    .groups = 'drop'
  ) %>%
  arrange(member_casual, day_of_week_num)


summary(divvy_clean$ride_length)

# Check user type distribution
table(divvy_clean$member_casual)

write_csv(divvy_clean, "divvy_clean_combined.csv")

View(divvy_clean)

library(ggplot2)

# Plot number of rides
divvy_clean %>%
  group_by(member_casual, day_of_week) %>%
  summarise(rides = n(), .groups = 'drop') %>%
  ggplot(aes(x = day_of_week, y = rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Number of Rides by Day", x = "Day of Week", y = "Number of Rides") +
  scale_fill_manual(values = c("#1f77b4", "#ff7f0e")) +
  theme_minimal()

divvy_clean %>%
  count(member_casual) %>%
  ggplot(aes(x = member_casual, y = n, fill = member_casual)) +
  geom_col() +
  labs(title = "Total Rides by User Type", x = "User Type", y = "Ride Count") +
  theme_minimal()

divvy_clean %>%
  group_by(member_casual, rideable_type) %>%
  summarise(count = n(), .groups = "drop") %>%
  ggplot(aes(x = rideable_type, y = count, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title = "Bike Type Usage by User Type", x = "Rideable Type", y = "Count") +
  theme_minimal()
divvy_clean %>%
  count(member_casual, day_of_week) %>%
  ggplot(aes(x = day_of_week, y = member_casual, fill = n)) +
  geom_tile() +
  labs(title = "Ride Frequency Heatmap", x = "Day of Week", y = "User Type") +
  scale_fill_viridis_c() +
  theme_minimal()
ggsave("plots/ride_count_by_user_type.png")


