
# Experimenting with the conversion of the original ggplot images
# to different hues and colors to compose the mosaic

library(magick)

srcimg <- list.files("srcimgs_original", full.names = TRUE,pattern = "\\.png", recursive = TRUE)
srcimg <- sample(srcimg,1)


img <- image_read(srcimg) %>% image_scale("400x400!")
img

#img %>% image_modulate(brightness = 80, saturation = 120, hue = 90)
img %>% image_modulate(brightness = 100, saturation = 80, hue = 0)
img %>% image_modulate(brightness = 100,saturation = 20)
img %>% image_modulate(brightness = 75,saturation = 20)
img %>% image_modulate(brightness = 50,saturation = 20)
img %>% image_modulate(brightness = 25,saturation = 20)

img %>% image_modulate(brightness = 100,saturation = 50)
img %>% image_modulate(brightness = 75,saturation = 50)
img %>% image_modulate(brightness = 50,saturation = 50)
img %>% image_modulate(brightness = 25,saturation = 50)

img <- img %>% image_negate()

img %>% image_negate()

img %>% image_negate() %>% image_modulate(brightness = 100, saturation = 150, hue = 0)


image_average(img)
image_flatten(img)
image_convert(img, colorspace = "gray")
