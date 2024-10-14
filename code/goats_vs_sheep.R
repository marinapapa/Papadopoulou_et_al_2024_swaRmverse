###########################################################
## Biohybrid Swarm Space from Papadopoulou et al. (2024) swaRmverse
## Author: Marina Papadopoulou 
## Year: 2024

## Required packages
# install.packages('swaRmverse')
# install.packages('data.table')

###########################################################
## Biohybrid Swarm Space from Papadopoulou et al. (2024) swaRmverse
## Author: Marina Papadopoulou 
## Year: 2024
## Data: The trajectories of sheep and goats are kindly provided by Lisa 'O Bryan 
##      (https://obryan.rice.edu/), please contact her with any inquiries.
##

## Required packages
# install.packages('swaRmverse')
# install.packages('data.table')

#################
## 1. Sheep flock

## Load data
## Should be saved in the *data* folder.
rawpath <- '../data/sheep_data.txt'
df_raw <- read.csv(rawpath, sep = '\t')

## Format & analysis in swaRmverse
df_sh <- swaRmverse::set_data_format(raw_x = df_raw$Lon,
                                     raw_y = df_raw$Lat,
                                     raw_id = df_raw$id,
                                     raw_t = df_raw$Time,
                                     tz = 'Africa/Windhoek'
                                     )

# ## Check IDs
# unique(df_sh$id)
df_sh_l <- swaRmverse::add_velocities(df_sh, geo = TRUE, verbose = TRUE)
pm_sh <- swaRmverse::pairwise_metrics(df_sh_l, geo = TRUE)

## Check for individuals not being together or GPS errors
hist(pm_sh$nnd)
summary(pm_sh$nnd)
nrow(pm_sh)

## Filter out based on selected threshold
pm_sh <- pm_sh[pm_sh$nnd < 50, ]
nrow(pm_sh)
## Resplit the dataframe in lists
df_sh_l <- split(pm_sh, pm_sh$set)
## or if nothing to filter out, just continue with group metrics timeseries

gm_sh <- swaRmverse::group_metrics_per_set(df_sh_l, 
                                           geo = TRUE, 
                                           step2time = 1,
                                           mov_av_time_window = 30)

## Summary metrics of collective motion, interactive thersholds
m_sh <- swaRmverse::col_motion_metrics(pm_sh, gm_sh, step2time = 1, verbose = TRUE,
                                      # pol_lim = 0.7, speed_lim = 0.43, # 0.75 and 0.5 quantiles
                                       noise_thresh = 10)

## Filter short events with few individuals
m_sh <- m_sh[m_sh$event_dur >= 15 & m_sh$N > 5,] 
nrow(m_sh)

## Add species label
m_sh$species <- 'sheep'


#################
## 2. Goat herd

rawpath <- '../data/goat_data.txt'
df_raw <- read.csv(rawpath, sep = '\t')
head(df_raw)

## Repeat as before
df_gt <- swaRmverse::set_data_format(raw_x = df_raw$Lon,
                                     raw_y = df_raw$Lat,
                                     raw_id = df_raw$id,
                                     raw_t = df_raw$Time
)
head(df_gt)
unique(df_gt$id)

df_gt_l <- swaRmverse::add_velocities(df_gt, geo = TRUE, verbose = TRUE)
pm_gt <- swaRmverse::pairwise_metrics(df_gt_l, geo = TRUE)
hist(pm_gt$nnd)
summary(pm_gt$nnd)

## Filter out based on selected threshold
pm_gt <- pm_gt[pm_gt$nnd < 50, ]

## resplit the dataframe in lists
df_gt_l <- split(pm_gt, pm_gt$set)

gm_gt <- swaRmverse::group_metrics_per_set(df_gt_l, geo = TRUE, 
                                           step2time = 1,
                                           mov_av_time_window = 30)

m_gt <- swaRmverse::col_motion_metrics(pm_gt, gm_gt, step2time = 1, verbose = TRUE,
                                       #pol_lim = 0.69, speed_lim = 0.51, 
                                       noise_thresh = 10)

head(m_gt)
m_gt <- m_gt[m_gt$event_dur >= 15 & m_gt$N > 1,] ## Filter short events
nrow(m_gt)

m_gt$species <- 'goats'

##############################
## Merge & Export

all_m <- rbind(m_sh[,1:16], m_gt)

## Save example trajectories, to be used in fig3.R
write.csv(df_sh_l[[1]], '../data/sheep_eg_track.csv', row.names = F)
write.csv(df_gt_l[[1]], '../data/goats_eg_track.csv', row.names = F)

## Save pairwise metrics timeseries, to be used in fig3.R
write.csv(pm_sh, '../data/sheep_pm.csv', row.names = F)
write.csv(pm_gt, '../data/goats_pm.csv', row.names = F)

## Save group timeseries, to be used in fig3.R
write.csv(gm_sh, '../data/sheep_gm.csv', row.names = F)
write.csv(gm_gt, '../data/goats_gm.csv', row.names = F)

## Save metrics to be used in fig3.R & fig4.R
write.csv(all_m, '../data/goats_vs_sheep_metrics`.csv', row.names = F)

