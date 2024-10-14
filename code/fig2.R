###########################################################
## Figure 2. from Papadopoulou et al. (2024) swaRmverse
## Author: Marina Papadopoulou 
## Year: 2024

## Required packages
# install.packages('ggplot2')
# install.packages('swaRmverse')
# install.packages('extrafont')
# install.packages('cowplot')

##########
## Fig. 2 - Sensitivity analysis

## File output from the sensitivity_analysis.R file
evsum <- read.csv('../data/sens_analysis_goats.csv')
# extrafont::loadfonts()


evsum$thrp <- 'pol'
evsum$thrs <- 'sp'

p4leg <- ggplot2::ggplot(evsum[evsum$qls == 0.5,], ggplot2::aes(x = qlp, y = Nev))+
  ggplot2::geom_path(data = evsum[evsum$qlp == 0.5,],
                     ggplot2::aes(x = qls, y = dur_mean, linetype = as.factor(qlp)),  
                     inherit.aes = F,
                     color = 'darkred',
                     size = 0.6
                     )+
  ggplot2::geom_path(data = evsum[round(evsum$qlp,1) == 0.7,],
                     ggplot2::aes(x = qls, y = dur_mean, linetype = as.factor(qlp)),
                     inherit.aes = F,
                     color = 'darkred',
                     size = 0.6
                     )+
  ggplot2::geom_path(data = evsum[evsum$qlp == 0.2,], 
                     ggplot2::aes(x = qls, y = dur_mean, linetype = as.factor(qlp)),
                     inherit.aes = F,
                     color = 'darkred',
                     size = 0.6
                     )+
  ggplot2::scale_linetype_manual(name = "Polarization\ntheshold:",
                                 breaks = c(0.2, 0.5, 0.7),
                                 values = c('dashed', 'solid', 'dotted'),
                                 labels = c('0.2', '0.5', '0.7')
                                 ) +
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = c(0.9,0.8),
                 legend.key.size = ggplot2::unit(0.5, "cm"),
                 legend.margin = ggplot2::margin(0,0,0,0),
                 legend.box.margin = ggplot2::margin(0,-10, -10, -10),
                 legend.title = ggplot2::element_text( size = 12, family = 'Trebuchet MS'),
                 legend.text = ggplot2::element_text( size = 10, family = 'Trebuchet MS'))

