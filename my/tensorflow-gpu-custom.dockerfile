# ver: 1.0

# base image
FROM tensorflow/tensorflow:2.8.0-gpu

RUN apt update -y

# install git
RUN apt install git -y

# to use cv2 and dlib
RUN apt install cmake libgl1-mesa-glx libgtk2.0-dev -y

# install packages
RUN pip3 install --upgrade pip
COPY ./tensorflow-gpu-custom_requirements.txt /home/
RUN pip3 install -r /home/tensorflow-gpu-custom_requirements.txt
RUN rm -f /home/tensorflow-gpu-custom_requirements.txt

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
