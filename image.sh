# /bin/zsh

_image_count(){
    count=$(ls -l static/images/ | wc -l)
    echo $(($count - 1))
}


# i could probably use seq
# seq [start] [increment] [limit]
# an interesting idea but i=0; i++; is simpler
_rename_images(){
    i=0
    # this deletes a picuture if an images is renamed to another existing image
    # how to stop this?
    for image in static/images/*; do
        echo "renaming $image to $i.jpg"
        mv $image "static/images/$i.jpg"
        i=$((i+1))
    done
}

_remove_metadata(){
    for image in static/images/*; do
        echo "clearing $image"
        (xattr -c $image);
    done
}

_remove_metadata
