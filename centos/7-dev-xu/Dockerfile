FROM centos:7

RUN yum makecache \
 && yum install -y git \
 && yum install -y make autoconf automake gcc gcc-c++ libtool \
 && yum install -y openssh-clients openssl \
 && yum install -y rpm-build yum-utils createrepo \
 && yum install -y bash-completion sudo wget which zip unzip tree yajl epel-release net-tools \
 && yum install -y sshpass the_silver_searcher jq \
 && yum clean all \
 && rm -rf /var/cache/yum/*

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo -e "LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8" > /etc/environment

################################################################

RUN yum install -y openssh-server \
 && yum clean all \
 && rm -rf /var/cache/yum/* \
 && ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_ed25519_key \
 && sed '/UseDNS/c UseDNS=no' /etc/ssh/sshd_config \
 && echo 'root:123123' | chpasswd

EXPOSE 22

#CMD [/usr/sbin/sshd, -D]

################################################################
RUN yum install -y openssh-clients \
 && yum clean all \
 && rm -rf /var/cache/yum/* \
 && mkdir -p /root/.ssh \
 && ssh-keygen -q -N '' -t rsa -f /root/.ssh/id_rsa \
 && echo -e "Host *\n  StrictHostKeyChecking no\n  UserKnownHostsFile /dev/null\n  LogLevel ERROR" > /root/.ssh/config

################################################################
VOLUME /root

################################################################
RUN yum install -y gcc make cmake \
 && yum install -y zlib zlib-devel bzip2-devel libffi libffi-devel readline-devel sqlite-devel \
 && yum install -y openssl-devel openssl11 openssl11-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

RUN cd /root/ \
 && curl -fSL https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz -o Python-3.11.2.tgz \
 && tar -zxf Python-3.11.2.tgz \
 && rm -rf Python-3.11.2.tgz \
 && cd ./Python-3.11.2 \
 && CFLAGS=$(pkg-config --cflags openssl11) LDFLAGS=$(pkg-config --libs openssl11) ./configure --enable-loadable-sqlite-extensions --prefix=/usr/local/python-3.11.2 \
 && make \
 && make install \
 && rm -rf ./Python-3.11.2

RUN ln -s /usr/local/python-3.11.2/bin/python3 /usr/local/bin/python3 \
 && ln -s /usr/local/python-3.11.2/bin/pip3    /usr/local/bin/pip3 \
 && ln -s /usr/local/bin/python3               /usr/local/bin/python \
 && ln -s /usr/local/bin/pip3                  /usr/local/bin/pip


################################################################
## install ffmpge
RUN rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro \
 && yum install -y http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm \
 && yum install -y ffmpeg ffmpeg-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

################################################################
# use yum-repo mirrors
RUN curl -fSL https://mirrors.aliyun.com/repo/Centos-7.repo -o /etc/yum.repos.d/CentOS-Base.repo \
 && curl -fSL https://mirrors.aliyun.com/repo/epel-7.repo -o /etc/yum.repos.d/epel.repo

## use pip mirrors
RUN mkdir -p ~/.pip \
 && echo -e "[global]\nindex-url=https://pypi.tuna.tsinghua.edu.cn/simple\n[install]\ntrusted-host=https://pypi.tuna.tsinghua.edu.cn" > ~/.pip/pip.conf

################################################################
