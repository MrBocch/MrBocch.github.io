# /bin/zsh

_get_name(){
    echo $1 | awk '{ split($0, arr, "."); print arr[1] }'
}

_get_extension(){
    echo $1 | awk '{ split($0, arr, "."); print arr[2] }'
}

_image_count(){
    count=$(ls -l static/images/ | wc -l )
    # why cant i do it in 1 line?
    count=$((count - 1))
    echo $count
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
    echo "done!"
}

_rename_images(){
    local icount=$(_image_count)
    i=$icount
    for image in static/stage/*.jpg ; do
        echo "renaming $image to ${i}.jpg"
        mv $image "static/stage/${i}.jpg"
        i=$((i+1))
    done
}

_staging_to_images(){
    echo "will only move .jpg"
    mv static/stage/*.jpg static/images/
}

_convert_to_jpg(){
    local image=$1
    name="$(_get_name $image)"
    ext="$(_get_extension $image)"

    ffmpeg -i $image $name.jpg
}

_convert_staging(){
    # go thrue each not .jpg file, and will call _convert_to_jpg() on them
    for image in $(find static/stage -type f ! -name "*.jpg") ; do
        echo "Will try to convert $image to jpg"
        _convert_to_jpg $image
    done
}

_help(){
	echo "  image.sh remove : removes metadata from images"
	echo "  image.sh rename : takes image from staging area to images and renames them"
	echo "  image.sh update : updates script to include the newer images"
	echo "  image.sh count  : returns number of images"
	echo "  image.sh help   : help page"
	echo "  image.sh everything : Converts to .jpg,
	                              Renames files,
	                              Moves from staging to images,
								  Removes metadata,
								  Updates script"
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
	everything)
	    _convert_staging
		_rename_images
		_update_script
		_remove_metadata
	   ;;
	*)
		_help
		;;
esac
