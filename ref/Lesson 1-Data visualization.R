#install tidyverse package
# tidyverse (8 packages) : import, transform, tidy, and visualize 

install.packages("tidyverse")
library(tidyverse)

#Data visualizations

#1.1 install and load palmerpenguins data frame

install.packages("palmerpenguins")

library(palmerpenguins)

penguins

#1.2 overview of the data : glimpse and skim

glimpse(penguins)

install.packages("skimr")
library(skimr)

skim(penguins)

#1.3 view the data

view(penguins)



#2 Data visualization with ggplot2

#our goal
data_viz_goal

#2.1 Creating at ggplot

ggplot(data = penguins,
       mapping = aes(x=flipper_length_mm, y=body_mass_g))+
  geom_point()

#we will address the warning message next lesson :)
penguins %>% 
  select(species, flipper_length_mm, body_mass_g) %>% 
  filter(is.na(body_mass_g) | is.na(flipper_length_mm))

#2.2 Adding aesthetics and layers

#2.2.1 Adding color

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g,
                     color = species)) +
  geom_point()

#2.2.2 Adding a smooth curve

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g,
                     color = species)) +  #color at global level
  geom_point() +
  geom_smooth()


ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +  
  geom_point(mapping = aes(color = species)) + #color at local level
  geom_smooth()

#2.2.3 Adding shapes

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth()

#2.2.4 Adding titles

ggplot(penguins, 
       aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth() +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", 
    y = "Body mass (mm)",
    color = "Species", 
    shape = "Species")


#2.3 Visualizing distributions

#2.3.1 Categorical variables
ggplot(penguins,
       aes(x=species))+
  geom_bar()

  
ggplot(penguins,
       aes(x=fct_infreq(species)))+
  geom_bar()


#2.3.1 Numeric variables

#density plot
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

# histogram
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

#2.4 Visualizing relationships

#2.4.1 Numerical and categorical variables

#boxplot

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

#density plot
ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)

#2.4.2 Two categorical variables

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")


#2.4.3 Two numerical variables

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()


#2.4.4 Three of more variables

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species))+
  facet_wrap(~island)
