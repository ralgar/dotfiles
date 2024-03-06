#!/bin/sh

num_updates="$(checkupdates | wc -l)"

cat << EOF | jq -M --unbuffered --compact-output
{
    "text": "$num_updates",
    "alt": "$num_updates",
    "tooltip": "Available Updates",
    "class": "updates",
    "percentage": 0
}
EOF
