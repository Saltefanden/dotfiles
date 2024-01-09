#!/usr/bin/env bash
#C:\Program Files\WindowsApps\Mozilla.Firefox_121.0.0.0_x64__n80bbvh6b1yt2\VFS\ProgramFiles\Firefox Package Root
LOCALFF="/mnt/c/Users/NicklasMunksgaardLar/AppData/Local/Microsoft/WindowsApps/firefox.exe"
if [ $# -eq 0 ]; then
    "$LOCALFF"
fi

for var in "$@"
do 
    if [[ -e "$var" ]]
    then
      "$LOCALFF" "$(wslpath -w $(pwd)/$var)"
    else 
      "$LOCALFF" "$var"
    fi
done
