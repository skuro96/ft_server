# ft_server

## About
* 42cursus Level2
* Dockerを使ってWordPressが動くサーバーをつくろう

## Usage
1. イメージの作成  
	`docker build -t ft_server_img .`
2. コンテナの起動  
	`docker run --name ft_server_ctr -d -p 8080:80 -p 443:443 ft_server_img`
3. ブラウザ上で `http://localhost:8080/wordpress` を開く  
4. コンテナを停止・削除  
	`docker stop ft_server_ctr && docker rm ft_server_ctr`
5. イメージを削除  
	`docker rmi ft_server_img`