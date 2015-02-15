FROM debian:wheezy
MAINTAINER Anthony Georges <anthony@anthonygeorges.com>

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449; \
	echo deb http://dl.hhvm.com/debian wheezy main | tee /etc/apt/sources.list.d/hhvm.list; \
	apt-get update; \
	apt-get -y install --no-install-recommends hhvm nginx curl; \
	/usr/share/hhvm/install_fastcgi.sh; \
	cd /usr/local/bin && curl -ksS https://getcomposer.org/installer | php && mv composer.phar composer; \
	mkdir /build; \
	cd /build; \
	composer -n create-project october/october october dev-master; \
	sed -i "s/root \/usr\/share\/nginx\/www;/root \/webapp/;g" /etc/nginx/sites-enabled/default
EXPOSE 80
ADD start.sh /start.sh

CMD ["/bin/bash.sh", "/start.sh"]

