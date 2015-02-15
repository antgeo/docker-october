FROM debian:wheezy
MAINTAINER Anthony Georges <anthony@anthonygeorges.com>

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449; \
	echo deb http://dl.hhvm.com/debian wheezy main | tee /etc/apt/sources.list.d/hhvm.list; \
	apt-get update; \
	apt-get -y install --no-install-recommends hhvm nginx curl unzip; \
	/usr/share/hhvm/install_fastcgi.sh; \
	mkdir /build; \
	cd /build; \
	curl http://octobercms.com/api/core/get?type=install -o latest.zip; \
	unzip latest.zip; \
	rm latest.zip; \
	echo "\ndaemon off;" >> /etc/nginx/nginx.conf; \
	apt-get -y remove unzip curl
EXPOSE 80
ADD start.sh /start.sh
ADD nginx-default /etc/nginx/sites-enabled/default
CMD ["/bin/bash", "/start.sh"]

