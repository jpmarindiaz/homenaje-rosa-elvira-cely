
library(tidyverse)
library(magick)

# http://livefreeordichotomize.com/2017/07/18/the-making-of-we-r-ladies/

srcimgs <- list.files("srcimgs_original", full.names = TRUE,pattern = "\\.png", recursive = TRUE)

## Rescale images
map(seq_along(srcimgs), function(i){
  img <- image_read(srcimgs[i])
  img <- img %>% image_scale("300x300!")
  if(runif(1) < .3){
    img <- img %>% image_negate()
  }
  tone <- sample(LETTERS[1:6],1)
  # Change the tone of the original ggplot images to different values
  # between bright and dark
  # i.e. sample the images so roughly 30% is dark, 30% bright and some grays in between.
  if(tone == "A"){
    img <- img %>% image_modulate(brightness = 100,saturation = 50)
  }
  if(tone == "B"){
    img <- img %>% image_modulate(brightness = 75,saturation = 50)
  }
  if(tone == "C"){
    img <- img %>% image_modulate(brightness = 50,saturation = 50)
  }
  if(tone == "D"){
    img <- img %>% image_modulate(brightness = 25,saturation = 50)
  }
  if(tone %in% c("E","F")){
    img <- img
  }
  img %>% image_write(path = paste0("srcimgs/",i,".jpeg"), format = "jpeg")
})


#image_annotate("datasketch", size = 10, gravity = "southwest", color = "green")



## Resize target img
target <- "rosa-elvira-base.png"
image_read(target) %>% image_scale("60x60!") %>%
  image_write(path = "target.jpeg", format = "jpeg")


srcimgs <- list.files("srcimgs", full.names = TRUE, pattern = "\\.jpeg")

# Make the mosaic

library(RsimMosaic)
composeMosaicFromImageRandom(
  "target.jpeg",
  "mosaic.jpg",
  "srcimgs",
  removeTiles=TRUE
  )


# Convert the mosaic to gray images to reduce size
#image_read("mosaic.jpg") %>% image_convert(colorspace = "gray") %>%
#  image_write("mosaic-gray.jpg")
