#!/bin/bash

# set blue text for information message
_info_color=`tput setaf 4`

# set yellow text for worning message
_warn_color=`tput setaf 3`

# set red text for error message
_error_color=`tput setaf 1`

# set green text for done
_done_color=`tput setaf 2`

# set white text for normal
_normal_color=`tput setaf 7`


usage()
{
        echo "${_done_color}Usage:${_info_color} optimize_img ${_normal_color}[IMAGE] ..." 1>&2
        echo 'optimize images for displaying on webpage:' 1>&2
        echo '   1)   generate a placehold with width 230 px and keep aspect ratio of orignal image.' 1>&2
        echo '        command: convert -resize "230>" image.xxx image_placehold.xxx' 1>&2
        echo '   2)   generate a thumb with width 535 px and keep aspect ratio of orignal image.' 1>&2
        echo '        command: convert -resize "535>" image.xxx image_thumb.xxx' 1>&2
        echo
        exit 1
}

if [ $# -eq 0 ]; then
        usage
else
        # Loop until all parameters are used up
        while [ "$1" != "" ]; do
                echo "Optimizing image ${_done_color}$1${_normal_color} ..."
                echo ""
                full_name=$1;
                file_name=${full_name%.*}
                exten=${full_name##*.}
                placehold=$file_name"_placehold."$exten
                thumb=$file_name"_thumb."$exten

          if [ -f "$full_name" ]; then

                echo "generating ${_warn_color}placehold ${_normal_color}${_done_color}[$placehold]${_normal_color}"

                # generate placehold image
                convert -resize "230>" $full_name $placehold
                if [ $? -eq 0 ]; then
                        echo "${_info_color}$placehold generated successfully!${_normal_color}"
                else
                        echo "${_error_color}$placehold generating failed!${_normal_color}" 1>&2
                fi
                echo ""

                # generate thumb image
                echo "generating ${_warn_color}thumb ${_normal_color}${_done_color}[$thumb]${_normal_color}"
                convert -resize "535>" $full_name $thumb

                if [ $? -eq 0 ]; then
                        echo "${_info_color}$thumb generated successfully!${_normal_color}"
                else
                        echo "${_error_color}$thumb generating failed!${_normal_color}" 1>&2
                fi
        else
                echo "${_error_color}Image $1 doesn't exist, skipping...${_normal_color}" 1>&2
        fi
        echo ""
                # Shift all the paramerters down by one
                shift

        done
fi

