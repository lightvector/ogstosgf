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

# download 36657373
# download 36745653
# download 17900198
# download 23059286
# download 11299602
# download 36745855
# download 3442486
# download 36743194
# download 36742631

# download 49506806
# download 49507041
# download 49506895
# download 49507102

# download 11299602
# download 11299605
# download 11299607
# download 11299621
# download 11299624
# download 11299625
# download 11299626

download 393349   # 9h
download 58785355 # 2h
download 1653388  # 4h
download 1653402  # 5h
download 1505474  # 5h free place
download 44827128 # 3h
download 15225368 # 7h
download 14675557 # 8h
download 15337120 # 6h



python3 ogstosgf.py ogsjson/ -verbose

function showdiff() {
    GAMEID="$1"
    shift

    echo "$GAMEID"
    git --no-pager diff --no-index --word-diff=color --word-diff-regex='[a-zA-Z0-9]+|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+' ogssgf/"$GAMEID".sgf ogsjson/"$GAMEID".sgf || true
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

showdiff 49506806
showdiff 49507041
showdiff 49506895
showdiff 49507102

showdiff 11299602
showdiff 11299605
showdiff 11299607
showdiff 11299621
showdiff 11299624
showdiff 11299625
showdiff 11299626

showdiff 393349   # 9h
showdiff 58785355 # 2h
showdiff 1653388  # 4h
showdiff 1653402  # 5h
showdiff 1505474  # 5h free place
showdiff 44827128 # 3h
showdiff 15225368 # 7h
showdiff 14675557 # 8h
showdiff 15337120 # 6h

exit 0
}
