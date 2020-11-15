#!/bin/bash

APT_PACKAGES="apt-utils ffmpeg libav-tools x264 x265 wget"
apt-install() {
	export DEBIAN_FRONTEND=noninteractive
	apt-get update -q
	apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" $APT_PACKAGES
	return $?
}

#install ffmpeg to container
apt-install || exit 1

#create folders
#! /bin/bash
mkdir data
cd data
wget http://www.vlfeat.org/matconvnet/models/beta16/imagenet-vgg-verydeep-19.mat
mkdir bin
wget http://msvocds.blob.core.windows.net/coco2014/train2014.zip
unzip train2014.zip
cd ..

#run style transfer on video
python style.py --style ward.jpg \
  --checkpoint-dir /artifacts \
  --test test.jpeg \
  --test-dir /artifacts \

