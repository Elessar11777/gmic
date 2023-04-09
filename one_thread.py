"""
#@gui Sharpen [Unsharp Mask] : fx_unsharp, fx_unsharp_preview(0)
#@gui : Sharpening Type = choice(1,"Gaussian","Bilateral")
#@gui : Spatial Radius = float(1.25,0,20)
#@gui : Bilateral Radius = float(10,0,60)
#@gui : Amount = float(2,0,10)
#@gui : Threshold = float(0,0,20)
#@gui : Darkness Level = float(1,0,4)
#@gui : Lightness Level = float(1,0,4)
#@gui : Iterations = int(1,1,10)
#@gui : Negative Effect = bool(0)
#@gui : sep = separator()
#@gui : Channel(s) = choice("All","RGBA [All]","RGB [All]","RGB [Red]","RGB [Green]","RGB [Blue]","RGBA [Alpha]",
#@gui : "Linear RGB [All]","Linear RGB [Red]","Linear RGB [Green]","Linear RGB [Blue]","YCbCr [Luminance]",
#@gui : "YCbCr [Blue-Red Chrominances]","YCbCr [Blue Chrominance]","YCbCr [Red Chrominance]",
#@gui : "YCbCr [Green Chrominance]","Lab [Lightness]","Lab [ab-Chrominances]","Lab [a-Chrominance]",
#@gui : "Lab [b-Chrominance]","Lch [ch-Chrominances]","Lch [c-Chrominance]","Lch [h-Chrominance]","HSV [Hue]",
#@gui : "HSV [Saturation]","HSV [Value]","HSI [Intensity]","HSL [Lightness]","CMYK [Cyan]","CMYK [Magenta]",
#@gui : "CMYK [Yellow]","CMYK [Key]","YIQ [Luma]","YIQ [Chromas]","RYB [All]","RYB [Red]","RYB [Yellow]","RYB [Blue]")
#@gui : sep = separator()
#@gui : Preview Type = choice("Full","Forward Horizontal","Forward Vertical","Backward Horizontal",
#@gui : "Backward Vertical","Duplicate Top","Duplicate Left","Duplicate Bottom","Duplicate Right",
#@gui : "Duplicate Horizontal","Duplicate Vertical","Checkered","Checkered Inverse")
#@gui : Preview Split = point(50,50,0,0,200,200,200,0,10)_0
#@gui : note = note{"\n\n<small><b>Note: </b>
#@gui : This filter is inspired by the original GIMP <i>Unsharp Mask</i> filter, with additional parameters.
#@gui : </small>"}
#@gui : sep = separator()
#@gui : note = note("<small>Author: <i>David Tschumperlé</i>.      Latest Update: <i>2010/29/12</i>.</small>")
_fx_unsharp :
  repeat $! { repeat $8 {
    if $1==0 +b. $2 else +bilateral. $2,$3 fi
    -. .. *. -$4
    +norm. >=. $5% ri. .. *[-2,-1]
    if $9 *. -1 fi
    +c. 0,100% c.. -100%,0 *.. $6 *. $7 +[-2,-1]
    +[-2,-1] c. 0,255
  } mv. 0 }

fx_unsharp :
  ac "_fx_unsharp $1,$2,$3,$4,$5,$6,$7,$8,$9",$10,1

fx_unsharp_preview :
  gui_split_preview "fx_unsharp $*",${-3--1}
"""

"""
import gmic

im = gmic.GmicImage()

in_image = "0.0.bmp"
fx = "-fx_unsharp"
sharpening_type = "1" # 0, 1
spatial_radius = "1.25" # 0-20
bilateral_radius = "10" # 0-60
amount = "5" # 0-10
threshold = "0" # 0-20
darkness_level = "1" # 0-4
lightness_level = "1" # 0-4
itterations = "1" # 1-10
negative_effect = "0" # 0, 1?
val_9 = "0" # color? 0, 1?
out_image = "1.png"


gmic.Gmic(f"{in_image} {fx} {sharpening_type},{spatial_radius},{bilateral_radius},{amount},{threshold},"
          f"{darkness_level},{lightness_level},{itterations},{negative_effect},{val_9} display output {out_image}")
"""
import os
import glob
import gmic
import cv2
import gc
from PIL import Image
import numpy as np

# Set input and output directories
input_dir = "./Input/"
output_dir = "./result/"

for filename in os.listdir(input_dir):
    # Check if file is a .jpg image
    if filename.endswith(".jpg"):
        # Replace whitespace with "&" in filename
        new_filename = filename.replace(" ", "&")

        # Check if filename already has ".jpg" extension
        if not new_filename.endswith(".jpg"):
            new_filename += ".jpg"

        # Construct full path to original and new filenames
        old_path = os.path.join(input_dir, filename)
        new_path = os.path.join(input_dir, new_filename)

        # Rename file
        os.rename(old_path, new_path)

# Set G'MIC parameters
fx = "-fx_unsharp"
sharpening_type = "1"  # 0, 1
spatial_radius = "10"  # 0-20
bilateral_radius = "20"  # 0-60
amount = "2"  # 0-10
threshold = "0"  # 0-20
darkness_level = "2"  # 0-4
lightness_level = "1"  # 0-4
itterations = "1"  # 1-10
negative_effect = "0"  # 0, 1?
val_9 = "0"  # color? 0, 1?

# Loop through all .jpg files in input directory
for in_image in glob.glob(os.path.join(input_dir, "*.jpg")):
    ind = glob.glob(os.path.join(input_dir, "*.jpg")).index(in_image)
    percent = round((((ind + 1) / (len(glob.glob(os.path.join(input_dir, "*.jpg"))) + 1)) * 100), 2)
    print(f"{percent}%")
    # Set output image filename
    out_image = os.path.splitext(os.path.basename(in_image))[0] + ".png"
    out_image_path = os.path.join(output_dir, out_image)

    # Apply G'MIC filter
    im = gmic.Gmic(f"{in_image} mirror y {fx} {sharpening_type},{spatial_radius},{bilateral_radius},{amount},{threshold},"
              f"{darkness_level},{lightness_level},{itterations},{negative_effect},{val_9} output {out_image_path}")


