## 本地网关一键脚本

##  已验证环境 centos7

### 1. 安装步骤

- git 安装
    - 安装git-lfs
      - [下载git-lfs-3.2.0-1.el7.x86_64.rpm](git-lfs-3.2.0-1.el7.x86_64.rpm)
      -  **yum install -y git && yum -y install git-lfs**
    - 执行 **git-lfs clone https://github.com/YangChengTeam/gate_onekey && cd  gate_onekey && mv \*.\* /opt && cd /opt && sh install.sh**
    - 命令完成后  再次执行**sh install.sh**检测环境是否安装成功
- zip安装
    - 查看unzip是否已安装
       - 执行 **unzip**
       - 如未安装
         - 执行 **yum -y install unzip**
    - 执行 **unzip -d gate_onekey.zip**
    - 执行 **cd  gate_onekey && mv \*.\* /opt && cd /opt**
    - 执行 **sh install.sh**
    - 命令完成后  再次执行**sh install.sh**检测环境是否安装成功


- q&a
    - lnmp 选项
        - mysql
            - 选择：2
            - 密码: 123456
            - 其它默认
        - php
            - 选择：8
            - 其它默认
        