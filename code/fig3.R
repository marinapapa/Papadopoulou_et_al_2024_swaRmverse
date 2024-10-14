###########################################################
## Figure 3. from Papadopoulou et al. (2024) swaRmverse
## Author: Marina Papadopoulou 
## Year: 2024

## Required packages
# install.packages('ggplot2')
# install.packages('swaRmverse')
# install.packages('extrafont')

##########
## Fig. 3A - Example tracks of goats and sheep

## Files exported by goats_vs_sheep.R
traj_sheep <- read.csv('../data/sheep_eg_track.csv')
traj_goats <- read.csv('../data/goats_eg_track.csv')

## Visualize a track
#extrafont::loadfonts('win') ## For font 

p3a <- ggplot(df_gt_l[[1]], aes(x, y, group = as.factor(id))) + 
  geom_path(linewidth = 1.5, color = 'black', alpha = 0.8) +
  geom_path(linewidth = 1, color = "#E1AF00", alpha = 0.6) +
  geom_path(data = df_sh_l[[1]][df_sh_l[[1]]$nnd < 20,], aes(x,y), color = 'black', linewidth = 1.5, alpha = 0.9) +
  geom_path(data = df_sh_l[[1]][df_sh_l[[1]]$nnd < 20,], aes(x,y), color = 'cornsilk', linewidth = 1, alpha = 0.6) +
  theme_bw() +
  geom_text(aes(x = 15.7425, y = -22.3817), family = 'Trebuchet MS', size = 5,
            label = paste0(round(swaRm::linear_dist(x = c(15.7415, 15.7435), y = c(-22.382,-22.382), geo = T)[2], 1), ' m'))+
  geom_segment(aes(x = 15.7415, xend = 15.7435, y = -22.382, yend = -22.382), linewidth = 0.8)+
  geom_segment(aes(x = 15.7435, xend = 15.7435, y = -22.3819, yend = -22.3821), linewidth = 0.8)+
  geom_segment(aes(x = 15.7415, xend = 15.7415, y = -22.3819, yend = -22.3821), linewidth = 0.8)+
  ggplot2::labs(
    y = 'Latitude',
    x  =  'Longitude'
  )+
  coord_equal()+
  ggplot2::theme(legend.position = 'top',
                 panel.grid = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(color = 'black', size = 16, family = 'Trebuchet MS'),
                 axis.text = ggplot2::element_blank(), 
  )

##########
## Fig. 3B - NND distributions

## Files exported by goats_vs_sheep.R, pairwise metrics
pm_sh <- read.csv('../data/sheep_pm.csv')
pm_gt <- read.csv('../data/goats_pm.csv')

## Plot
p3b <- ggplot(pm_sh, aes(x = nnd)) + 
  geom_density(fill = 'cornsilk', linewidth = 0.8)+
  geom_density(data = pm_gt, aes(x = nnd), fill = "#E1AF00", alpha = 0.6, linewidth = 0.8) +
  theme_bw() +
  ggplot2::labs(
    x  =  'NND (m)',
    y = 'Density'
  )+
  scale_x_continuous(expand = c(0,0.1), breaks = c(0, 2, 4, 6, 8, 10), limits = c(0, 10))+ ## limit for visualization (long tail)
  
  ggplot2::scale_color_manual(
    values = pal  )+
  ggplot2::theme(legend.position = 'none',
                 panel.grid = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(color = 'black', size = 16, family = 'Trebuchet MS'),
                 axis.text = ggplot2::element_text(color = 'black', size = 14, family = 'Trebuchet MS'),
                 legend.title = ggplot2::element_text( size = 12, family = 'Trebuchet MS'),
                 legend.text = ggplot2::element_text( size = 12, family = 'Trebuchet MS') 
  )


##########
## Fig. 3C - Speed timeseries

## Files exported by goats_vs_sheep.R, group timeseries
gm_sh <- read.csv('../data/sheep_gm.csv')
gm_gt <- read.csv('../data/goats_gm.csv')

## cut outliers for visualization
gm_gt <- gm_gt[complete.cases(gm_gt),]
gm_sh <- gm_sh[complete.cases(gm_sh),]
gm_gt <- gm_gt[gm_gt$speed_av < 10,]
gm_sh <- gm_sh[gm_sh$speed_av < 10,]

