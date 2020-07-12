
# Tags listed at: https://hub.docker.com/r/jupyter/scipy-notebook/tags/
# 
#FROM jupyter/minimal-notebook
# 57f8546c0386 = 2019-04-25
# d4cbf2f80a2a = 2019-06-01
# 1386e2046833 = 2019-09-11
#  jupyterlab                1.1.3                      py_0    conda-forge
#  jupyterlab_server         1.0.6                      py_0    conda-forge
#
# jupyter/scipy-notebook
# 1386e2046833 04-25
# f3da74a3da1e = 2020-03-06
# 3b1f4f5e6cc1 = 2020-05-13
FROM jupyter/scipy-notebook:3b1f4f5e6cc1

# # Description from
# jupyter/scipy-notebook includes popular packages from the scientific Python ecosystem.
# 
# - Everything in jupyter/minimal-notebook and its ancestor images
# - dask, pandas, numexpr, matplotlib, scipy, seaborn, scikit-learn,
#   scikit-image, sympy, cython, patsy, statsmodel, cloudpickle, dill,
#   numba, bokeh, sqlalchemy, hdf5, vincent, beautifulsoup, protobuf,
#   xlrd, bottleneck, and pytables packages
# - ipywidgets and ipympl for interactive visualizations and plots in Python notebooks
# - Facets for visualizing machine learning datasets

MAINTAINER Todd Kaufmann <dockers.scipy@t-k.org>
LABEL Description="standard jupyterlab/scipy and my curated extensions"

# 
# Extension notes:
# OLD #   first this -- update jupyterlab to 0.35.x (req for -toc)
#   67  conda update -c conda-forge jupyterlab
#
# also order of extensions can matter; read appropriate docs for interdependencies

RUN echo checking if you got any lab first .... && \
        conda list | grep -i lab && \
        echo .. && echo .. && \
    conda update -c conda-forge jupyterlab && \
    # ipympl - interactive matplotlib
    conda install ipympl && \
     jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
     jupyter labextension install jupyter-matplotlib nbdime-jupyterlab && \
     jupyter labextension install @jupyterlab/git && \
     pip install jupyterlab-git nbdime && \
     jupyter serverextension enable --py jupyterlab_git && \     
    # toc - table of contents sidebar
     jupyter labextension install @jupyterlab/toc && \
    # always required ?  or does an install include a build?
        echo .. && echo .. a build to tie it together && echo .. && \
    jupyter lab build

#	echo what about 'Container must be run as root to set $NB_UID' '???'

# I had a copy for debug purposes
# COPY scipy-1226-tk2.2_start-notebook.sh  /usr/local/bin/start-notebook.sh 

# - my session stuff
# WORKDIR /root
# COPY ../session/docker-hist .
#? #RUN bash -c '. ./docker-hist; bashrc-additions your-prompt-here' >> .bashrc
# RUN echo "remember:  $(pwd)/sesssion:/session   .. or  $(pwd)/../sesssion:/session   .. 

