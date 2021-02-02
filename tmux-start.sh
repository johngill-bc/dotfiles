#!/bin/bash

SESSION="Workspace"
SESSIONEXISTS=$(tmux list-sessions | grep ${SESSION})
WINDOW0="Local Box"
WINDOW1="Dev Box"
WINDOW2="Test Box"
WINDOW3="Factory"

if [[ "${SESSIONEXISTS}" == "" ]]
then
    tmux new-session -d -s ${SESSION}

    tmux rename-window -t ${SESSION}:0 "${WINDOW0}"
    tmux split-window -t "${WINDOW0}" -h

    tmux new-window -t ${SESSION}:1 -n "${WINDOW1}"
    tmux split-window -t "${WINDOW1}" -h
    tmux split-window -t "${WINDOW1}" -v

    tmux new-window -t ${SESSION}:2 -n "${WINDOW2}"
    tmux split-window -t "${WINDOW2}" -h
    tmux split-window -t "${WINDOW2}" -v
    tmux split-window -t "${WINDOW2}" -v
    tmux resize-pane -t "${WINDOW2}".1 -y 14
    tmux resize-pane -t "${WINDOW2}".2 -y 32
    tmux resize-pane -t "${WINDOW2}".3 -y 32

    tmux new-window -t ${SESSION}:3 -n "${WINDOW3}"
    tmux split-window -t "${WINDOW3}" -h
fi

tmux attach-session -t ${SESSION}:0
