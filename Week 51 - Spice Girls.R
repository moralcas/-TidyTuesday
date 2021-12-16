#Load libraries
install.packages("tidyverse")
library(tidyverse)
install.packages("tidytuesdayR")

#load the data
tuesdata <- tidytuesdayR::tt_load('2021-12-14')

lyrics <- tuesdata$lyrics



#Create a DF that shows how many total lines each artist/combo sings
artist_total_line <- lyrics %>% 
  group_by(section_artist, album_name) %>% 
  summarise(lines = n()) %>% 
  arrange(desc(lines))

#filter artist_total_line to show solo lines
solo_lines <- artist_total_line %>% 
  filter(section_artist == "Baby" | 
           section_artist == "Scary" | 
           section_artist == "Sporty" | 
           section_artist == "Ginger" |
           section_artist == "Posh")

#plot solo_lines
line_per_artist_p <- ggplot(solo_lines)  + 
         geom_col(aes(x = section_artist, y = lines, fill = album_name), position = "stack") +
  labs(
    title = "Who Is The Most Featured Spice Girl?",
    fill = "Album",
    x = "Spice Girl",
    y = "Solo Lines"
  ) +
  scale_fill_manual(values = c("black", "purple", "pink")) +
  theme_classic()


line_per_artist_p    
ggsave("spiceplot.png")
