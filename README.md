# ft_server

## About
* 42cursus Level2
* Dockerを使ってWordPressが動くサーバーをつくろう  

## Usage
1. イメージの作成  
	`docker build -t ft_server_img .`
1. コンテナの起動  
	`docker run --name ft_server_ctr -d -p 8080:80 -p 443:443 ft_server_img`  
	* `-e AUTOINDEX=off` を追加するとオートインデックスが無効に。
	* https://localhost:443/wordpress にてWordPressにアクセスできます。
		* http://localhost:8080/wordpress も同様（SSL通信にリダイレクトされます）。
	* https://localhost/phpmyadmin にてphpMyAdminへアクセスができます。  
		* [user:admin, password:password]
1. コンテナを停止・削除  
	`docker stop ft_server_ctr && docker rm ft_server_ctr`
1. イメージを削除  
	`docker rmi ft_server_img`
