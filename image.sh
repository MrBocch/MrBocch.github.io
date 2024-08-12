# /bin/zsh

_image_count(){
    count=$(ls -l static/images/ | wc -l )
    # why cant i do it in 1 line?
    count=$((count - 1))
    echo $(($count))
}

# i could probably use seq
# seq [start] [increment] [limit]
# an interesting idea but i=0; i++; is simpler
_rename_images(){
    icount=_image_count
    i=0
    echo $icount
    for image in static/images/*; do
        if [ -e "static/images/${i}.jpg" ]; then
            echo "File ${i}.jpg exists. dont overwrite"
            i=$((i+1))
        else
            echo "file ${i}.jpg not exist"
            i=$((i+1))
        fi
        #echo "renaming $image to $i.jpg"
        #mv $image "static/images/$i.jpg"
        #i=$((i+1))
    done
}

_remove_metadata(){
    for image in static/images/*; do
        echo "clearing $image"
        (xattr -c $image);
    done
}

_remove_metadata
