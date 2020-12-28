#!/bin/bash

tmux has-session -t k8s
if [ $? != 0 ]
then
        tmux new-session -s k8s -n master -d

        tmux new-window -n computes -t k8s
        tmux split-window -v -t k8s:2
        tmux split-window -v -t k8s:2
        tmux select-layout -t k8s:2 even-vertical
        tmux send-keys -t k8s:2.1 'ssh pik8s-node1' C-m
        tmux send-keys -t k8s:2.2 'ssh pik8s-node2' C-m
        tmux send-keys -t k8s:2.3 'ssh pik8s-node3' C-m

        tmux new-window -n  all -t k8s
        tmux split-window -v -t k8s:3
        tmux split-window -v -t k8s:3
        tmux split-window -v -t k8s:3
        tmux select-layout -t k8s:3 tiled
        tmux send-keys -t k8s:3.2 'ssh pik8s-node1' C-m
        tmux send-keys -t k8s:3.3 'ssh pik8s-node2' C-m
        tmux send-keys -t k8s:3.4 'ssh pik8s-node3' C-m

        tmux select-window -t k8s:1
fi
tmux attach -t k8s
