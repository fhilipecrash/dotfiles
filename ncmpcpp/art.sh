#!/bin/bash
#put this le to ~/.ncmpcpp/
MUSIC_DIR=~/Musíca #path to your music dir
COVER=/tmp/cover.jpg
function reset_background
{
printf "\e]20;;100x100+1000+1000\a"
}
{
album="$(mpc -p 6601 --format %album% current)"
le="$(mpc -p 6601 --format % le% current)"
album_dir="${ le%/*}"
[[ -z "$album_dir" ]] && exit 1
album_dir="/home/fhilipe/Musíca"
covers="$( nd "$album_dir" -type d -exec nd {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?
g\|png\|gif\|bmp\)" \; )"
src="$(echo -n "$covers" | head -n1)"
rm -f "$COVER"
if [[ -n "$src" ]] ; then
#resize the image's width to 300px
convert "$src" -resize 300x "$COVER"
if [[ -f "$COVER" ]] ; then
#scale down the cover to 30% of the original
printf "\e]20;${COVER};70x70+0+00:op=keep-aspect\a"
else
reset_background
else
reset_background
} &