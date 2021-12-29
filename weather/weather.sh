#! /usr/bin/bash

# NAME : weather.sh
# AUTHOR : ilikered
# DESCRIPTION : A script to display the weather for your current location


function usage(){
    echo "Usage : ./weather.sh"
}

[[ $# -ne 0 ]] && usage && exit 1

check_dependencies(){
    # check curl 
    if ! [ -x "$(command -v curl)" ]; then
        echo 'Error: curl is not installed.' >&2
        exit 1
    fi

    # check jq
    if ! [ -x "$(command -v jq)" ]; then
        echo 'Error: jq is not installed.' >&2
        exit 1
    fi

    # check lolcat
    if ! [ -x "$(command -v lolcat)" ]; then
        echo 'Error: lolcat is not installed.' >&2
        exit 1
    fi

    # check figlet
    if ! [ -x "$(command -v figlet)" ]; then
        echo 'Error: figlet is not installed.' >&2
        exit 1
    fi
}

check_dependencies

lat=$(curl -sS http://ip-api.com/json | jq ".lat" )
lon=$(curl -sS http://ip-api.com/json | jq ".lon" )
wowid=$(curl -sS https://www.metaweather.com/api/location/search/?lattlong="$lat","$lon" | jq ".[0].woeid")
weather_state_name=$(curl -sS https://www.metaweather.com/api/location/"$wowid"/ | jq ".consolidated_weather[0].weather_state_name")
min_temp=$(curl -sS https://www.metaweather.com/api/location/"$wowid"/ | jq ".consolidated_weather[0].min_temp")
max_temp=$(curl -sS https://www.metaweather.com/api/location/"$wowid"/ | jq ".consolidated_weather[0].max_temp")
temp=$(curl -sS https://www.metaweather.com/api/location/"$wowid"/ | jq ".consolidated_weather[0].the_temp")
country=$(curl -sS https://www.metaweather.com/api/location/"$wowid"/ | jq ".parent.title")
city=$(curl -sS https://www.metaweather.com/api/location/"$wowid"/ | jq ".title")

printf "weather condition is: $weather_state_name\nminimum temperature is: $min_temp\nmaximum temperature is: $max_temp\ntemperature is: $temp\ncountry is: $country\ncity is: $city\n" | lolcat -a