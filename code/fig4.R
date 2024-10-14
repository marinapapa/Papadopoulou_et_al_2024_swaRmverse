###########################################################
## Figure 4. from Papadopoulou et al. (2024) swaRmverse
## Author: Marina Papadopoulou 
## Year: 2024

## Required packages
# install.packages('wesanderson')
# install.packages('ggplot2')
# install.packages('swaRmverse')
# install.packages('extrafont')

##########
## Fig. 3A - Expanded swarm space

## File from package
all_data <- swaRmverse::multi_species_metrics
head(all_data)

## File output from the goats_vs_sheep.R file
new_m <- read.csv('../data/goats_vs_sheep_metrics.csv')
all_data <- rbind(all_data[,c(12,1:11)], new_m[,c(1, 5:14,16)])
# extrafont::loadfonts()

## Expand existing pca space to include the new data
new_pca <- swaRmverse::expand_pca_swarm_space(metrics_data = all_data,
                                              pca_space = swaRmverse::multi_species_pca
)

## Plot the PCA space (PC1-PC2)

p4A <- ggplot2::ggplot(
  new_pca, 
  ggplot2::aes(x = PC1, y = PC2, fill = species, shape = species)
) +
  ggplot2::geom_point(color = 'black', size = 3, stroke = 1, alpha = 0.8) +
  ggplot2::labs(
    fill = '',
    shape = '',
    y = 'PC2',
    x  =  'PC1',
    title = 'Swarm space',
    subtitle = 'Expanded space'
  )+
  ggplot2::scale_fill_manual(
    values = c( pal[1],  pal[4], '#2A5D64', pal[5], 'darkred', 'cornsilk'),
    breaks = c('chacma_baboons','goats', 'sticklebacks', 'pigeons', 'pigeonoids', 'sheep'),
    labels = c('Baboons','Goats', 'Sticklebacks', 'Pigeons',  'Pigeon ABM', 'Sheep')
  )+
  ggplot2::scale_shape_manual(
    values = c(  21,23, 22,24, 24, 25),
    labels = c('Baboons','Goats', 'Sticklebacks', 'Pigeons',  'Pigeon ABM', 'Sheep'),
    breaks = c('chacma_baboons','goats', 'sticklebacks', 'pigeons', 'pigeonoids', 'sheep')
  )+
  ggplot2::theme_bw() +
  ggplot2::xlim(c(-4.5,4.5))+
  ggplot2::theme(legend.position = 'bottom',legend.justification = 'center',
                 plot.title = ggplot2::element_blank(),
                 legend.key.size = ggplot2::unit(0.5, "cm"),
                 legend.margin = ggplot2::margin(0,0,0,0),
                 legend.box.margin = ggplot2::margin(00,0,0,0),
                 panel.grid = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(color = 'black', size = 18, family = 'Trebuchet MS'),
                 axis.text = ggplot2::element_text(color = 'black', size = 16, family = 'Trebuchet MS'),
                 plot.subtitle = ggplot2::element_text(color = 'black', size = 18, family = 'Trebuchet MS', hjust = 0.5),
                 legend.title = ggplot2::element_text( size = 18, family = 'Trebuchet MS'),
                 legend.text = ggplot2::element_text( size = 18, family = 'Trebuchet MS') 
  )+
  ggplot2::guides(fill = ggplot2::guide_legend(nrow = 2, title.hjust = 0.5, jus = 'center'))


##########
## Fig. 3B - Biohybrid swarm space

## File output from the biohybrid_space.R file
all_data <- read.csv('../data/all_species_and_model_metrics.csv') 
pal <- wesanderson::wes_palette('Zissou1', 5)

## Run new PCA including the new simulated data
new_pca <- swaRmverse::swarm_space(metrics_data = all_data, space_type = 'pca')

