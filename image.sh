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
    _update_script
}

_remove_metadata(){
    for image in static/images/*; do
        echo "clearing $image"
        (xattr -c $image);
    done
}

_update_script(){
	echo "updating script"

    local icount=$(_image_count)
    cat <<EOF > script.js
const path = "static/images/";
const imageCount = ${icount};
const imageIndex = Math.floor(Math.random() * imageCount);
document.getElementById("image").src = \`\${path}\${imageIndex}.jpg\`;

EOF
}

_help(){
	echo "  image.sh remove : removes metadata from images"
	echo "  image.sh rename : takes image from staging area to images and renames them"
	echo "  image.sh update : updates script to include the newer images"
	echo "  image.sh count  : returns number of images"
	echo "  image.sh help   : help page"
}

# if [ -z $1 ] || [ $1 == "--help" ] || [ $1 == "-h" ] ; then
	# _help
	# exit
# fi

case $1 in
	remove)
		_remove_metadata 	
		;;
	rename)
		_rename_images
		;;
	update)
		_update_script
		;;
	count)
		_image_count
		;;
	*)
		_help
		;;
esac

