# imageを指定
FROM debian:buster

# apt-get によってインストール可能なパッケージの一覧を更新する。
# apt-get upgrade は不要。インストール済みのパッケージがないから。
RUN apt-get update

# ツールをインストールし、キャッシュを削除
RUN apt-get install -y --no-install-recommends\
		nginx \
		mariadb-server mariadb-client \
		php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath \
		vim wget \
	&& rm -rf /var/lib/apt/lists/*

# worlpressをダウンロード・解凍・移動
# chmod 与える
RUN wget https://wordpress.org/wordpress-5.6.1.tar.gz \
	&& tar -zxvf wordpress-5.6.1.tar.gz \
	&& rm -rf wordpress-5.6.1.tar.gz \
	&& mv wordpress/ /var/www/html/

# phpMyAdminをダウンロード・解凍・移動
RUN set -ex;\
	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& tar -zxvf phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.4-all-languages/ /var/www/html/phpMyAdmin

# 自己証明書を作成
RUN mkdir -p /etc/nginx/ssl \
	&& openssl req \
		-newkey rsa:4096 \
		-x509 -sha256 -nodes \
		-days 3650 \
		-out /etc/nginx/ssl/server.crt \
		-keyout /etc/nginx/ssl/server.key \
		-subj "/C=JP/ST=Tokyo/L=Roppongi/O=42Tokyo/OU=Student/CN=skurosu"

COPY srcs/default.conf /etc/nginx/sites-available/default

EXPOSE 80 443

# コンテナを起動させ続ける
CMD service nginx start \
	&& tail -f /dev/null