
#FROM jupyter/minimal-notebook
# 57f8546c0386 = 2019-04-25
FROM jupyter/scipy-notebook:57f8546c0386

# ??
#   first this -- update jupyterlab to 0.35.x (req for -toc)
#   67  conda update -c conda-forge jupyterlab

RUN  echo checking if you got any lab first .... && \
    conda list | grep -i lab && \
    echo .. && echo .. && \
    conda update -c conda-forge jupyterlab && \
    conda install ipympl && \
     jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
     jupyter labextension install jupyter-matplotlib nbdime-jupyterlab && \
     jupyter labextension install @jupyterlab/git && \
     pip install jupyterlab-git nbdime && \
     jupyter serverextension enable --py jupyterlab_git && \     
    # toc - table of contents sidebar
     jupyter labextension install @jupyterlab/toc && \
    # ipympl
    # only required because random order ?
    jupyter lab build

#	echo what about 'Container must be run as root to set $NB_UID' '???'

# I had a copy for debug purposes
# COPY scipy-1226-tk2.2_start-notebook.sh  /usr/local/bin/start-notebook.sh 

# - my session stuff
# WORKDIR /root
# COPY ../session/docker-hist .
#? #RUN bash -c '. ./docker-hist; bashrc-additions your-prompt-here' >> .bashrc
# RUN echo "remember:  $(pwd)/sesssion:/session   .. or  $(pwd)/../sesssion:/session   .. 

