## 本地网关一键脚本

##  已验证环境 centos7

### 1. 安装步骤

- git 安装
    - 查看git是否已安装
      - 执行 **git**
       - 如未安装
         - 执行 **yum -y install git**
    - 执行 **git clone https://gitee.com/mzpbvsig/gate_onekey**
    - 执行 **cd  gate_onekey && mv \*.\* /opt && cd /opt**
    - 执行 **sh install.sh**
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