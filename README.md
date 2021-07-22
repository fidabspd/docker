# Docker 정리

`docker run <image_name:tag> <command>`\
ex) `docker run ubuntu:18.04 bash`\
가지고있는 이미지를 기반으로 container를 run. 만약 이미지가 dockerhub에 있는 공식 이미지이고 pull 되어있지 않다면 자동으로 pull도 함께 됨.

- `-it`: interactive tty가 컨테이너에서 실행되고 컨테이너가 꺼지지 않는다.
- `--rm`: 컨테이너가 종료될 시 자동으로 삭제된다
- `-d`: detach our terminal
- `-P`: publish all exposed ports to random ports and finally
- `--name <container_name>`: 컨테이너 이름 지정
- `-p <local_port:container_port>`: 포트 연결 (ex `-p 8888:5000`)
- `-e <setting>`: Set environment variables (ex `-e "discovery.type=single-node"`)
- `--net <network_name>`: 네트워크를 기본 브릿지 네트워크 말고 지정 네트워크를 사용

`docker build <Dockerfile_path>`\
ex) `docker build .`\
Dockerfile로 이미지를 빌드.

- `-t <image_name:tag>`: 빌드할 이미지의 이름. 지정하지 않을시 랜덤으로 지정된다.

다양한 명령어들

```sh
docker pull <image_name:tag>  # 이미지 pull
docker container prune  # 멈춰있는 컨테이너 다 지우기 (docker ~~ prune 하면 안쓰는 ~~ 모두 지운다)
docker rm $(docker ps -a -q -f status=exited)  # 모든 컨테이너 다 지우기  -a: 모든 컨테이너, -q: 컨테이너 ID만 리턴
docker port <container_name>  # 컨테이너가 연결된 포트를 보여준다
docker network ls  # 도커네트워크 목록보기
docker network inspect bridge  # 네트워크 정보 확인
docker network create <network_name>  # 특정 이름을 가진 네트워크 만듦
docker-compose down -v  # Remove named volumes declared in the `volumes` section of the Compose file and anonymous volumes attached to containers.
docker exec <container_name> <command>  # 특정 컨테이너에 명령 내리기. (docker exec -it rnnoise bash)
```

### Dockerfile 관련 메모

ENTRYPOINT CMD 차이\
만약 ENTRYPOINT 를 사용하여 컨테이너 수행 명령을 정의한 경우,
해당 컨테이너가 수행될 때 반드시 ENTRYPOINT 에서 지정한 명령을 수행되도록 지정 된다.\
하지만, CMD를 사용하여 수행 명령을 경우에는,
컨테이너를 실행할때 인자값을 주게 되면 Dockerfile 에 지정된 CMD 값을 대신 하여 지정한 인자값으로 변경하여 실행되게 된다.

### 리눅스 관련 메모

yum은 레드햇 기반\
apt는 우분투 기반\
/            : 최상위 디렉토리(루트 디렉토리)\
/bin         : binary의 약자로 실행파일 모음. 일반적으로 사용하는 mv, cat등 명령어 프로그램들이 있음\
/boot       : 부팅과 관련된 파일들이 모여있음\
/dev        : device의 약자로 물리적인 장치들이 파일화 되어 있다.\
/etc        : 각종 환경 설정 파일들이 모여 있음\
/home      : 개인사용자들 디렉토리\
/lib        : 각종 라이브러리 저장 디렉토리\
/mnt       : CD-ROM, 네트워크 파일 시스템 등을 마운트 할때 사용되는 디렉토리\
/proc      : 현재 실행되고 있는 프로세스들이 파일화 되어서 저장되는 디렉토리\
/root       : root계정의 홈 디렉토리\
/sbin      : System-binary의 약자로, 주로 시스템 관리자가 쓰는 시스템 관련 명령어 프로그램들이 모여있다.\
/tmp       : 임시 저장 디렉토리. 일반적으로 모든 사용자들에게 열려 있음\
/usr       : 주로 새로 설치되는 프로그램들이 저장된다. '명령어' 보다는 '프로그램'이라고 부르는게 더 익숙한 놈들이 저장된다. 윈도우의 Program Files같은 폴더\
/var        : 시스템 로그, 스풀링 파일 들이 저장된다. 메일 서버로 운영될 경우 메일이 여기 저장된다


### 사용예시
``` sh
### To build image
docker build -f {path/dockerfile_name} -t {image_name:tag} {Dockerfile_location}
# Example: 
docker build -f ./test_image:0.0.dockerfile -t test_image:0.0 .

### To run(make & start) container by image
docker run --name {container_name} -p {local_port}:8888 -v {local_dir_path}:{container_dir_path} -it {image_name}
# Example: 
docker run --name test_container -p 8887:8888 -v ~/test_folder/:/home/ --gpus all -it test_image:0.0

### To start container
docker start {container_name}
# Example: 
docker start test_container
```