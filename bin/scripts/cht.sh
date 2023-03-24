#!/usr/bin/env bash
selected=`cat ~/bin/scripts/cht/languages ~/bin/scripts/cht/commands  | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter query: " query

if grep -qs "$selected" ~/bin/scripts/cht/languages; then
    query=`echo $query | tr ' ' '+'`
    curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done
else
    curl -s cht.sh/$selected~$query | less
fi
