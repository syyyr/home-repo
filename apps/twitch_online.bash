#!/bin/bash
if [[ -z "$TWITCH_CLIENT_ID" ]]; then
    echo "TWITCH_CLIENT_ID not set. Use environment to set it (or edit this script)."
    exit 1
fi

if [[ -z "$TWITCH_STREAMERS" ]]; then
    echo "TWITCH_STREAMERS not set. Use environment to set it (or edit this script)."
    exit 1
fi

CACHE_DIR="$HOME/.local/share/twitch_online"
ID_CACHE="$CACHE_DIR/ids"
ONLINE_CACHE="$CACHE_DIR/online"
ONLINE_CACHE_TTL="60"
CURL_HEADERS="-H Client-ID:$TWITCH_CLIENT_ID -H Accept:application/vnd.twitchtv.v5+json"

update_id_cache() {
    if [[ ! -d "$CACHE_DIR" ]]; then
        mkdir "$CACHE_DIR"
    fi
    curl --silent $CURL_HEADERS \
        "https://api.twitch.tv/kraken/users?login=$TWITCH_STREAMERS" | \
        jq 'reduce .users[] as $user({}; . + {(($user).display_name): ($user)._id})' > "$ID_CACHE"
}

check_online_id() {
    [[ $(curl --silent $CURL_HEADERS "https://api.twitch.tv/kraken/streams/$1" | \
        jq '.stream') != "null" ]]
    return $?
}

update_online_cache() {
    > "$ONLINE_CACHE"
    for user in $(get_users); do
        if check_online_id "$(get_id "$user")"; then
            echo "$user" >> "$ONLINE_CACHE"
        fi
    done
}

get_users() {
    jq -r 'keys | reduce .[] as $user(""; . + " " + $user)' <<< "$STREAMER_IDS"
}

get_id() {
    jq -r ".$1" <<< "$STREAMER_IDS"
}

if [[ ! -f "$ID_CACHE" ]]; then
    update_id_cache
fi

STREAMER_IDS=$(cat "$ID_CACHE")

if [[ ! -f "$ONLINE_CACHE" ]] || find "$ONLINE_CACHE" -not -newermt "-$ONLINE_CACHE_TTL seconds" | grep '.' > /dev/null; then
    update_online_cache
fi

cat "$ONLINE_CACHE"
