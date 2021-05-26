# base image
FROM python:3.8

# update package list
RUN apt-get update -y

# install jupyter
RUN pip3 install jupyter
# make jupyter notebook config file
RUN jupyter notebook --generate-config
# set open_brower option as False
RUN echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py
# set passwd (now: 1234)
RUN echo "c.NotebookApp.password = u'sha1:957c927e6ad8:2b788632b41c54be38f73da328b26b5d0957730d'" >> /root/.jupyter/jupyter_notebook_config.py

# launch jupyter notebook at container home dir
WORKDIR /home/
ENTRYPOINT jupyter notebook --allow-root --ip=0.0.0.0 --port=8888


# To build image
# docker build -t {image_name} {Dockerfile_location}
# Example: docker build -t test_image .


# To run container by image
# docker run --name {container_name} -p {local_port}:8888 -v {local_dir_path}:{container_dir_path} -it {image_name}
# Example: docker run --name test_container -p 8889:8888 -v /home/user_name/Desktop/test_folder/:/home/ -it test_image
