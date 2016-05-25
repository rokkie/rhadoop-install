#!/usr/bin/env bash

# install RStudio Server
echo "downloading and installing rpm"
cd ~
wget http://download2.rstudio.org/rstudio-server-rhel-0.99.902-x86_64.rpm
yum install -y --nogpgcheck ./rstudio-server-rhel-0.99.902-x86_64.rpm

# cleanup
echo "removing rpm"
rm -f ./rstudio-server-rhel-0.99.902-x86_64.rpm

# create user
echo "create rstudio user and group"
groupadd rstudio
useradd -g rstudio rstudio
echo "rstudio" | passwd rstudio --stdin

# configure server so only rstudio users can login
echo "configuring rstudio"
echo "auth-required-user-group=rstudio" >> /etc/rstudio/rserver.conf

# set environment vars
cd ~
echo "setting environment vars"
echo "" >> /usr/lib64/R/etc/Renviron
echo "# set env vars for RHadoop" >> /usr/lib64/R/etc/Renviron
echo "LD_LIBRARY_PATH=\$JAVA_HOME/jre/lib/amd64:\$JAVA_HOME/jre/lib/amd64/server" >> /usr/lib64/R/etc/Renviron
echo "HADOOP_CMD=/usr/bin/hadoop" >> /usr/lib64/R/etc/Renviron
echo "HADOOP_STREAMING=/usr/lib/hadoop-mapreduce/hadoop-streaming.jar" >> /usr/lib64/R/etc/Renviron
echo "PKG_CONFIG_PATH=\$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig" >> /usr/lib64/R/etc/Renviron

# reboot server
echo "restarting server"
rstudio-server restart

# display login details
echo "You can now login via port 8787"
echo "un: rstudio"
echo "pw: rstudio"

# done
echo "Done installing Rstudio Server"
echo "Forward port 8787 via the GUI of VirtualBox or via the CLI of the host machine:"
echo "vboxmanage modifyvm \"Hortonworks Sandbox 2.1\" --natpf1 tcp8787,tcp,127.0.0.1,8787,,8787"
echo "RStudio Server is then available on:"
echo "http://localhost:8787"
echo "The name of the VM may differ on your machine. To list all the VMS:"
echo "vboxmanage list vms"

