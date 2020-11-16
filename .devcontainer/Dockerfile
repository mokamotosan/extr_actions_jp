# For more information, please refer to https://aka.ms/vscode-docker-python
# BASE IMAGE: python enviroment on Anaconda (base: python 3.7.4)
FROM continuumio/anaconda3:2019.10

# Install requirements
## Upgrade apt
RUN echo deb http://deb.debian.org/debian buster-backports main >> /etc/apt/sources.list && \
     apt update && apt -y upgrade
### NOTE:
### if you recieved an error saying "Release file for *** is not valid yet,"
### check https://qiita.com/kazuhiro1982/items/8284dec3f892d0fc715a.
## Libraries: checkinstall, ccache, and others
RUN apt install -y ccache checkinstall libcdb-dev libjuman zlib1g-dev libboost-dev
## Juman
RUN wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-7.01.tar.bz2 -O ~/juman-7.01.tar.bz2 && \
     mkdir -p /usr/local/libexec/juman /usr/local/share/juman/dic && \
     cd ~ && tar -jxvf ~/juman-7.01.tar.bz2 && cd ~/juman-7.01/ && \
     ./configure CFLAGS="-O3" CXXFLAGS="-O3" && \
     make -j $(grep -c ^processor /proc/cpuinfo) && \
     checkinstall -y && \
     echo "alias juman='juman -r /usr/local/etc/jumanrc'" >> ~/.bashrc && . ~/.bashrc
## KNP
RUN wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-4.20.tar.bz2 -O ~/knp-4.20.tar.bz2 && \
     mkdir -p /usr/local/share/knp/rule /usr/local/share/knp/dict && \
     cd ~ && tar -jxvf ~/knp-4.20.tar.bz2 && cd ~/knp-4.20 && \
     ./configure CFLAGS="-O3" CXXFLAGS="-O3" && \
     make -j $(grep -c ^processor /proc/cpuinfo) && \
     checkinstall -y
## Juman++
RUN wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.02.tar.xz -O ~/jumanpp-1.02.tar.xz && \
     cd ~ && tar -Jxvf jumanpp-1.02.tar.xz && cd ~/jumanpp-1.02 && \
     ./configure CFLAGS="-O3" CXXFLAGS="-O3" && \
     make -j $(grep -c ^processor /proc/cpuinfo) && \
     checkinstall -y
## PyKNP: pknp -> python[version='>=3.6, <3.7.0a0|>=3.7,<3.8.0a0']
RUN conda update -y -n base -c defaults conda && \
     conda install -y -c temporary-recipes pyknp
## Install pip requirements
# ADD requirements.txt .
# RUN python -m pip install -r requirements.txt

# 環境変数の設定
## Keeps Python from generating .pyc files in the container
#ENV PYTHONDONTWRITEBYTECODE 1
## Turns off buffering for easier container logging
#ENV PYTHONUNBUFFERED 1

## 作業ディレクトリの指定: mainly for production
#WORKDIR /app
#
## ユーザの指定: Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
#RUN useradd appuser && chown -R appuser /app
#USER appuser

# ラベルの指定
LABEL maintainer "Masahiro Okamoto<motchyenator@gmail.com>"
LABEL title="ExtrActions_ja"
LABEL version="1.0"
LABEL description="This image is for developing ExtrActions_ja"

# ポートの設定
# EXPOSE 8080

# Dockerfile内変数の設定
#ARG MYNAME="masahiro"

# デフォルトシェルの設定
#SHELL ["bin/bash", "-c"]

# ファイル・ディレクトリの追加
#ADD . /app

# ファイルのコピー
#COPY /sampledata/190226【人物評価に関する調査（ローデータ）】ご納品.xlsx /sampledata/

# ボリュームのマウント
#VOLUME /mnt

# # During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
# CMD ["python", "app.py"]
# 