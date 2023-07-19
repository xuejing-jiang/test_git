## Purpose: create a generic theme for plots
## Author: Xuejing Jiang


# library(extrafont)
# font_import() # i think only need to import once
# loadfonts(device = "win") ## for windows computer?
# loadfonts() ## for mac computer?

# generic -----------------------------------------------------------------

# the basic features of this generic theme: 
# - dependent on theme_test()
# - text: 
#   - Times New Roman
# - legend: 
#   - at bottom
# - facet:
#   - lighter background color
# - caption:
#     - align to the left
theme_generic <- function() {
  theme_test() + 
    theme(legend.position = "bottom"
          , text=element_text(family="Times New Roman")
          , strip.background = element_rect(fill="grey93") ## facet background color
          , plot.caption = element_text(hjust=0)) 
  
}

# individual plot --------------------------------------------------
# generic ( + enlarged font size)
# - purpose: make sure flexibility for Dr.Shah to use individual plots himself
# - dependent on theme_generic()
# - add gridlines:
#     - based on breaks defined for y axis (major)
#     - based on breaks defined for x axis (major)
#     - based on breaks defined for both x and y axes (major)

theme_individualPlot <- function(x.major=T, y.major=T)  {
  
  theme_generic() +
    theme(text = element_text(size=20, face="bold")
          , plot.title = element_text(size = 24, face="bold"))+
    theme(panel.border = element_rect(size = 2))
}

# generic ( + gridlines) --------------------------------------------------

# - dependent on theme_generic()
# - add gridlines:
#     - based on breaks defined for y axis (major)
#     - based on breaks defined for x axis (major)
#     - based on breaks defined for both x and y axes (major)

theme_gridline <- function(x.major=T, y.major=T)  {
  
  if (x.major) {
    theme_generic() + theme(panel.grid.major.x = element_line(color="grey93"))
  }
  
  else if (y.major) {
    theme_generic() + theme(panel.grid.major.y = element_line(color="grey93"))
  }
  
  else if (x.major & y.major) {
    theme_generic() + theme(panel.grid.major.x = element_line(color="grey93")
                            , panel.grid.major.y = element_line(color="grey93"))
  }
  
  else{
    theme_generic()
  }
}


# generic (grey themed) ---------------------------------------------------

# the basic features of this theme: 
# - dependent on theme_generic()
# - legend: 
#   - at bottom
#   - change legend background color (for key area and other area)
# - change color of the facet background
theme_legend_grey <- function() {
  theme_generic() + 
    theme(
      legend.background = element_rect(fill="grey93")
      , legend.key = element_rect(fill="grey93")
    ) 
  
}

# pie chart ---------------------------------------------------------------

# the basic features of this theme; 
# - remove all elemenets in the plot
# - move legend to bottom
theme_pie <- function()  {
  theme_void() +
    theme(legend.position = "bottom")
}
