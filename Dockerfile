# imageを指定
FROM debian:buster

# 環境変数を設定
ENV AUTOINDEX on

# ツールをインストールし、キャッシュを削除
RUN apt-get update \
	&& apt-get install -y \
		wget \
		nginx \
		mariadb-server mariadb-client \
		php-cgi php-common php-fpm php-pear php-mbstring php-zip \
		php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath \
	&& rm -rf /var/lib/apt/lists/*

# worlpressをダウンロード・解凍・権限を付与
RUN wget https://wordpress.org/wordpress-5.6.1.tar.gz \
	&& mkdir -p /var/www/html/wordpress \
	&& tar -zxvf wordpress-5.6.1.tar.gz -C /var/www/html/wordpress --strip-components 1 \
	&& rm -rf wordpress-5.6.1.tar.gz \
	&& chown -R www-data:www-data /var/www/html/wordpress

# phpMyAdminをダウンロード・解凍
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& mkdir -p /var/www/html/phpmyadmin \
	&& tar -zxvf phpMyAdmin-5.0.4-all-languages.tar.gz -C /var/www/html/phpmyadmin --strip-components 1 \
	&& rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz

# 証明書を作成
RUN mkdir -p /etc/nginx/ssl \
	&& openssl req \
		-newkey rsa:4096 \
		-x509 -sha256 -nodes \
		-days 3650 \
		-out /etc/nginx/ssl/server.crt \
		-keyout /etc/nginx/ssl/server.key \
		-subj "/C=JP/ST=Tokyo/L=Roppongi/O=42Tokyo/OU=Student/CN=skurosu"

# データベースを作成
RUN service mysql start \
	&& mysql -e "CREATE DATABASE wordpress_db;" \
	&& mysql -e "CREATE USER 'admin'@'localhost' identified by 'password';" \
	&& mysql -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'admin'@'localhost';" \
	&& mysql -e "FLUSH PRIVILEGES;"

# 用意したファイルをコピー
COPY srcs/default.conf /etc/nginx/sites-available/default
COPY srcs/wp-config.php /var/www/html/wp-config.php
COPY srcs/init.sh /tmp/init.sh

# コンテナを起動させ続ける
CMD bash /tmp/init.sh
