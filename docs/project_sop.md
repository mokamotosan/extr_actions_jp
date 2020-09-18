# Create your project directory
## Get a template
- clone a tamplete from: https://github.com/navdeep-G/samplemod.git
- rename it to your own project name
- remove .git directory
## Make some changes in the template
see: https://qiita.com/Ultra-grand-child/items/7717f823df5a30c27077
### setup.py
1. name
2. version
3. desription
4. author
5. author_email

# Create your own enviroment
cf. quick start for python:
https://code.visualstudio.com/docs/containers/quickstart-python
## Preparing
You'll need the Docker extension:
https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker
### Creating Docker files
1. opening the Command Pallete (F1 or 'ctrl+shit+P')
2. using "Docker: Add Docker Files to Workspace"
3. The command will generate Dockerfile and .dockerignore files.
4. Create .devcontainer directory and move the Dockerfile into it.
### Remove files in the .vscode directory
If you have tasks.json and luanch.json in .vscode directory, remove them.

# Build your container
## Open folder in container
ctrl + shift + P: Remote-Container: Open Folder in Container...
## About source control (git/gitHub)
- git/gitHubでのソースコントロールはローカルでやる（コンテナないではやらない）
- ある程度のところでローカルに切り替えて，gitすればよいかな
## Anaconda (python environment)
```shell
apt update
apt upgrade # you may need -y option
apt install wget # you may need -y option
wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh -O ~/anaconda.sh
bash ~/anaconda.sh -b -p $HOME/anaconda # The -p option specifies the installation directory
eval "$(/root/anaconda/bin/conda shell.bash hook)"
```
After that, reload your .bashrc
```shell
source ~/.bashrc
```
### NOTE: install in a silent-mode
https://docs.anaconda.com/anaconda/install/silent-mode/
### NOTE: apt/apt-get
You should apt/apt-get update, at first.
```shell
apt update
apt upgrade
```
```shell
apt-get update
apt-get upgrade
```
### NOTE
If you get an error saying "InRelease is not valid yet," rebuild your container:
https://qiita.com/nobuoka/items/1bb8cbb5af7be5259547
Or, if you've integrated WSL2 with Docker for Windows, fix time on your WSL2:
https://qiita.com/kazuhiro1982/items/8284dec3f892d0fc715a
```shell
# in your WSL
sudo hwclock -s
```
## checkinstall, ccache
https://qiita.com/SUZUKI_Masaya/items/bd03f39e20a1a8f7f4f6#%E5%BF%85%E8%A6%81%E3%81%AA%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB
```shell
apt install checkinstall ccache # You may need -y option
```

# Initialization of your project
## Create an repository on your local
- initialize it as your own repository.
- make your first add and commit.
## Make some changes in your template
see: https://qiita.com/Ultra-grand-child/items/7717f823df5a30c27077
### setup.py
6. (if you need) create "read_requirement" function in the setup.py and build it into the section "install_requirements = read_requirement()"
#### NOTE: install_requirements vs. dockerfile
If you use a docker container, you can also use requirement.txt instead of the install_requirements. In this SOP, DOCKERFILE must be adopted.
### requirements.text
#### create a list from pip
```shell
pip freeze > requirement.text
```
#### add some sources from gitHub
pypiに存在しないパッケージの時は以下のように追加
```shell
# git://リポジトリのURL.git
git://git@github.com/foo/foo.git
# プライベートリポジトリの場合は+sshをつける
git+ssh://git@github.com/foo/foo.git
```
## Connect your local repo to remote
1. create a repo that has the same name as your local
2. connect the local repo to the remote one (name your remote repo as "origin")
```shell
git remote add origin <URLFROMGITHUB>
```
3. push it: git push origin master


## TIPS
### .dockerignore
- *はワイルドカード: https://qiita.com/aosho235/items/07ad882bffa2508f152c
### Dockerfileの各種パラメータの意味は？
#### imagge:tage
```shell
FROM python:3.8-slim-buster
```
#### PYTHONDONTWRITEBYTECODE
pycファイルの生成を抑制:
https://devlights.hatenablog.com/entry/2018/02/23/124719
#### python app.py
CMDは docker run時にコマンドの上書きが可能:
https://qiita.com/hihihiroro/items/d7ceaadc9340a4dbeb8f
https://day-journal.com/memo/docker-002/
```shell
# During debuggin, this entry point will be overridden
CMD ["python", "app.py"]
```
### launch.jsonの各種パラメータの意味は？
### tasks.jsonの各種パラメータの意味は？
'ctrl+shift+B'でタスクを実行できるようになる: https://maku.blog/p/zn2er4g/
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "type": "npm",          // npm によるタスク実行
      "label": "npm: start",  // コマンドパレットに表示される名前
      "detail": "node main",  // その下に表示される説明文
      "script": "start",      // 実行する npm スクリプト名
      "group": {
        "kind": "build",      // ビルドタスクとして認識させる
        "isDefault": true     // Cmd + Shift + B で即実行
      },
      "problemMatcher": []
    }
  ]
}
```
#### Debugging Python within a container
https://code.visualstudio.com/docs/containers/debug-python
You can configure the entry point of the Docker container by setting properties in tasks.json.



### 未解決
- Enter the relative path to the app's entry point.とはなんぞや: https://code.visualstudio.com/docs/containers/debug-python
- .devcontainerは自動生成される？されない？Dockerfileを中に移してだいじょうぶ？:https://qiita.com/d0ne1s/items/d2649801c6f804019db7
- dockerfile作成 -> .devcontainer作成 -> dockerfileを.devcontainerに移動 -> open remote？？