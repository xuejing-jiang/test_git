#load tidyverse
library(tidyverse)

#import penguins data frame

penguins<-read.xlsx(file="palmerpenguins.xlsx",sheetName = "Sheet1") %>% 
  tibble()

#overview of the data : glimpse and skim

glimpse(penguins)


library(skimr)
skim(penguins)

#view the data

view(penguins)

penguins %>% 
  count(species,sex) 


#manipulation
penguins %>% 
  select(species,island,bill_length_mm,bill_depth_mm,body_mass_g) %>% 
  drop_na(bill_length_mm) %>% 
  mutate(body_mass_kg=body_mass_g/1000) %>%
  mutate(bill_ratio=bill_length_mm/bill_depth_mm) %>% 
  select(-body_mass_g,-bill_depth_mm,-bill_length_mm)

#group by and summarise
penguins

penguins %>%
  drop_na(body_mass_g) %>% 
  group_by(species) %>% 
  summarise(avg_bmass=mean(body_mass_g),
            sd_bmass=sd(body_mass_g)) %>% 
  ggplot()+
  geom_col(aes(x=species,y=avg_bmass,fill=species))+
  labs(x="Specie",y="Average Body Mass (g)")+
  coord_flip()


#pivot longer and wider
penguins.pivot <- penguins %>%
  mutate(id=row_number()) %>% 
  relocate(id,1) %>% 
  pivot_longer(cols = bill_length_mm:body_mass_g,
                 names_to = "metrics",
                 values_to = "values")
  
penguins.pivot %>%
  ggplot(aes(values, ..scaled..,fill = species)) +
  geom_density(alpha=0.5) +
  facet_wrap(~ metrics, scales = "free_x")

penguins.pivot %>% 
  drop_na(values) %>% 
  group_by(species,metrics) %>% 
  summarise(average=mean(values),
            sd=sd(values)) %>% 
  pivot_wider(names_from="metrics",values_from=c("average","sd")) 

#correlations
library(GGally)
penguins %>% 
  select(species,sex,body_mass_g,ends_with("_mm")) %>% 
  ggpairs(aes(color=species))

penguins.pivot %>% 
  drop_na(values) %>% 
  pairwise_cor(item = metrics,feature = id,value=values,method="pearson") %>% 
  arrange(desc(correlation)) %>% 
  filter(item1=="body_mass_g")

#merge coordinates data
penguins %>% 
  count(island)

  

