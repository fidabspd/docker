# docker-curriculum

```dockerfile
FROM python:3

# set a directory for the app
WORKDIR /usr/src/app

# copy all the files to the container
COPY . .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# define the port number the container should expose
EXPOSE 5000
# 컨테이너의 5000포트를 연다

# run the command
CMD ["python", "./app.py"]
# cmd에서 실행할 명령어
```
