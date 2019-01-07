# Customized Jupyter scipy-notebook

- Jupyterlab extensions:  git, toc, nbdime
- ipympl:  for interactive plots
- interactive widgets

You can get the stock image, and install these yourself manually.
Note that leads to a larger image

Note the Dockerfile still has some coments from my awscli Dockerfile still

## Why Docker?

Even more reproducible.
Instead of saying "get conda, install these packages, these extensions"
times N effort for each user,
plus docummenting, possible environment conflicts,
tomorrow the instructions might not work etc.,
a docker image is immutable.
One person (or a few) can build and test, and it will be the same for everyone,
as long as you want.

Make local changes?  You can commit and name your version,
and if you break it (or the rest of the world breaks)
you can always get back to that and try something else.

Or run multiple copies, different versions.

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

A docker tutorial is out of scope here, but will serve you well.

### Configure
Main thing for git is a author info, if you want to commit.
Otherwise you will just get errors

### Troubleshooting

Q:  permission denied, etc.

A:  see if making world writable fixes it.


## Upgrading
1. got your data ?




## TODO:
- add example notebook (eg exploratory data analysis)
- include jq
- aws-cli, s3fs
- report bug (is it?) - when setting `NB_UID`
    COPY scipy-1226-tk2.2_start-notebook.sh  /usr/local/bin/start-notebook.sh 
- cleanup dockerfile, remove old comments