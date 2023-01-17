FROM	debian:buster 
# 프로젝트를 시작할 베이스 image 를 지정한다.
# 우리 과제에서는 `debian:buster`로 설정.

LABEL	maintainer="daelee@student.42seoul.kr"
# image에 metadata를 추가한다.

RUN	apt-get update && apt-get install -y \
	nginx \
	mariadb-server \
	php-mysql \
	php-mbstring \
	openssl \
	vim \
	wget \
	php7.3-fpm
# 쉘 명령어를 실행하고 결과를 커밋한다. 

RUN	openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Lee/CN=localhost" -keyout etc/ssl/private/localhost.dev.key -out etc/ssl/certs/localhost.dev.crt
RUN	chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key
	

COPY	./srcs/run.sh ./
COPY	./srcs/default ./etc/nginx/sites-available/
# COPY	./srcs/wp-config.php ./var/www/html/wordpress/
# COPY	./srcs/config.inc.php ./var/www/html/phpmyadmin/
# HostOS의 파일 또는 디렉토리를 컨테이너 안의 경로로 복사한다.

EXPOSE	80 443
# 이 컨테이너가 해당 포트를 사용할 예정임을 사용자에게 알려준다.
# 실제로 포트를 열기 위해서는 run 명령어에서 -p 옵션을 사용해야한다.

ENTRYPOINT	bash run.sh
# 생성된 컨테이너를 실행할 명령어를 지정한다.
