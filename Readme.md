# Customized Jupyter scipy-notebook

Personalized version of https://hub.docker.com/r/jupyter/scipy-notebook/
with added:

- Jupyterlab extensions:  git, toc, nbdime
- ipympl:  for interactive plots
- interactive widgets

You can get the stock image, and install these yourself manually.
Note that leads to a larger image

## Why Docker?

Even more reproducible.
Instead of saying "get conda, install these packages, these extensions"
times N effort for each user,
plus documenting, possible environment conflicts,
tomorrow the instructions might not work etc.,
a docker image is immutable.
One person (or a few) can build and test, and it will be the same for everyone,
as long as you want.

Make local changes?  You can commit and name your version,
and if you break it (or the rest of the world breaks)
you can always get back to that and try something else.

Or run multiple copies, same or different versions.

## HOWTO use:

How depends on a few choices you make, depending on your workflow.

First you start the docker image, then you configure it / your environment.

### Start

Different cases:
1. run locally, just use localhost
1. server with ssl exposed

Orthogonal issues concerning work and data access
(hereafter just 'data"):
* keep notebooks in a local folder
* use a volume for data (shareable between containers?)
* user permissions for docker v your filesystem

#### <<example incantations to come>>
I run it like this (roughly):

    docker run -d -p $PORT:8888 \
       -e JUPYTER_ENABLE_LAB=yes \
       --name "my-scipy-plus" \
       -v "$(pwd)"/data:/data \
       -v "$(pwd)"/work:/home/jovyan/work  \
	 toddkaufmann/scipy-notebook-tk

This makes `data/` in current folder available as `/data` to docker / your notebooks,
and 'work/' will be the default directory that jupyterlab is in on startup.

See `run.sh` as an example.

*Note*: `JUPYTER_ENABLE_LAB=yes` is the magic that turns on jupyterlab.

A docker tutorial is out of scope here, but will serve you well.

### Configure

For git:

Main thing for git is author info, if you want to commit.
Otherwise you will just get errors, I think they might only be shown as `error 128`.

Open a terminal in jupyter and run the appropriate `git config` commands, or copy your own `.gitconfig` to `/home/jovyan`.

### Troubleshooting

Q:  permission denied, etc.

A:  see if making world writable fixes it.


## Upgrading
1. got your data ?  If not in a separate folder/volume, make sure you copy that out.
2. maybe .gitconfig too; copy out
3. stop this container.
   (alternative:  run the new one on a diff port, you can leave this one running;
    useful for side-by-side comparison etc.)
4. start new, configure whatever you did before (.gitconfig, pip, etc)
   but encourage you to update Dockerfile with your changes as you make them
   (or make a request)
5. all good, you can remove the old if you want


## TODO:
- add example notebook (eg exploratory data analysis)
- include jq
- aws-cli, s3fs
- report bug (is it?) - when setting `NB_UID`
    COPY scipy-1226-tk2.2_start-notebook.sh  /usr/local/bin/start-notebook.sh 
- cleanup dockerfile, remove old comments (like this)
- animated notebook example
