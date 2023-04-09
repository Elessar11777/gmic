import os
import glob
import gmic
import multiprocessing as mp

# Set input and output directories
input_dir = "./Input/"
output_dir = "./result/"

# Function to process a single image
def process_image(in_image, out_image_path):
    # Apply G'MIC filter
    im = gmic.Gmic(f"{in_image} mirror y {fx} {sharpening_type},{spatial_radius},{bilateral_radius},{amount},{threshold},"
              f"{darkness_level},{lightness_level},{itterations},{negative_effect},{val_9} output {out_image_path}")

if __name__ == "__main__":
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

    for filename in os.listdir(input_dir):
        # Check if file is a .jpg image
        if filename.endswith(".png"):
            # Replace whitespace with "&" in filename
            new_filename = filename.replace(" ", "&")

            # Check if filename already has ".jpg" extension
            if not new_filename.endswith(".png"):
                new_filename += ".png"

            # Construct full path to original and new filenames
            old_path = os.path.join(input_dir, filename)
            new_path = os.path.join(input_dir, new_filename)

            # Rename file
            os.rename(old_path, new_path)

    # Get list of image paths
    image_paths = glob.glob(os.path.join(input_dir, "*.png"))

    # Create a list of input and output paths
    input_output_paths = []
    for in_image in image_paths:
        out_image = os.path.splitext(os.path.basename(in_image))[0] + ".png"
        out_image_path = os.path.join(output_dir, out_image)
        input_output_paths.append((in_image, out_image_path))

    # Use a multiprocessing pool to process images in parallel
    with mp.Pool(processes=mp.cpu_count()) as pool:
        results = pool.starmap(process_image, input_output_paths)