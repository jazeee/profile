#!/bin/bash

cd $LIMS_CLIENT
tmux new-session -d -s lims
tmux send-keys '$GRAIL/lims/server/tools/db/goose.sh up' C-m \;
tmux send-keys '$CMD_DIR/lims-server/run_local.sh' C-m \;
tmux split-window -h 'bash' 
tmux send-keys '$CMD_DIR/lims-skynet/run_local.sh' C-m \;
tmux new-window -n ui
tmux send-keys 'cd ../server; npm start' C-m \;
tmux split-window -h
tmux send-keys 'npm start' C-m \;
tmux new-window -n tests
tmux send-keys 'cd ../server; npm test' C-m \;
tmux split-window -h
tmux send-keys 'npm test' C-m \;
tmux new-window -n mysql
tmux send-keys 'mysql -plims -u lims lims' C-m \;
tmux new-window -n test-e2e 
tmux send-keys 'npm run test-e2e' C-m \;
tmux new-window 
tmux send-keys 'atom ./' C-m \;
tmux -2 attach-session -d
