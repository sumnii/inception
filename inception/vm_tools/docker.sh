#!/bin/bash

# Docker 설치

# 리포지토리의 GPG키 가져오기
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Docker APT 저장소를 시스템의 소프트웨어 저장소 목록에 추가
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# 패키지 목록을 업데이트하고 Docker Community Edition 설치
sudo apt update
sudo apt install docker-ce

# 도커 그룹에 사용자 추가
sudo usermod -aG docker $USER


# Docker-compose 설치

# docker compose의 releases 버전 다운로드
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# docker compose에 실행 권한 주기
sudo chmod +x /usr/local/bin/docker-compose