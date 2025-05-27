# 🚲 Cyclistic Bike-Share Case Study

## 1. Business Task

The purpose of this analysis is to help Cyclistic, a bike-share company in Chicago, understand how annual members and casual riders use their bikes differently. The goal is to identify user behavior patterns that can inform a targeted marketing strategy to convert casual riders into annual members.

This analysis will focus on exploring ride duration, day-of-week usage, and rideable types across user types. Key stakeholders include the marketing director Lily Moreno, the Cyclistic marketing analytics team, and the executive team who will evaluate the proposed strategies.

A successful analysis will lead to actionable insights that can be used to increase the number of profitable annual memberships.

## 2. Data Source
- Dataset: `divvy_clean_combined.csv` (12 months)
- Source: [Divvy Trip Data](https://docs.google.com/spreadsheets/d/1uCTsHlZLm4L7-ueaSLwDg0ut3BP_V4mKDo2IMpaXrk4/template/preview?resourcekey=0-dQAUjAu2UUCsLEQQt20PDA#gid=1797029090, https://docs.google.com/spreadsheets/d/179QVLO_yu5BJEKFVZShsKag74ZaUYIF6FevLYzs3hRc/template/preview#gid=640449855)
  ## Cleaned Dataset Preview
| ride_id          | rideable_type | started_at          | ended_at             | start_station_name         | end_station_name           |
|------------------|---------------|---------------------|----------------------|----------------------------|----------------------------|
| EACB19130BOCDA   | docked_bike   | 2020-01-21T20:06:00 | 2020-01-21T20:14:00  | Western Ave & Leland Ave   | Clark St & Montrose Ave    |
| 8FED874C809DC0   | docked_bike   | 2020-01-30T14:22:00 | 2020-01-30T14:26:00  | Clark St & Montrose Ave    | Broadway & Belmont Ave     |
| 789F3C21E472CAS  | docked_bike   | 2020-01-09T19:29:00 | 2020-01-09T19:32:00  | Broadway & Belmont Ave     | Clark St & Randolph St     |


## 3. Data Cleaning (R)
- Combined 2019 Q1 and 2020 Q1 datasets
- Added `ride_length`, `day_of_week`
- Filtered invalid durations
- Exported to `divvy_clean_combined.csv`
