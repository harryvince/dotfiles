#!/usr/bin/env bash

selected=`cat ~/bin/scripts/cht/list | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter query: " query

query=`echo $query | tr ' ' '+'`
curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done
