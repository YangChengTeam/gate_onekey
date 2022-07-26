#!/bin/sh

#=================================================================#
#  System Required:  CentOS 6 or Higher                           #
#  Description: One click Install Package environment             #
#  Author：zhangkai <mzpbvsig@gmail.com>                          #
#=================================================================#
root=/opt

# Check command is exist
check_command(){
    local command=$1 
    if hash $command 2> /dev/null; then
        return 1
    else
        return 0
    fi
}

install_java(){
    if check_command java; then
        echo "java  installing..."
        yum -y install java
    else
        echo "java installed"
    fi
}

install_node(){
    if check_command node; then
        echo "node installing..."
        curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
        yum -y install nodejs    
    else
       echo "nodejs installed"
    fi

    if check_command pm2; then
        npm install -g pm2
     else
       echo "pm2 installed"
    fi
}

install_unzip(){
    if check_command unzip; then
        echo "unzip  installing..."
        yum -y install unzip
    else
       echo "unzip installed"
    fi
}

install_lnmp(){
    cd $root
    if [[ ! -e lnmp1.9.tar.gz ]];then
        wget http://soft.vpser.net/lnmp/lnmp1.9.tar.gz -cO lnmp1.9.tar.gz 
    fi
    if [[ ! -d lnmp1.9 ]];then
        tar zxf lnmp1.9.tar.gz 
    fi 
    cd lnmp1.9
    # mysql passwrod set 123456
    if check_command nginx;then
       ./install.sh nginx
    else
       echo "nginx installed"
    fi  
    if check_command mysql; then
        ./install.sh mysql
    else
       echo "mysql installed"
    fi
    if check_command php; then
        ./install.sh php
    else
       echo "php installed"
    fi
    if check_command redis-cli; then
        ./addons.sh install redis
    else
       echo "redis installed"
    fi
# conf
    cd $root 
    if ! check_command mysql; then
        mysql -u root -p123456 -e "source yf_gateway.sql"
    fi
    if [[ -e /usr/local/redis/etc/redis.conf ]];then
         cp -f $root/redis.conf /usr/local/redis/etc/redis.conf
    fi
    if [[ -e /etc/redis.conf ]];then
         cp -f $root/redis.conf /etc/redis.conf
    fi
    cp -f $root/web.conf /usr/local/nginx/conf/vhost/web.conf
}

install_pulsar(){
cd $root
if [[ ! -d apache-pulsar-2.10.0 ]];then
    tar xvfz apache-pulsar-2.10.0-bin.tar.gz
fi
cd apache-pulsar-2.10.0
yes|cp -f $root/standalone.conf conf/standalone.conf
yes|cp -f $root/functions_worker.yml conf/functions_worker.yml
yes|cp -f $root/client.conf conf/client.conf

cd $root
if [[ ! -d pulsar-manager ]];then
    unzip pulsar-manager.zip
fi
cd pulsar-manager/pulsar-manager
yes|cp -r ../dist ui
yes|cp -f $root/application.properties application.properties
}

install_softs(){
   install_java
   install_node
   install_lnmp
   install_pulsar
}

install_softs