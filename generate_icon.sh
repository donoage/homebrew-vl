#!/bin/bash

# Create a temporary directory for icon creation
TMPDIR=$(mktemp -d)
cd "$TMPDIR"

# Create a simple icon with text "VL INDEX" using Quartz filters (sips)
# Generate a text-based icon using ImageMagick if available
if command -v convert &> /dev/null; then
    # ImageMagick is available
    convert -size 1024x1024 xc:none -fill '#4a6da7' -draw 'roundrectangle 0,0 1024,1024 80,80' \
            -fill white -pointsize 180 -gravity center -annotate 0 "VL\nINDEX" icon_1024.png
else
    # Fallback to simple colored square if ImageMagick is not available
    # Create a blank PNG
    mkdir -p "$TMPDIR/icons.iconset"
    sips -s format png -z 1024 1024 --out icon_1024.png <(echo "<svg width='1024' height='1024'><rect width='1024' height='1024' fill='#4a6da7'/></svg>")
fi

# Create iconset directory
mkdir -p icons.iconset

# Generate different icon sizes
sips -z 16 16     icon_1024.png --out icons.iconset/icon_16x16.png
sips -z 32 32     icon_1024.png --out icons.iconset/icon_16x16@2x.png
sips -z 32 32     icon_1024.png --out icons.iconset/icon_32x32.png
sips -z 64 64     icon_1024.png --out icons.iconset/icon_32x32@2x.png
sips -z 128 128   icon_1024.png --out icons.iconset/icon_128x128.png
sips -z 256 256   icon_1024.png --out icons.iconset/icon_128x128@2x.png
sips -z 256 256   icon_1024.png --out icons.iconset/icon_256x256.png
sips -z 512 512   icon_1024.png --out icons.iconset/icon_256x256@2x.png
sips -z 512 512   icon_1024.png --out icons.iconset/icon_512x512.png
sips -z 1024 1024 icon_1024.png --out icons.iconset/icon_512x512@2x.png

# Create icns file
iconutil -c icns icons.iconset

# Copy the icon to the application
cp icon.icns ~/Applications/RunVLIndex.app/Contents/Resources/applet.icns

# Clean up
rm -rf "$TMPDIR"

echo "Icon has been created and applied to RunVLIndex.app" 