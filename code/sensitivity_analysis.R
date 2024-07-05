###########################################################
## Sensitivity Analysis from Papadopoulou et al. (2024) swaRmverse
## Author: Marina Papadopoulou 
## Year: 2024

## Required packages
# install.packages('swaRmverse')

## 1. Analyse goat data
load('../data/loc_data.RData')
raw <- loc_data

## swaRmverse pipeline
data_df <- swaRmverse::set_data_format(raw_x = raw$lon,
                                       raw_y = raw$lat,
                                       raw_t = raw$time,
                                       raw_id = raw$id,
                                       period = "1 sec",
                                       tz = "Africa/Windhoek",
                                       event = raw$event
)

smoothing_time_window <- 60 # seconds
data_dfs <- swaRmverse::add_velocities(
  data_df,
  geo = TRUE,
  verbose = TRUE
)

g_metr <- swaRmverse::group_metrics_per_set(
  data = data_dfs, 
  step2time = 1,
  mov_av_time_window = smoothing_time_window,
  geo = TRUE
)

data_df <- swaRmverse::pairwise_metrics(
  data_list = data_dfs, 
  add_coords = T,
  geo = TRUE,
  verbose = TRUE
)

## To be used for Figure 3B:
write.csv(data_df, '../data/goats_pairwise_data.R', row.names = FALSE) 

#########################
## Sensitivity analysis
lims <- seq(0, 1, 0.9)
lims <- expand.grid(lims, lims)
sl <- lims$Var1
sp <- lims$Var2

## events summary table to fill:
evsum <- data.frame(idx = NA, 
                    qls = sl, # quantile for speed
                    qlp = sp, # quantile for polarization
                    Nev = NA, 
                    tot_dur = NA,
                    dur_mean = NA,
                    dur_sd = NA,
                    dur_min = NA,
                    dur_max = NA)

for (i in 1:nrow(lims)){
  print(i)
  goat_new <- swaRmverse::col_motion_metrics(
    data_df,
    global_metrics = g_metr,
    speed_lim = quantile(g_metr$speed_av, lims$Var1[i], na.rm = T),
    pol_lim = quantile(g_metr$pol_av, lims$Var2[i], na.rm = T),
    step2time = 1,
    verbose = FALSE)
  
  evsum[evsum$qls == lims$Var1[i] & evsum$qlp == lims$Var2[i],] <- c(i, 
                                                                     lims$Var1[i], 
                                                                     lims$Var2[i],
                                                                     nrow(goat_new),
                                                                     sum(goat_new$event_dur),
                                                                     mean(goat_new$event_dur), 
                                                                     sd(goat_new$event_dur),
                                                                     min(goat_new$event_dur), 
                                                                     max(goat_new$event_dur))
}

## To be used for Figure 2:
write.csv(evsum, '../data/sens_analysis_goats.csv', row.names = F)

##################################################
####    the End       ############################