p4B <- ggplot2::ggplot(
  new_pca$swarm_space, 
  ggplot2::aes(x = PC1, y = PC2, fill = species, shape = species)
  ) +
  ggplot2::geom_point(color = 'black', size = 3, stroke = 1, alpha = 0.8) +
  ggplot2::labs(
    fill = '',
    shape = '',
    y = 'PC2',
    x  =  'PC1',
    subtitle = 'New space',
    title = 'Swarm space',
    )+
  ggplot2::scale_fill_manual(
    values = c( pal[1],  pal[4], '#2A5D64', pal[5], 'darkred'),
    breaks = c('baboons','goats', 'fish', 'pigeons', 'pigeonoids'),
    labels = c('Baboons','Goats', 'Sticklebacks', 'Pigeons',  'Pigeon ABM')
    )+
  ggplot2::scale_shape_manual(
    values = c(  21,23, 22,24, 24),
    labels = c('Baboons','Goats', 'Sticklebacks', 'Pigeons',  'Pigeon ABM'),
    breaks = c('baboons','goats', 'fish', 'pigeons', 'pigeonoids')
    )+
  ggplot2::annotate("text", x = -5, y = 3, label = "A") +
  ggplot2::theme_bw() +
  ggplot2::xlim(c(-4,4))+
  ggplot2::ylim(c(-3,3))+
  ggplot2::theme(legend.position = 'bottom',legend.justification = 'center',
                 plot.title = ggplot2::element_blank(),
                 legend.key.size = ggplot2::unit(0.5, "cm"),
                 legend.margin = ggplot2::margin(0,0,0,0),
                 legend.box.margin = ggplot2::margin(00,0,0,0),
                 panel.grid = ggplot2::element_blank(),
                 
                 axis.title = ggplot2::element_text(color = 'black', size = 18, family = 'Trebuchet MS'),
                 plot.subtitle = ggplot2::element_text(color = 'black', size = 18, family = 'Trebuchet MS', hjust = 0.5),
                 axis.text = ggplot2::element_text(color = 'black', size = 16, family = 'Trebuchet MS'),
                 legend.title = ggplot2::element_text( size = 18, family = 'Trebuchet MS'),
                 legend.text = ggplot2::element_text( size = 18, family = 'Trebuchet MS') 
                 )+
  ggplot2::guides(fill = ggplot2::guide_legend(nrow = 2, title.hjust = 0.5, jus = 'center'))


##########
## Fig. 4C - Relative position of neighbors in goats

## File output from the sensitivity_analysis.R file
data_df <- read.csv('../data/goats_pairwise_data.R')

pal2 <- c('#0071bc','#8dbde2', '#f7931e', '#c1272d', '#131025')

p4C <- ggplot2::ggplot(data_df[data_df$nnd < 5 & data_df$nnd > 0.1,], ## clean out outliers for visuals
                      ggplot2::aes(x = nnx, y = nny)) +
  ggplot2::stat_bin_hex(bins = 15, color = 'grey10', linewidth = 0.2) +
  ggplot2::labs(
    x = 'NN - X', 
    y = 'NN - Y', 
    title = '',
    fill = 'Density') +
  ggplot2::scale_fill_gradientn(colours = pal2) +
  ggplot2::ylim(c(-5,5)) +
  ggplot2::geom_point(x = 0, y = 0, size = 2, shape = 17, color = 'white') +
  ggplot2::theme_bw() +
  ggplot2::coord_equal()+
  ggplot2::theme(legend.position = 'top',
                 plot.title = ggplot2::element_blank(),
                 legend.key.size = ggplot2::unit(0.5, "cm"),
                 legend.margin = ggplot2::margin(0,0,0,0),
                 legend.box.margin = ggplot2::margin(0,-10, -10, -10),
                 panel.grid = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(color = 'black', size = 16, family = 'Trebuchet MS'),
                 axis.text = ggplot2::element_text(color = 'black', size = 16, family = 'Trebuchet MS'),
                 legend.title = ggplot2::element_text( size = 18, family = 'Trebuchet MS'),
                 legend.text = ggplot2::element_text( size = 12, family = 'Trebuchet MS') )+
  ggplot2::guides(fill = ggplot2::guide_colorbar(ticks.colour = 'black',
                                                 title.position = "left", title.vjust = 0.9,
                                                 label.vjust = 2.5,
                                                 frame.colour = "black",
                                                 barwidth = 6,
                                                 barheight = 1)
                  )


######################
## Merge and save plot

Fig4 <- cowplot::plot_grid(p4A, p4B, p4C,labels = 'AUTO', nrow = 1)

Fig4
#ggsave(Fig4, filename = '../output/Fig4.png', width = 14, height = 5 )

##################################################
####    the End       ############################