## Make time track specific
gm_gt$time <- as.numeric(gm_gt$t - min(gm_gt$t) )
gm_sh$time <- as.numeric(gm_sh$t - min(gm_sh$t) )

p3c <- ggplot(gm_gt, aes(x = time/60, y = speed_av)) + 
  
  geom_line(color = 'black', linewidth = 1.2)+
  geom_line(color = "#E1AF00", linewidth = 0.8)+
  geom_line(data = gm_sh, aes(x = time/60, y = speed_av), 
            color = 'black', alpha = 0.8, linewidth = 1.2) +
  geom_line(data = gm_sh, aes(x = time/60, y = speed_av), 
            color = 'cornsilk', alpha = 0.9, linewidth = 0.8) +
  scale_x_continuous( expand = c(0,2), limits = c(0, 7200/60),
                      breaks = c(0, 30, 60, 80, 100, 120 ))+
  ylim(c(0,1.5))+
  theme_bw() +
  ggplot2::labs(
    x  =  'Time (min)',
    y = 'Speed (m/s)'
  )+
  ggplot2::theme(legend.position = 'none',
                 panel.grid = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(color = 'black', size = 16, family = 'Trebuchet MS'),
                 axis.text = ggplot2::element_text(color = 'black', size = 14, family = 'Trebuchet MS'),
                 legend.title = ggplot2::element_text( size = 12, family = 'Trebuchet MS'),
                 legend.text = ggplot2::element_text( size = 12, family = 'Trebuchet MS') 
  )


##########
## Fig. 3D - Swarm Space

## Files exported by goats_vs_sheep.R, group timeseries
all_m <- read.csv('../data/goats_vs_sheep_metrics.csv')

## Run swarm space and check PCA
ss_sg <- swaRmverse::swarm_space(all_m, space_type = 'pca')
summary(ss_sg$pca)
ss_sg$pca$rotation

## Plot with main variables of PC1 and PC2

scores <- data.frame(species = ss_sg$swarm_space$species, ss_sg$pca$x[,1:3])
arrows <- as.data.frame(ss_sg$pca$rotation)

lam1 <- (ss_sg$pca$sdev[1:2]*sqrt(10))# ^0.5
len1 <- t(t(ss_sg$pca$rotation[, 1:2]) * lam1)#*0.8

p3d <- ggplot2::ggplot(scores) +
  
  ggplot2::labs(fill = 'Species:', shape = 'Species:', y = 'PC2',
                x = 'PC1 ')+
  ## PC1 
  ggplot2::scale_fill_manual(values = c("#E1AF00", 'cornsilk'),
                             labels = c('Goats', 'Sheep'))+
  ggplot2::scale_shape_manual(values = c(21, 23),
                              labels = c('Goats', 'Sheep'))+
  ggplot2::geom_segment(ggplot2::aes(x = 0, y = 0, xend = len1['mean_mean_nnd', 1], yend = len1['mean_mean_nnd', 2] ),
                        color = 'grey5', size = 1.2, arrow = ggplot2::arrow(length = unit(0.3, 'cm')))+
  ggplot2::geom_text(label = 'NND', x =len1['mean_mean_nnd', 1] + 0.3, y = len1['mean_mean_nnd', 2]+ 0.2, size = 5,
                     vjust = 1,  family = 'Trebuchet MS')+
  
  ggplot2::geom_segment(ggplot2::aes(x = 0, y = 0, xend = len1['stdv_speed', 1], yend = len1['stdv_speed', 2] ),
                        color = 'grey20', size = 1.2, arrow = ggplot2::arrow(length = unit(0.3, 'cm')))+
  ggplot2::geom_text(label = 'Speed Var.', x =len1['stdv_speed', 1] - 0.3, y = len1['stdv_speed', 2]-0.2, size = 5,
                     vjust = 1,  family = 'Trebuchet MS')+
  
  ### PC2
  
  ggplot2::geom_segment(ggplot2::aes(x = 0, y = 0, xend = len1['mean_pol', 1], yend = len1['mean_pol', 2] ),
                        color = 'grey10', size = 1.2, arrow = ggplot2::arrow(length = unit(0.3, 'cm')))+  ggplot2::theme_bw() +
  ggplot2::geom_text(label = 'Polarization', x =len1['mean_pol', 1], y = len1['mean_pol', 2]-0.3, size = 5,
                     vjust = 1,  family = 'Trebuchet MS')+
  
  ggplot2::geom_segment(ggplot2::aes(x = 0, y = 0, xend = len1['mean_shape', 1], yend = len1['mean_shape', 2] ),
                        color = 'grey20', size = 1.2, arrow = ggplot2::arrow(length = unit(0.3, 'cm')))+
  ggplot2::geom_text(label = 'Shape', x =len1['mean_shape', 1] + 0.5, y = len1['mean_shape', 2]+0.5, size = 5,
                     vjust = 1,  family = 'Trebuchet MS')+
  
  ggplot2::geom_point(ggplot2::aes(x = PC1, y = PC2, fill = species, shape = species),
                      size = 3, alpha = 0.7, stroke = 1)+
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = 'top',
                 legend.direction = 'horizontal',
                 panel.grid = element_blank(),
                 plot.title.position = 'panel',
                 text = ggplot2::element_text( size = 18, family = 'Trebuchet MS', hjust = 0.5),
                 legend.text = ggplot2::element_text( size = 18, family = 'Trebuchet MS', hjust = 0.5),
                 legend.title = ggplot2::element_text( size = 18, face = 'bold', family = 'Trebuchet MS', hjust = 0.5),
                 legend.box.background = element_rect(color = 'black', linewidth = 1),
                 axis.title = ggplot2::element_text( size = 16, family = 'Trebuchet MS'),
                 axis.text = ggplot2::element_text( size = 14, family = 'Trebuchet MS'),
  ) +
  ggplot2::guides(shape = ggplot2::guide_legend(override.aes = list(size = 8)),
                  fill = ggplot2::guide_legend(override.aes = list(size = 8)))

