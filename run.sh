#!/bin/bash
set -eu
# docker run -p 8888:8888 jupyter/scipy-notebook
#IMAGE=tk/scipy-1128
# oops no tag/name
IMAGE=toddkaufmann/scipy-notebook-tk

# 'work' is actually where stuff is in the container.
# must be writable by uid 1000
# "Alternatively, specify the UID of the jovyan user on container
# startup using the -e NB_UID option described in the Common Features,
# Docker Options section"

# name you want to give your container
NAME=scipy-tk-0425

# local port to map to / expose:
PORT=8425
#JUPYTER_SERVER_URL="http://scipy.local:$PORT/"
JUPYTER_SERVER_URL="http://localhost:$PORT/"

# Make sure you are in the right place:
#  - I put work (notebooks) in 'work' folder
#  - data in 'data' folder
# and map them to local dirs outside of docker, for re-use, etc.
if ! [ -d work -a -d data ]; then
    echo not finding the directories
    exit 1
fi

echo ============================================
echo for NB_UID going to need to run as root supposedly
echo i.e.,  under --user root

# should be COPY'd by the dockerfile now
# echo also have to first start script ?
# docker cp scipy-1226-tk2.2_start-notebook.sh  ${IMAGE}:/usr/local/bin/start-notebook.sh 

#
# NOTE:
#  8888 is the port jupyter usually exposes
#  --user root:  works better with external volume for work/data
#  UID/GID:      reduce file permission issues; set to your own

docker run -d -p $PORT:8888 \
       --user root \
       -e NB_UID=1001 -e NB_GID=1001 \
       -e JUPYTER_ENABLE_LAB=yes \
       -e JUPYTER_SERVER_URL="$JUPYTER_SERVER_URL" \
       --name "$NAME" \
       -v "$(pwd)"/data:/data \
       -v "$(pwd)"/work:/home/jovyan/work  \
       $IMAGE

# Note:  above must have '-d' (detach)
# otherwise we won't get to this point (unless exit or detach (^P^Q ))

: 'first time' after run starts it ..
# we don't have to worry about .gitconfig already existing
if ! docker cp container.tmp/tk.gitconfig  ${NAME}:/home/jovyan/.gitconfig; then
    echo
    echo 'NOTE:'
    echo ' the git extension will fail until you configure it properly;'
    echo ' start a terminal in jupyter, cd to the appropriate folder and do "git init"'
    echo ' and appropriate "git config" commands to set your email/name.'
    echo '[by default, $HOME is inside the container and will lack the .gitconfig file]'
    echo
fi
#
# .bashrc - ? this is a good place for it



cat <<EOF
 .. watch the logs .. you will need the token to log in, 
 ..  then go to   $JUPYTER_SERVER_URL
 ..     ^C to exit any time after that.
=============================================================================
EOF

docker logs -f "$NAME"
exit 0