p2A <- ggplot2::ggplot(evsum[evsum$qls == 0.5,], 
                       ggplot2::aes(x = qlp, y = Nev))+
  ggplot2::geom_path(data = evsum[evsum$qlp == 0.5,],
                     ggplot2::aes(x = qls, y = dur_mean, linetype = as.factor(qlp)), 
                     inherit.aes = F,
                     color = 'darkred', 
                     size = 0.6)+
  ggplot2::geom_point(data = evsum[evsum$qlp == 0.5,],
                      ggplot2::aes(x = qls, y = dur_mean),  
                      inherit.aes = F,
                      color = 'darkred', 
                      size = 1,
                      shape = 21)+
  ggplot2::geom_path(data = evsum[round(evsum$qlp,1) == 0.7,],
                     ggplot2::aes(x = qls, y = dur_mean, linetype = as.factor(qlp)),  
                     inherit.aes = F,
                     color = 'darkred',
                     size = 0.6)+
  ggplot2::geom_point(data = evsum[round(evsum$qlp,1) == 0.7,],
                      ggplot2::aes(x = qls, y = dur_mean), 
                      inherit.aes = F,
                      color = 'darkred',
                      size = 1, 
                      shape = 21)+
  ggplot2::geom_path(data = evsum[evsum$qlp == 0.2,], 
                     ggplot2::aes(x = qls, y = dur_mean, linetype = as.factor(qlp)), 
                     inherit.aes = F,
                     color = 'darkred', 
                     size = 0.6)+
  ggplot2::geom_point(data = evsum[evsum$qlp == 0.2,], ggplot2::aes(x = qls, y = dur_mean), 
                      inherit.aes = F,
                      color = 'darkred', 
                      size = 1,
                      shape = 21)+
  ggplot2::geom_path(size = 1, color = '#0071bc')+
  ggplot2::geom_path(data = evsum[evsum$qlp == 0.5,],
                     ggplot2::aes(x = qls, y = Nev), 
                     size = 1, 
                     inherit.aes = F,
                     color = '#0071bc')+
  ggplot2::geom_point(ggplot2::aes(shape = thrp), size = 2, stroke = 1, color = 'black')+
  ggplot2::geom_point(data = evsum[evsum$qlp == 0.5,],
                      ggplot2::aes(x = qls, shape = thrs, y = Nev), 
                      size = 2, 
                      stroke = 1,
                      color = 'black',
                      inherit.aes = F)+
  ggplot2::scale_shape_manual(name = "",
                              breaks = c('pol', 'sp'),
                              values = c(22, 21),
                              labels = c('Polarization', 'Speed')
                              ) +
  ggplot2::scale_linetype_manual(name = "Polarization.\nTheshold:",
                                 breaks = c(0.2, 0.5, 0.7),
                                 values = c('dashed', 'solid', 'dotted'),
                                 labels = c('0.2', '0.5', '0.7'), 
                                 guide = 'none'
                                 ) +
  ggplot2::labs(x = 'Threshold Quantile', 
                y = '# Events', 
                title = '',
                fill = 'Density',
                color = 'Total Duration (min)') +
  ggplot2::scale_y_continuous(sec.axis = ggplot2::sec_axis(~., name = "Mean Duration (s)")) +
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = 'bottom',
                 axis.line.y.right = ggplot2::element_line(color = "darkred"),
                 axis.line.y.left = ggplot2::element_line(color = "#0071bc"),
                 plot.title = ggplot2::element_blank(),
                 legend.key.size = ggplot2::unit(0.5, "cm"),
                 legend.margin = ggplot2::margin(0,0,0,0),
                 legend.box.margin = ggplot2::margin(-10,0,0,-20),
                 panel.grid = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(color = 'black', size = 14, family = 'Trebuchet MS'),
                 axis.text = ggplot2::element_text(color = 'black', size = 10, family = 'Trebuchet MS'),
                 legend.title = ggplot2::element_text( size = 12, family = 'Trebuchet MS'),
                 legend.text = ggplot2::element_text( size = 12, family = 'Trebuchet MS') )
p2A

## B:
pal <- c('#0071bc','#8dbde2', '#f7931e', '#c1272d', '#131025')
p2B <- ggplot2::ggplot(evsum, ggplot2::aes(x = qls, y = qlp))+
  ggplot2::geom_tile(ggplot2::aes(fill = Nev))+
  ggplot2::scale_x_continuous(expand = c(0,0)) +
  ggplot2::scale_y_continuous(expand = c(0,0)) +
  ggplot2::theme_bw() +
  ggplot2::scale_fill_gradientn(colours = pal, na.value = 'black') +
  ggplot2::labs(x = 'Speed Quantile', y = ' Polarization Quantile', fill= '# Events')+
  ggplot2::theme(legend.position = 'none',
                 plot.title = ggplot2::element_blank(),
                 panel.grid = ggplot2::element_blank(),
                 axis.title = ggplot2::element_text(color = 'black', size = 14, family = 'Trebuchet MS'),
                 axis.text = ggplot2::element_text(color = 'black', size = 10, family = 'Trebuchet MS'),
                 legend.title = ggplot2::element_text( size = 12, family = 'Trebuchet MS'),
                 legend.text = ggplot2::element_text( size = 12, family = 'Trebuchet MS')
  )

p2B

## Merge:
leg <- cowplot::get_legend(p4leg)
p2Al <- cowplot::ggdraw(p2A)  +
  cowplot::draw_plot(leg, .25, .25, .5, .75) 

Fig2 <- cowplot::plot_grid(p2Al, p2B, labels = 'AUTO', rel_widths = c(1.1, 0.9) )

Fig2

##################################################
####    the End       ############################