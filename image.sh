# /bin/zsh

_image_count(){
    count=$(ls -l static/images/ | wc -l )
    # why cant i do it in 1 line?
    count=$((count - 1))
    echo $count
}

# it does alot more than jus rename them
# but i think its ok, just rename it
_rename_images(){
    local icount=$(_image_count)
    i=$icount
    for image in static/stage/*.jpg ; do
        echo "renaming $image to ${i}.jpg"
        mv $image "static/stage/${i}.jpg"
        i=$((i+1))
    done
    echo "moving staging images to images folder"
    mv static/stage/*.jpg static/images/
    _remove_metadata
    _update_script
}

_get_extension(){
    echo $1 | awk '{ split($0, arr, "."); print arr[2] }'
}

_get_name(){
    echo $1 | awk '{ split($0, arr, "."); print arr[1] }'
}

_convert_to_jpg(){
    local image=$1
    # why does this not work anymore? is there something wrong with the function?
    # calling the function here seems to not work?
    # name="$(_get_name $image)"
    # ext="$(_get_extension $image)"
    if [ $ext == "jpg" ]; then
        echo "this $image is a .jpg"
    else
        # it works with png but can it do other formats?
        echo "converting $image to a .jpg"
        # ffmpeg -i $image $name.jpg
    fi
}

# _convert_to_jpg static/stage/test.png
# ffmpeg does not destroy the original image so what should i do? not movethem or delete them?
_convert_staging(){
    for image in $(find ./static/stage -type f ! -name "*.jpg") ; do
        echo "Will try to convert $image to .jpg"
        _convert_to_jpg $image
    done
}

_get_name "hello.jpg"
_get_extension "hello.jpg"

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
    echo "done!"
}

_help(){
	echo "  image.sh remove : removes metadata from images"
	echo "  image.sh rename : takes image from staging area to images and renames them"
	echo "  image.sh update : updates script to include the newer images"
	echo "  image.sh count  : returns number of images"
	echo "  image.sh help   : help page"
}


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
		#_help
		;;
esac
