###########################################################
## Biohybrid Swarm Space from Papadopoulou et al. (2024) swaRmverse
## Author: Marina Papadopoulou 
## Year: 2024

## Required packages
# install.packages('swaRmverse')
# install.packages('data.table')

##########
## Load data
## The simulated_raw folder from this Zenodo repo: https://doi.org/10.5281/zenodo.4993109, 
## should be saved in the *data* folder.
rawpath <- '../data/simulated_raw/no_avoid'
df_raw <- list()
k <- 1
for (i in list.dirs(rawpath)){
  df_raw[[k]] <- read.csv(paste0(i, '/time_series.csv'))
  k <- k + 1
}
df_raw <- data.table::rbindlist(df_raw, idcol = TRUE)

df_raw$timestamp <- as.POSIXct(df_raw$time, origin = paste(Sys.Date(), '10:00:00'))
df_sim <- swaRmverse::set_data_format(raw_x = df_raw$posx,
                                      raw_y = df_raw$posy,
                                      raw_id = df_raw$id,
                                      raw_t = df_raw$timestamp,
                                      period = '0.2 sec',
                                      cont = df_raw$.id,
                                      tz = 'GMT'
)

p_sim <- swaRmverse::col_motion_metrics_from_raw(data = df_sim,
                                                 lonlat = FALSE,
                                                 parallelize_all = FALSE,
                                                 mov_av_time_window = 25,
                                                 step2time = 0.2
                                                 )
psim <- p_sim[p_sim$event_dur > 15,] ## Filter short events
psim$species <- 'pigeonoids'
psim <- psim[,!(colnames(psim) %in% c('group_size', 'set', 'event_dur'))]

## Load other data from swaRmverse and merge
all_data <- swaRmverse::multi_species_metrics #read.csv('data/all_species_events_metrics.csv')
head(all_data)
all_data <- rbind(all_data[,c(2:9,11, 12 ,14)], psim[,c(1:8,10,11,12)])
all_data <- all_data[complete.cases(all_data),]

## Write file to be used in fig3.R
write.csv(all_data, '../data/all_species_and_model_metrics.csv', row.names = F)
