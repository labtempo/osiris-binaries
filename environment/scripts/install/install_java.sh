#!/bin/bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default

cd ~
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
echo "export JRE_HOME=/usr/lib/jvm/java-8-oracle/jre" >> ~/.bashrc
. ~/bashrc
