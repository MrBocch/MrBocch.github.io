# /bin/zsh

_image_count(){
    count=$(ls -l static/images/ | wc -l )
    # why cant i do it in 1 line?
    count=$((count - 1))
    echo $count
}

# i could probably use seq
# seq [start] [increment] [limit]
# an interesting idea but i=0; i++; is simpler

# ill make it really simple
# i will paste the images to the staging area to rename them
# then paste them into images
_rename_images(){
    local icount=$(_image_count)
    i=$icount
    for image in static/stage/* ; do
        echo "renaming $image to ${i}.jpg"
        mv $image "static/stage/${i}.jpg"
        i=$((i+1))
    done
    echo "moving staging images to images folder"
    echo "dont forget to update the js"
    # maybe i can do that in here also, just write to a script.js
    mv static/stage/* static/images/
    _remove_metadata
    _remove_metadata
}

_remove_metadata(){
    for image in static/images/*; do
        echo "clearing $image"
        (xattr -c $image);
    done
}

_remove_metadata
