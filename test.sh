#!/bin/bash -eu
{
#set -x

mkdir -p ogssgf
mkdir -p ogsjson

function download() {
    GAMEID="$1"
    shift

    if [ ! -f ogsjson/"$GAMEID".json ]
    then
        wget https://online-go.com/termination-api/game/"$GAMEID" -O ogsjson/"$GAMEID".json
        sleep 1
    fi

    if [ ! -f ogssgf/"$GAMEID".sgf ]
    then
        wget https://online-go.com/api/v1/games/"$GAMEID"/sgf -O ogssgf/"$GAMEID".sgf
        sleep 1
    fi
}

download 36657373
download 36745653
download 17900198
download 23059286
download 11299602
download 36745855
download 3442486
download 36743194
download 36742631

python3 ogstosgf.py ogsjson/ -verbose

function showdiff() {
    GAMEID="$1"
    shift

    echo "$GAMEID"
    git --no-pager diff --word-diff=color --word-diff-regex='[a-zA-Z0-9]+|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+' ogssgf/"$GAMEID".sgf ogsjson/"$GAMEID".sgf || true
}

showdiff 36657373
showdiff 36745653
showdiff 17900198
showdiff 23059286
showdiff 11299602
showdiff 36745855
showdiff 3442486
showdiff 36743194
showdiff 36742631


exit 0
}
