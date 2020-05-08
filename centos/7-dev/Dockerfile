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
ENV GOVERSION 1.14.2
ENV GOROOT /usr/share/go

ENV PATH $GOROOT/bin:$PATH

RUN curl -s -fSL https://dl.google.com/go/go${GOVERSION}.linux-amd64.tar.gz -o golang.tar.gz \
 && mkdir -p $GOROOT \
 && tar -zxf golang.tar.gz -C $GOROOT --strip-components=1 \
 && rm -f golang.tar.gz

################################################################
ENV JAVA_VERSION 1.8.0
ENV JAVA_HOME /usr/lib/jvm/java-$JAVA_VERSION-openjdk

RUN yum makecache \
 && yum install -y java-$JAVA_VERSION-openjdk-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

################################################################
ENV MAVEN_VERSION 3.6.3
ENV MAVEN_HOME /usr/share/maven

RUN curl -s -fSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -o maven.tar.gz \
 && mkdir -p $MAVEN_HOME \
 && tar xzf maven.tar.gz --strip-components=1 -C $MAVEN_HOME \
 && rm -rf maven.tar.gz \
 && ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

VOLUME /root/.m2/repository

################################################################
ENV NODE_VERSION 12.16.3

RUN curl -s -fSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o node.tar.gz \
 && tar -xzf node.tar.gz -C /usr/local --strip-components=1 \
 && rm -f node.tar.gz

RUN npm install -g yarn \
 && rm -rf /root/.npm

#RUN yarn global add mocha istanbul nyc spec-xunit-file js-beautify eslint \
# && rm -rf /usr/local/share/.cache/yarn

VOLUME /root/.npm

################################################################
RUN yum install -y python python-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

RUN curl -s -fSL https://bootstrap.pypa.io/get-pip.py | python

################################################################
RUN yum install -y ruby ruby-devel libffi-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

#RUN yum install -y centos-release-scl-rh centos-release-scl \
# && yum --enablerepo=centos-sclo-rh install -y rh-ruby26 rh-ruby26-ruby-devel libffi-devel \
# && echo "source scl_source enable rh-ruby26" >> /root/.bashrc \
# && yum clean all \
# && rm -rf /var/cache/yum/*

#RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
# && curl -sSL https://get.rvm.io | bash -s stable
#
#RUN source /etc/profile.d/rvm.sh \
# && rvm install ruby-2.6 \
# && rvm use ruby-2.6 --default

RUN gem install fpm travis:1.8.13 gh:0.16.0 \
 && rm -rf /root/.gem \
 && mkdir -p /root/.travis \
 && echo "checked_completion: true" > /root/.travis/config.yml

################################################################
RUN curl -s -fSL https://copr.fedorainfracloud.org/coprs/lbiaggi/vim80-ligatures/repo/epel-7/lbiaggi-vim80-ligatures-epel-7.repo -o /etc/yum.repos.d/vim80.repo \
 && yum install -y vim-enhanced \
 && yum install -y ctags cscope \
 && yum clean all \
 && rm -rf /var/cache/yum/* \
 && curl -s -fSL https://raw.githubusercontent.com/subchen/dev-box/master/vim/config/.vimrc -o /root/.vimrc \
 && curl -s -fSL https://raw.githubusercontent.com/subchen/dev-box/master/vim/update-vim-plugins.sh | bash -e

################################################################
ENV POWERLINE_VERSION 1.17.0

RUN curl -fSL https://github.com/justjanne/powerline-go/releases/download/v$POWERLINE_VERSION/powerline-go-linux-amd64 -o /usr/local/bin/powerline-go \
 && chmod +x /usr/local/bin/powerline-go

RUN mkdir -p /root/.bash \
 && curl -s -fSL https://raw.githubusercontent.com/subchen/dev-box/master/powerline-go/config/powerline-go.bash -o /root/.bash/powerline-go.bash \
 && echo "source /root/.bash/powerline-go.bash" >> /root/.bashrc

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
 && curl -s -fSL https://github.com/subchen/dev-box/blob/master/ssh/config/config -o /root/.ssh/config

################################################################
VOLUME /root

