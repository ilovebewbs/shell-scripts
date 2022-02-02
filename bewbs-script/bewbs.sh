for i in $(curl -s -A "handsome boy" "https://www.reddit.com/r/boobs.json" | jq -r ".data.children[].data.url_overridden_by_dest");do
  wget $i
done