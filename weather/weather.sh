#! /usr/bin/bash

function banner(){
    figlet "weather"
    printf "By: ilovebewbs\ngithub link: https://github.com/ilovebewbs/shell-scripts.git\nlicense: MIT\n"
}

function usage(){
    banner
    echo "Usage : ./weather.sh"
}

[[ $# -ne 0 ]] && usage && exit 1

check_dependencies(){
   for i in curl jq figlet lolcat ; do
       if ! command -v $i >/dev/null 2>&1 ; then
           echo "Error: $i is not installed"
           exit 1
       fi
   done
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