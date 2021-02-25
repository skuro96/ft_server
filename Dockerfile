# imageを指定
FROM debian:buster

# apt-get によってインストール可能なパッケージの一覧を更新する。
# apt-get upgrade は不要。インストール済みのパッケージがないから。
RUN apt-get update

# ツールをインストールし、キャッシュを削除
RUN apt-get install -y \
		nginx \
		mariadb-server mariadb-client \
		php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath \
		vim wget \
	&& rm -rf /var/lib/apt/lists/*


# worlpressをダウンロード・解凍・移動
# chmod 与える?
RUN wget https://wordpress.org/wordpress-5.6.1.tar.gz \
	&& tar -zxvf wordpress-5.6.1.tar.gz \
	&& rm -rf wordpress-5.6.1.tar.gz \
	&& mv wordpress/ /var/www/html/

COPY srcs/wp-config.php /var/www/html/wp-config.php

RUN chown -R www-data:www-data /var/www/html/wordpress


# phpMyAdminをダウンロード・解凍・移動
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
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

# mysql -u root -p
# CREATE DATABASE wordpress_db;
# CREATE USER 'admin'@'localhost' identified by 'password';
# GRANT ALL PRIVILEGES ON wordpress_db.* TO 'admin'@'localhost';
# FLUSH PRIVILEGES;
# EXIT;

RUN service mysql start \
	&& mysql -e "CREATE DATABASE wordpress_db;" \
	&& mysql -e "CREATE USER 'admin'@'localhost' identified by 'password';" \
	&& mysql -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'admin'@'localhost';" \
	&& mysql -e "FLUSH PRIVILEGES;"

EXPOSE 80 443

# コンテナを起動させ続ける
CMD service nginx start \
	&& service mysql start \
	&& service php7.3-fpm stop \
	&& service php7.3-fpm start \
	&& tail -f /dev/null