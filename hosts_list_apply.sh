#!/bin/bash
## created on 2021-01-11

#
#  Will get files from the internet but it will not overwrite them.
#  It is polite for the servers. Have to clean temp dir manually.
#



## Variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
custom_fl="$DIR/manual_host.list"
txtlst_fl="$DIR/repo_text.list"
ziplst_fl="$DIR/repo_zip.list"


## temp output
TMP="/dev/shm/hostdir"
mkdir -p "$TMP"
mainfile="$TMP/mainfile"
maintemp="$TMP/maintemp"


## functions
validate_url() {
    if [[ $(wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK') ]]; then echo "true"; fi
}



echo "Runs fron $DIR"




## Get data

# echo "Get text list files"
# cat "$txtlst_fl" | sed 's/#.*//g' | sed '/^[[:space:]]*$/d' | while read line;do
#     ii=$((ii+1))
#     # echo "list $ii: $line
#     file="$TMP/File_t_${ii}.list"
# 
#     if [[ $(validate_url "$line") == "true" ]] ; then
#         echo "Get: $line"
#         wget -nc -O "$file"  "$line"
#     else
#         echo "NOT FOUND: $line"
#     fi
# done    
# 
# 
# echo "Get zip list files"
# cat "$ziplst_fl" | sed 's/#.*//g' | sed '/^[[:space:]]*$/d' | while read line;do
#     ii=$((ii+1))
#     # echo "list $ii: $line
#     file="$TMP/File_z_${ii}.list"
# 
#     if [[ $(validate_url "$line") == "true" ]] ; then
#         echo "Get: $line"
#         wget -O- "$line" | zcat > "$file"
#     else
#         echo "NOT FOUND: $line"
#     fi
# done    




## Clean data

find "$TMP" -type f -iname "File*.list" | while read line; do
    echo "Clean: $line"
    # rules to homogenize hosts list
    # you can inspect the results in the temp folder
    sed -i 's/#.*$//g'                                       "$line"
    sed -i '/[[:space:]]\+localhost[[:space:]]*/d'           "$line"
    sed -i '/[[:space:]]\+broadcasthost[[:space:]]*/d'       "$line"
    sed -i '/[[:space:]]\+local[[:space:]]*/d'               "$line"
    sed -i 's/[[:space:]]*127\.0\.0\.1[[:space:]]*//g'       "$line"
    sed -i 's/[[:space:]]*0\.0\.0\.0[[:space:]]*//g'         "$line"
    sed -i 's/[[:space:]]*255\.255\.255\.255[[:space:]]*//g' "$line"
    sed -i 's/^localhost$//g'                                "$line"
    sed -i 's/^local$//g'                                    "$line"
    sed -i 's/^broadcasthost$//g'                            "$line"
    sed -i 's/^.localdomain$//g'                             "$line"
    
#     sed -i '/[ ]*::[0-9]/d'                    "$line"
#     sed -i '/[ ]*!/d'                          "$line"

done





echo $ii

exit 0
