# ####
# Run this before release to get the right icons for the app.
# ####
#
# It's a shell script that uses ImageMagick
# to create all the android icon files from one source icon.
#
# Generates all the sizes that Android app needs
# and puts them into the right resource directory in platforms.
# Plus a 512 version for uploading to the Play Store.
#
#
# If source is greyscale we should still get to convert
# but might have a warning.
#
# Source must be flattened, not a layered PSD,
# else we get one file per layer.
#
# Use it by running `./convert.sh SOURCE_FILENAME`
# eg
# ./convert.sh arrernte2-icon.png
#
# Or use the Rake task `rake android:build_icons[SOURCE_FILENAME]`
# eg
# rake android:build_icons[icon.png]

# ICON=./app-icons/${1:-$1}

ICON=icon.png

android_dir_path='../platforms/android/res'

printf "making 36 \n"
convert $ICON -resize  36 $android_dir_path/mipmap-ldpi/icon.png

printf "making 48 \n"
convert $ICON -resize  48 $android_dir_path/mipmap-mdpi/icon.png

printf "making 72 \n"
convert $ICON -resize  72 $android_dir_path/mipmap-hdpi/icon.png

printf "making 96 \n"
convert $ICON -resize  96 $android_dir_path/mipmap-xhdpi/icon.png

# printf "making 144 \n"
# printf "making 192 \n"

printf "making 512 \n"
convert $ICON -resize 512 512-icon.png
