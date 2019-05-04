#!/bin/bash
shopt -s extglob
rm -r !(thanh.sh|idol.txt)
img_random=$((RANDOM%10+1))
today=$(date +"%u")
get_link () {
	get_key_word=$(sed -n $i'p' < idol.txt)
	get_images_link=$(wget --user-agent 'Mozilla/5.0' -qO - "https://www.google.com/search?q=$get_key_word\&tbm=isch" | sed 's/</\n</g' | grep '<img'| tail -"$img_random"| head -1 | sed 's/.*src="\([^"]*\)".*/\1/') 
	wget "$get_images_link" -O "$get_day/$get_key_word.jpg"
}
mkdir_folder () {
for ((i=1;i<=7;i++))
do 
	distance=`expr "$i" - "$today"`
	get_day=$(date -d "$distance day" +%d-%m-%Y)
	mkdir $get_day 
	get_link	
done
}
mkdir_folder

