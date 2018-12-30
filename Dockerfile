#? ## note:  this is a container for interactive use--
#? ##  exploring, learning the cmds
#? 
#? # 1. build like:  <cmd here>
#? # ? time docker build  --tag registry.gitlab.com/toddkaufmann/aws311 --label 311-the-label .
#? 
#? # 2. run with ..
#? # .. start with
#? 
#? # restart, reboot , reuse your history
#? 
#? 
#? FROM teardrop/awscli

#FROM jupyter/minimal-notebook
FROM jupyter/scipy-notebook

# ??
#   first this -- update jupyterlab to 0.35.x (req for -toc)
#   67  conda update -c conda-forge jupyterlab

## ?? required:
#  conda update -n base conda
#
#  conda install ipympl

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
    # toc
     jupyter labextension install @jupyterlab/toc && \
    # ipympl
    # only requreid because random order ?
    jupyter lab build && \
    echo ============   i dunno  ================== && \
	echo ............ docker-hist and init with INCEPT now ? && \
	echo what about 'Container must be run as root to set $NB_UID' '???'


COPY scipy-1226-tk2.2_start-notebook.sh  /usr/local/bin/start-notebook.sh 
# manually:
#  scipy-1226-tk2.2_start-notebook.sh  scipy-1226-tk2.2:/usr/local/bin/start-notebook.sh 


# maybe?:
#  jupyter labextension install jupyterlab_bokeh

#? RUN apt update && apt install -y jq
#? 
#? # how to get from env ?
#? WORKDIR /root
WORKDIR /root
#? COPY session/docker-hist .
COPY ../session/docker-hist .
#? #RUN bash -c '. ./docker-hist; bashrc-additions your-prompt-here' >> .bashrc
#? 
#? #    Step 4 : RUN bash -c '. ./docker-hist; bashrc-additions your-prompt-here' >> .bashrc
#? #     ---> Running in 690617f7e42e
#? #    mkdir: cannot create directory ‘/session/logs’: No such file or directory
#? #    ./docker-hist: line 21: /session/logs/up-20180311.1931.env: No such file or directory
#? #    bash: bashrc-additions: command not found
#? # .. postpone that until runtime
#? 
#? RUN echo "remember:  $(pwd)/sesssion:/session"
RUN echo "remember:  $(pwd)/sesssion:/session   .. or  $(pwd)/../sesssion:/session   .. 
#? 
#? # ? don't have bash ?
#? #ENTRYPOINT ["/bin/sh", "-i"]
#? #CMD ['/bin/bash']
ENTRYPOINT ["/bin/bash"]
#? 
#? # =================================
#? 
#? # # set prompt:
#? # grep PS1 ~/.bashrc
#? # perl -pi -e s=ec2.v1024=dr.aws.1128c= ~/.bashrc
#? 
#? # (echo; echo '# more'; echo . /usr/local/bin/aws_bash_completer ) >> ~/.bashrc
#? 
#? #  1905  2017-11-28 13:26:31 docker run --name awscli-1128 -it teardrop/awscli --entrypoint /bin/bash
#? 
#? #  1911  2017-11-28 13:37:34 docker commit  --change='ENTRYPOINT ["/bin/bash"]' $(docker ps -lq) tk/awscli-bash
#? 
#? #  1913  2017-11-28 13:39:04 docker rm awscli-1128
#? #  1914  2017-11-28 13:39:06 docker rm awscli-1128b 
#? #  1915  2017-11-28 13:39:13 history 33
#? #  1915  2017-11-28 13:39:13 history 33
#? #  1916  2017-11-28 13:41:35 copyq add -
#? #  1917  2017-11-28 13:41:58 cd ..
#? #  1923  2017-11-28 13:47:38 ls
#? #  1924  2017-11-28 13:47:53 chmod +x run-awscli.sh 
#? #  1925  2017-11-28 13:47:57 ./run-awscli.sh 
#? #  1926  2017-11-28 13:48:15 which bash
#? #  1927  2017-11-28 13:48:45 docker run --name awscli-1128b -it tk/awscli-bash
#? #  1928  2017-11-28 13:50:10 ls
#? #  1929  2017-11-28 13:50:23 ls -lat
#? #  1930  2017-11-28 13:50:36 ./run-awscli.sh
#? 
#? # externally, you can populate $HOME/.aws or bind .aws then do:
#? # AWS_PROFILE=
#? 
