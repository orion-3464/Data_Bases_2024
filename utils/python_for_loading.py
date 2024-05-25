import shutil
import os

def copy_images_with_new_names(src_dir, dest_dir, start_index):
    for i, filename in enumerate(os.listdir(src_dir)):
        if filename.endswith(".jpg"):  # Assuming you only want to process .jpg files
            new_name = str(start_index + i) + ".jpg"
            shutil.copy(os.path.join(src_dir, filename), os.path.join(dest_dir, new_name))

# Usage
copy_images_with_new_names('C:/Users/nikos/OneDrive/Υπολογιστής/gears', 'C:/Users/nikos/OneDrive/Υπολογιστής/new', 111)


