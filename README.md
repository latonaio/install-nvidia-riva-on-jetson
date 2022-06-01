# install-nvidia-riva-on-jetson
install-nvidia-riva-on-jetsonは、NVIDIA RivaをJetson上にインストールする手順概要です。


## 動作環境
- NVIDIA
    - JetPack
    - Deepstream
- Docker
- Docker Compose v2
- GNU Make

## NVIDIA Rivaについて
NVIDIA Rivaは音声AIアプリケーションの構築、ユースケースに合わせたカスタマイズ、リアルタイムパフォーマンスの提供を実現するためのGPU-accelerated SDKです。

## インストール
以下のコマンドでRivaをインストールし、Riva Speech Serverを立ち上げることができます。  
詳細は[Quick Start Guide](https://docs.nvidia.com/deeplearning/riva/user-guide/docs/quick-start-guide.html)を参照してください。

```
start-riva-server: ## Quick Start Scripts のダウンロード、Riva Speech Server の立ち上げ
        ngc registry resource download-version nvidia/riva/riva_quickstart_arm64:2.1.0
        cd riva_quickstart_arm64_v2.1.0 && bash riva_init.sh && bash riva_start.sh
```
Dockerコンテナが起動するので「Ctrl + P」+「Ctrl + Q」でコンテナから抜けます。



## 動作手順
### Docker イメージの作成
以下のコマンドでRiva Speech Skill Tutorialsを動作させるためのDocker イメージを作成します。
```
docker-build: ## docker image の作成
        docker-compose build
```

### Docker コンテナの起動
以下のコマンドでDocker コンテナを起動します。
```
docker-run: ## docker container の立ち上げ
        docker-compose up -d
```

### Jupyter Notebookの起動
以下のコマンドでDocker内でJupyter Notebookを起動します。
```
start-jupyter: ## jupyter notebook の立ち上げ
        docker exec -it -w /app/src/tutorials riva-jupyter venv-riva-tutorials/bin/jupyter notebook --allow-root --port 8889 --ip=0.0.0.0
```   
コンソールにURLが2つ表示されるので、下のURL（`http://127.0.0.1:8889/?token=xxxxx`）をクリックするとJupyter Notebookが開きます。

### ASRの実行
Jupyter Notebook上で asr-python-basics.ipynb を開き、ASRを実行します。  
この時、変数 uriにJetsonのIPアドレスを入力してください。  
ただし、現在では他の .ipynb ファイルは実行できません。  
詳細は[Riva Speech Skills Tutorials](https://github.com/nvidia-riva/tutorials)を参照してください。
