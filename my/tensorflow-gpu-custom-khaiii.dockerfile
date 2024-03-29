# base image
FROM tensorflow/tensorflow:2.5.0-gpu

# update package list
RUN apt-get update -y
# install git
RUN apt-get install git -y
# install java
RUN apt-get install default-jdk -y

# install packages
COPY ./requirements.txt /home/
RUN pip3 install --upgrade pip
RUN pip3 install -r /home/requirements.txt
RUN rm -f /home/requirements.txt

# install khaiii
WORKDIR /home
RUN git clone https://github.com/kakao/khaiii.git
RUN mkdir /home/khaiii/build
WORKDIR /home/khaiii/build
RUN cmake ..
RUN make all
RUN make resource
RUN apt-get install -y language-pack-ko
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN make install
RUN make package_python
WORKDIR /home/khaiii/build/package_python
RUN pip3 install .
RUN rm -r -f /home/khaiii

# make jupyter notebook config file
RUN jupyter notebook --generate-config
# set open_brower option as False
RUN echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py
# set passwd (default: 1234)
RUN echo "c.NotebookApp.password = u'sha1:957c927e6ad8:2b788632b41c54be38f73da328b26b5d0957730d'" >> /root/.jupyter/jupyter_notebook_config.py
# set default width 100%
RUN mkdir /root/.jupyter/custom/
RUN echo ".container { width:100% !important; }" >> /root/.jupyter/custom/custom.css

# launch jupyter notebook
WORKDIR /home/
ENTRYPOINT jupyter notebook --allow-root --ip=0.0.0.0 --port=8888
