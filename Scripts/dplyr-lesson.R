library(tidyverse)
gapminder <- read_csv(file="Data/gapminder-FiveYearData.csv")

#Repeting
rep("This is an example", times=3)
"This is an example" %>% rep(times=3)

year_country_gdp<-select(gapminder, year, country, gdpPercap)

year_country_gdp <- gapminder %>% select(year, country, gdpPercap)
head(year_country_gdp)

#Sending gapminder into a filter that selects year 2002 and further into ggplot boxplot 
# == -> logical test. 
gapminder %>% 
  filter(year==2002) %>% 
  ggplot(mapping = aes(x=continent, y=pop))+
  geom_boxplot()

#Selecting european countries
year_country_gdp_euro <- gapminder %>% 
  filter(continent=="Europe") %>% 
  select(year, country, gdpPercap)

#Selecting european countries
year_lifeExp_gdp_Norway <- gapminder %>% 
  filter(country=="Norway") %>% 
  select(year, lifeExp, gdpPercap)

gapminder %>% 
  group_by(continent)

#Creating groups and calculate mean for each group
gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))

#Without creating groups first, you just end up with the average for all
gapminder %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))


gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap)) %>% 
  ggplot(mapping = aes(x=continent, y=mean_gdpPercap))+
  geom_point()

gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>%
  filter(mean_lifeExp==min(mean_lifeExp|mean_lifeExp==max(mean_lifeExp)))

gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>%
  ggplot(mapping = aes(x=country, y=mean_lifeExp))+
  geom_point()+
  order() %>% 
  coord_flip()

gapminder %>% 
  mutate (gdp_billion=gdpPercap*pop/10^9) %>% 
  head()


gapminder %>% 
  mutate (gdp_billion=gdpPercap*pop/10^9) %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdp_billion=mean(gdp_billion))


gapminder_country_summary <- gapminder %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp))


library(maps)
#We will rename "region" in world to "countries"
map_data("world") %>% 
  rename(country=region) %>% 
  left_join(gapminder_country_summary, by="country") %>% 
  ggplot() + 
  geom_polygon(aes(x=long, y=lat, group=group, fill=mean_lifeExp, mean_lifeExp)) +
  scale_fill_gradient(low="blue", high="red") +
  coord_equal()
