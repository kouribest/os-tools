#!/bin/bash
IFS=' '

if [[ -n "$HOSTS" ]] && [ -v HOSTS ] ;
then
    read -a hosts <<< "$HOSTS"
else
    read -a hosts <<< "$@"
    # Split the input to get array of hosts
fi

tmux new-session -d -s kubernetes-host

for host in "${hosts[@]}";     
do 
    tmux send-keys -t kubernetes-host "ssha admin@${host}" Enter
    tmux split-window  -t kubernetes-host
	tmux select-layout tiled
done
tmux attach
