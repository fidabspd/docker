# Docker 정리

## Study with <https://docker-curriculum.com/#docker-network>

`docker run <image name:tag> <command>`\
ex) `docker run ubuntu:18.04 bash`\
가지고있는 이미지를 기반으로 container를 run. 만약 이미지가 dockerhub에 있는 공식 이미지이고 pull 되어있지 않다면 자동으로 pull도 함께 됨.

- `-it`: interactive tty가 컨테이너에서 실행되고 컨테이너가 꺼지지 않는다.
- `--rm`: 컨테이너가 종료될 시 자동으로 삭제된다
- `-d`: detach our terminal
- `-P`: publish all exposed ports to random ports and finally
- `--name <container name>`: 컨테이너 이름 지정
- `-p <local_port:container_port>`: 포트 연결 (ex `-p 8888:5000`)
- `-e <setting>`: Set environment variables (ex `-e "discovery.type=single-node"`)
- `--net <network_name>`: 네트워크를 기본 브릿지 네트워크 말고 지정 네트워크를 사용

`docker build <Dockerfile path>`\
ex) `docker build .`\
Dockerfile로 이미지를 빌드.

- `-t <image name:tag>`: 빌드할 이미지의 이름. 지정하지 않을시 랜덤으로 지정된다.

다양한 명령어들

```powershell
docker pull <image_name:tag>  # 이미지 pull
docker container prune  # 멈춰있는 컨테이너 다 지우기 (docker ~~ prune 하면 안쓰는 ~~ 모두 지운다)
docker rm $(docker ps -a -q -f status=exited)  # 모든 컨테이너 다 지우기  -a: 모든 컨테이너, -q: 컨테이너 ID만 리턴
docker port <container_name>  # 컨테이너가 연결된 포트를 보여준다
docker network ls  # 도커네트워크 목록보기
docker network inspect bridge  # 네트워크 정보 확인
docker network create <network_name>  # 특정 이름을 가진 네트워크 만듦
docker-compose down -v  # Remove named volumes declared in the `volumes` section of the Compose file and anonymous volumes attached to containers.
```
