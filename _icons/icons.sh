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
# Use it by running `./icons.sh`
#
# Or use the Rake task `rake android:build_icons[SOURCE_FILENAME]`
# eg
# rake android:build_icons[icon.png]



# ICON=./app-icons/${1:-$1}

ICON=icon.png
SCREEN=screen.png

android_dir_path='../platforms/android/res'

printf "doing icons \n"

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


printf "doing screens \n"



printf "making 800x480 \n"
convert $SCREEN -resize 800x800^ -gravity Center -crop 800x480+0+0 +repage $android_dir_path/drawable-land-hdpi/screen.png

printf "making 320x200 \n"
convert $SCREEN -resize  320x320^ -gravity Center -crop 320x200+0+0 +repage $android_dir_path/drawable-land-ldpi/screen.png

printf "making 480x320 \n"
convert $SCREEN -resize  480x480^ -gravity Center -crop 480x320+0+0 +repage $android_dir_path/drawable-land-mdpi/screen.png

printf "making 1280*720 \n"
convert $SCREEN -resize  1280x1280^ -gravity Center -crop 1280x720+0+0 +repage $android_dir_path/drawable-land-xhdpi/screen.png

printf "making 480x800 \n"
convert $SCREEN -resize  800x800^ -gravity Center -crop 480x800+0+0 +repage $android_dir_path/drawable-port-hdpi/screen.png

printf "making 200x320 \n"
convert $SCREEN -resize  320x320^ -gravity Center -crop 200x320+0+0 +repage $android_dir_path/drawable-port-ldpi/screen.png

printf "making 320x480 \n"
convert $SCREEN -resize  480x480^ -gravity Center -crop 320x480+0+0 +repage $android_dir_path/drawable-port-mdpi/screen.png

printf "making 720x1280 \n"
convert $SCREEN -resize  1280x1280^ -gravity Center -crop 720x1280+0+0 +repage $android_dir_path/drawable-port-xhdpi/screen.png



