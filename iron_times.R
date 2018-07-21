library(dplyr)
library(ggplot2)

iron_times = read.csv('iron_times.csv', row.names = 'item') %>%
	mutate(s = min+sec/60,
		   cumulative_s = cumsum(s))
lm1 = lm(s ~ clothing_type + cumulative_s, data=iron_times)
summary(lm1)

p_iron_times = ggplot(iron_times) +
	geom_point(aes(x=cumulative_s,y=s,col=clothing_type)) +
	# geom_smooth(aes(x=cumulative_s,y=s,group=clothing_type), method=lm, formula=y~1) +
	labs(title='Iron Times for Different Type of Clothings, Adjusted for Fatigue',
		 x='Cumulative Time spent Ironing (min)', y='Time Spent Ironing Item (min)',
		 col='Clothing Type')
p_iron_times
ggsave('iron_times.png', plot = p_iron_times, width = 20, height = 10, scale = 1, units = 'cm')
