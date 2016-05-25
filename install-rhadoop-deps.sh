#!/bin/bash

# install compiler stuff and R
echo "installing Development Tools and R"
yum groupinstall -y "Development Tools"
yum install -y automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel openssl-devel
yum install -y R

# set some environment vars 
echo "setting enviringment vars"
echo "export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64:$JAVA_HOME/jre/lib/amd64/server" >> ~/.bash_profile
echo "export HADOOP_CMD=/usr/bin/hadoop" >> ~/.bash_profile
echo "export HADOOP_STREAMING=/usr/lib/hadoop-mapreduce/hadoop-streaming.jar" >> ~/.bash_profile
echo "export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig" >> ~/.bash_profile

source ~/.bash_profile

# download and install thrift
echo "downloading and instaling thrift"
wget http://archive.apache.org/dist/thrift/0.8.0/thrift-0.8.0.tar.gz
cd thrift-0.8.0
./configure --without-ruby --without-python
make
make install
ln -s /usr/local/lib/libthrift-0.8.0.so /usr/lib64

# back to home
cd ~ 

# download rhadoop components
echo "downloading RHadoop components"
wget https://github.com/RevolutionAnalytics/rmr2/releases/download/3.3.1/rmr2_3.3.1.tar.gz
wget https://github.com/RevolutionAnalytics/plyrmr/releases/download/0.6.0/plyrmr_0.6.0.tar.gz
wget https://github.com/RevolutionAnalytics/ravro/blob/1.0.4/build/ravro_1.0.4.tar.gz?raw=true
wget https://github.com/RevolutionAnalytics/rhbase/blob/master/build/rhbase_1.2.1.tar.gz?raw=true
wget https://github.com/RevolutionAnalytics/rhdfs/blob/master/build/rhdfs_1.0.8.tar.gz?raw=true

# done
echo "All done, now start R to install the components"

