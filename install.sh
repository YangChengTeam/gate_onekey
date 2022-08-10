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

install_wget(){
    if check_command wget; then
        echo "wget  installing..."
        yum -y install wget
    else
        echo "wget installed"
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
        npm install -g pm2 --registry=https://registry.npmmirror.com
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
    # mysql select 2
    # mysql passwrod set 123456
    # php select 8
    if check_command php; then
       ./install.sh lnmp
    else 
       echo "lnmp installed"
    fi  
    if check_command redis-cli; then
        ./addons.sh install redis
        ln /usr/local/redis/bin/redis-cli /usr/bin/redis-cli
    else
       echo "redis installed"
    fi
    # conf
    cd $root 
    if ! check_command mysql; then
        mysql -u root -p123456 -e "source yf_gateway.sql"
    fi
    
    if [[ -e /usr/local/php/etc/php.ini ]];then
         yes|cp -f $root/php.ini /usr/local/php/etc/php.ini
    fi
    if [[ -e /home/myweb/yf_local_gatewayworker/runtime ]];then
        chmod -R 777 /home/myweb/yf_local_gatewayworker/runtime
    fi
    if [[ -e /usr/local/redis/etc/redis.conf ]];then
         yes|cp -f $root/redis.conf /usr/local/redis/etc/redis.conf
    fi
    if [[ -e /etc/redis.conf ]];then
         yes|cp -f $root/redis.conf /etc/redis.conf
    fi
    if [[ -d /usr/local/nginx/conf/vhost/ ]];then
         yes|cp -f $root/web.conf /usr/local/nginx/conf/vhost/web.conf
    fi
}

install_pulsar(){
    cd $root
    if [[ ! -d apache-pulsar-2.10.0 ]];then
        tar xvfz apache-pulsar-2.10.0-bin.tar.gz
    fi

    cd apache-pulsar-2.10.0
    
    if [[ ! -e /opt/my-secret.key ]];then
        bin/pulsar tokens create-secret-key --output /opt/my-secret.key
    fi

    if [[ ! -e /opt/client.token ]];then
        bin/pulsar tokens create --secret-key file:///opt/my-secret.key --subject client >> /opt/client.token
    fi

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
   install_wget
   install_unzip
   install_java
   install_node
   install_lnmp
   install_pulsar
}

install_softs