# Docker에서 jupyter notebook 실행하기

<http://localhost:8889/>로 접속 가능

## 비밀번호 설정 방법

1. `docker run ubuntu:latest bash`: 빈 컨테이너에 접속한다.
2. 컨테이너 안의 bash에서 `apt upgrade`: 컨테이너 안에서 패키지 업데이트
3. `apt install python3`: 파이썬 설치
4. `python3`: 파이썬 실행
5. 파이썬 인터프리터 안에서
    1. `from notebook.auth import passwd`
    2. `passwd()`\
        Enter password: 접속 시 입력할 비밀번호\
        Verify password: 비밀번호 확인\
        나오는 암호화 된 비밀번호 `sha...` 복사
6. Dockerfile의 ```RUN echo "c.NotebookApp.password = ...```에 수정 붙여넣기

## 실행

```powershell
docker build -t rnnoise .
docker-compose up
```