##########
## Fig. 3E-F - Polarization & Shape variation

thetheme <- theme_bw() + theme(
  legend.position = 'none',
  axis.title = ggplot2::element_text( size = 16, family = 'Trebuchet MS'),
  axis.title.x = ggplot2::element_blank(),
  axis.text = ggplot2::element_text( size = 14, family = 'Trebuchet MS', color = 'black'),
  panel.grid = element_blank()
)

p3e <- ggplot(all_m, aes(x = species, y = mean_pol, fill= species)) + 
  labs(y = 'Polarization') +
  scale_x_discrete(labels = c('Goats', 'Sheep'), breaks = c('goats', 'sheep')) +
  scale_y_continuous(breaks = c(0.7, 0.8, 0.9, 1.0)) +
  geom_boxplot(alpha = 0.9, width = 0.6) +
  scale_fill_manual(values = c("#E1AF00", 'cornsilk'))+
  thetheme

p3f <- ggplot(all_m, aes(x = species, y = sd_shape, fill= species)) + 
  labs(y = 'Shape Variation') +
  scale_x_discrete(labels = c('Goats', 'Sheep'), breaks = c('goats', 'sheep')) +
  scale_y_continuous(breaks = c(0.2, 0.3, 0.4, 0.5)) +
  geom_boxplot(alpha = 0.9, width = 0.6) +
  scale_fill_manual(values = c("#E1AF00", 'cornsilk'))+
  thetheme

#####################################
## Merge in figure

mainleg <- cowplot::get_plot_component(p3d, 'guide-box-top', return_all = TRUE)
cowplot::ggdraw(mainleg) 

pl1a  <- cowplot::plot_grid(mainleg, p3a, nrow = 2, rel_heights = c(0.15,1))

pl1bc <- cowplot::plot_grid(p3b, p3c, labels = c('B','C'), nrow = 2)
pl1 <- cowplot::plot_grid(pl1a, pl1bc, nrow = 1)

pl2 <- cowplot::plot_grid(p3d + theme(legend.position = 'none'),
                         p3e, p3f, labels = c('D', 'E', 'F'), rel_widths = c(1,0.4,0.4), nrow = 1)

Fig3 <- cowplot::plot_grid(pl1, pl2, labels = c('A', ''), nrow = 2)

Fig3

# ggplot2::ggsave(filename = '../output/Fig3.png',
#                 plot =  Fig3,
#                 width = 12,
#                 height = 9, 
#                 dpi = 300)

##################################################
####    the End       ############################