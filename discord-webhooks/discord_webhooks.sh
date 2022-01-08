#!/usr/bin/bash

function usage(){
cat <<EOF
Usage: $0 <SWITCH>
SWITCHES:
-W              Webhook URL
-T              Embed title
-U              Embed url
-C              Embed color
-N              Embed author name
-u              Embed author url
-D              Embed description
-L              Embed image link
-h              Show this help menu
-n              Embed username
-i              Embed icon url
EOF
}

while getopts :T:U:C:N:u:D:L:W:n:i:h option; do
    case $option in
        W)
            webhook_url=$OPTARG
            echo "$webhook_url"
            ;;
        T)
            embed_title=$OPTARG
            echo "$embed_title"
            ;;
        U)
            embed_url=$OPTARG
            echo "$embed_url"
            ;;
        C)
            embed_color=$OPTARG
            echo "$embed_color"
            ;;
        N)
            embed_author_name=$OPTARG
            echo "$embed_author_name"
            ;;
        u)
            embed_author_url=$OPTARG
            echo "$embed_author_url"
            ;;
        D)
            embed_description=$OPTARG
            echo "$embed_description"
            ;;
        L)
            embed_image_link=$OPTARG
            echo "$embed_image_link"
            ;;
        n)
            embed_username=$OPTARG
            echo "$embed_username"
            ;;

        i)
            embed_icon_url=$OPTARG
            echo "$embed_icon_url"
            ;;
        h)
            usage
            echo "viewed help"
            exit 0;;
        \?)
            echo "invalid arg"
            usage
            exit 1
            ;;
    esac
done

## check if all args are set
if [[ -z $webhook_url ]] || [[ -z $embed_title ]] || [[ -z $embed_url ]] || [[ -z $embed_color ]] || [[ -z $embed_author_name ]] || [[ -z $embed_author_url ]] || [[ -z $embed_description ]] || [[ -z $embed_image_link ]]; then
    echo "missing args"
    usage
    exit 1
fi

function post_data(){
cat << EDF
{
    "username": "$embed_username",
    "avatar_url": "$embed_icon_url",
    "embeds": [{
        "title": "$embed_title",
        "url": "$embed_url",
        "color": $embed_color,
        "author": {
            "name": "$embed_author_name",
            "url": "$embed_author_url",
            "icon_url": "https://i.imgur.com/4M34hi2.png"
        },
        "image": {
            "url": "$embed_image_link"
        },
        "footer": {
            "text": "Made by @ilovebewbs on github"
    },
        "description": "$embed_description"
    }]
}
EDF
}

curl -X POST -H 'content-type:application/json' -d "$(post_data)" "$webhook_url"