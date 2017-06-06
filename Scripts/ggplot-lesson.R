#################
# ggplot-lesson #
#################



# Loading the package "tidyverse"
library("tidyverse")
gapminder<- read_csv(file = "Data/gapminder-FiveYearData.csv")
gapminder

#"Tab" means that the command is continuing in the second line
ggplot(data = gapminder) +
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))

#Adding color=continent -> points are colored by continent
ggplot(data = gapminder) +
  geom_jitter(mapping = aes(x=gdpPercap, y=lifeExp, color=continent))

#Size of the population is indicated by the size of the dots. Log makes the points more spread out
ggplot(data = gapminder) +
  geom_jitter(mapping = aes(x=log(gdpPercap), y=lifeExp, color=continent, size = pop))

#Add transperancy. Inside aes -> to vary, outside aes -> will NOT vary. Here, all points are blue, since the command is given outside aes
ggplot(data = gapminder) +
  geom_jitter(mapping = aes(x=log(gdpPercap), y=lifeExp), alpha=0.1, size=2, color="blue")

#Plot as line
ggplot(data = gapminder) +
  geom_line(mapping = aes(x=log(gdpPercap), y=lifeExp, group=country, color = continent))

#Plot by year
ggplot(data = gapminder) +
  geom_line(mapping = aes(x=year, y=lifeExp, group=country, color = continent))

#Boxplot
ggplot(data = gapminder) +
  geom_boxplot(mapping = aes(x=continent, y=lifeExp))

#Add bothe geom_litter and geom_boxplot
ggplot(data = gapminder) +
  geom_jitter(mapping = aes(x=continent, y= lifeExp, color=continent))+
  geom_boxplot(mapping = aes(x=continent, y=lifeExp, color=continent))

#Add bothe geom_litter and geom_boxplot. It depends in which order the commands are given! Here it is changed to jitter on top of 
#the boxplots!
ggplot(data = gapminder) +
  geom_boxplot(mapping = aes(x=continent, y=lifeExp, color=continent))+
  geom_jitter(mapping = aes(x=continent, y= lifeExp, color=continent))

#A more compact way of giving the order to BOTH geom_jitter and geom_boxplot is by putting the command into the ggplot. 
ggplot(data = gapminder, mapping = aes(x=continent, y= lifeExp, color=continent)) +
  geom_jitter()+
  geom_boxplot()

#mapping is used for mapping certain features to the data. Commands within aes is applied to everything, 
#for instance one color or one transparency. If commands are put outside, features can vary, such as having some points pink,
#whereas other points are blue

#trying to add some new individual features for each geom_-layer "lm" <- linear model
ggplot(data = gapminder, mapping = aes(x=log(gdpPercap), y= lifeExp, color=continent)) +
  geom_jitter(alpha=0.1)+
  geom_smooth(method ="lm")

#Color should stay. Hide the color from the bottomlayer
ggplot(data = gapminder, mapping = aes(x=log(gdpPercap), y= lifeExp)) +
  geom_jitter(color=continent, alpha=0.1)+
  geom_smooth(method ="lm")
#Get error because color=continent is not wrapped into mapping
#Changing...
ggplot(data = gapminder, mapping = aes(x=log(gdpPercap), y= lifeExp)) +
  geom_jitter(mapping=aes(color=continent), alpha=0.1)+
  geom_smooth(method ="lm")
#Tadaa!! It works :)

#Callange 6, task 1
ggplot(data = gapminder, mapping = aes(x=as.factor(year), y= lifeExp)) +
  geom_boxplot()

#6.Task 2
ggplot(data = gapminder, mapping = aes(x=as.factor(year), y= log(gdpPercap))) +
  geom_boxplot()

#6.Task 3
ggplot(data = gapminder, mapping = aes(lifeExp), y= log(gdpPercap))) +
  geom_density2d()

ggplot(data = gapminder) +
  geom_density2d(mapping=aes(x=lifeExp,y=log(gdpPercap)))

# ~ = tilda. facet_wrap splits the function. Here: into different plots
ggplot(data = gapminder, mapping=aes(x=gdpPercap,y=lifeExp)) +
  geom_point()+
  geom_smooth()+
  scale_x_log10()+
  facet_wrap(~continent)

#Making linear models 
ggplot(data = gapminder, mapping=aes(x=gdpPercap,y=lifeExp)) +
  geom_point()+
  geom_smooth(method = "lm")+
  scale_x_log10()+
  facet_wrap(~continent)

#Shrinking the data to one year, here 2007. == is for equal. = is for comparison
filter(gapminder, year ==2007, continent == "Oceania")

#Wrap it into ggplot. By default R thinks using the statistical function count should be used
ggplot(data=filter(gapminder, year ==2007, continent=="Oceania"))+
  geom_bar(mapping = aes(x=country, y=pop), stat = "count")

#Wrap it into ggplot. By default R thinks using the statistical function count should be used
ggplot(data=filter(gapminder, year ==2007, continent=="Oceania"))+
         geom_bar(mapping = aes(x=country, y=pop), stat = "count")

#Wrap it into ggplot. By default R thinks using the statistical function count should be used
ggplot(data=filter(gapminder, year ==2007, continent=="Oceania"))+
  geom_bar(mapping = aes(x=country, y=pop), stat = "identity")


#See all counties from Asia, but this is unreadable
ggplot(data=filter(gapminder, year ==2007, continent=="Asia"))+
  geom_col(mapping = aes(x=country, y=pop))


#Flip coordinates
ggplot(data=filter(gapminder, year ==2007, continent=="Asia"))+
  geom_col(mapping = aes(x=country, y=pop))+
  coord_flip()

# Population in millions
ggplot(data = gapminder, mapping=aes(x=gdpPercap,y=lifeExp, color=continent, size=pop/10^6)) +
  geom_point()+
  scale_x_log10()+
  facet_wrap(~year)
  


# Refining the plot
ggplot(data = gapminder, mapping=aes(x=gdpPercap,y=lifeExp, color=continent, size=pop/10^6)) +
  geom_point()+
  scale_x_log10()+
  facet_wrap(~year)+
  labs(title= "Life expectancy vs GDP per capita over time", subtitle="In the last 50 years, life expectancy has improved in most countries in the world",
       caption= "Source: Gapminder foundation, gapminder.com",
       x="GDP per capita, in '000'USD",
       y= "Life Expectancy in years",
       color="Continent",
       size="Population in millions")

#Width and height can be adjusted. It is better to write this in the code rather than right-clicking and saving. If you do the last mentioned, you never know
#which version you saved. 
ggsave("my_fancy_plot.png")
