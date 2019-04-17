FROM centos:7

RUN yum makecache \
 && yum install -y git \
 && yum install -y make gcc gcc-c++ libtool \
 && yum install -y openssh-clients openssl \
 && yum install -y rpm-build yum-utils createrepo \
 && yum install -y bash-completion wget which zip unzip tree yajl epel-release net-tools \
 && yum clean all \
 && rm -rf /var/cache/yum/*

################################################################
ENV GOVERSION 1.11.4
ENV GOROOT /usr/share/go

ENV PATH $GOROOT/bin:$PATH

RUN curl -fSL https://dl.google.com/go/go${GOVERSION}.linux-amd64.tar.gz -o golang.tar.gz \
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
ENV MAVEN_VERSION 3.6.1
ENV MAVEN_HOME /usr/share/maven

RUN curl -fSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -o maven.tar.gz \
 && mkdir -p $MAVEN_HOME \
 && tar xzf maven.tar.gz --strip-components=1 -C $MAVEN_HOME \
 && rm -rf maven.tar.gz \
 && ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

VOLUME /root/.m2/repository

################################################################
ENV NODE_VERSION 10.15.3

RUN curl -fSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o node.tar.gz \
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

RUN curl -fSL https://bootstrap.pypa.io/get-pip.py | python

################################################################
RUN yum install -y ruby ruby-devel libffi-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

RUN gem install fpm travis \
 && rm -rf /root/.gem \
 && mkdir -p /root/.travis \
 && echo "checked_completion: true" > /root/.travis/config.yml

################################################################
RUN curl -fSL https://copr.fedorainfracloud.org/coprs/lbiaggi/vim80-ligatures/repo/epel-7/lbiaggi-vim80-ligatures-epel-7.repo -o /etc/yum.repos.d/vim80.repo \
 && yum install -y vim-enhanced \
 && yum install -y ctags cscope \
 && yum clean all \
 && rm -rf /var/cache/yum/* \
 && curl -fSL https://raw.githubusercontent.com/subchen/dev-box/master/vim/config/.vimrc -o /root/.vimrc \
 && curl -fSL https://raw.githubusercontent.com/subchen/dev-box/master/vim/update-vim-plugins.sh | bash -e

################################################################
ENV POWERLINE_VERSION 1.12.1

RUN curl -fSL https://github.com/justjanne/powerline-go/releases/download/v$POWERLINE_VERSION/powerline-go-linux-amd64 -o /usr/local/bin/powerline-go \
 && chmod +x /usr/local/bin/powerline-go

RUN mkdir -p /root/.bash \
 && curl -fSL https://raw.githubusercontent.com/subchen/dev-box/master/powerline-go/config/powerline-go.bash -o /root/.bash/powerline-go.bash \
 && echo ". /root/.bash/powerline-go.bash" >> /root/.bashrc

################################################################
RUN yum install -y openssh-server openssh-clients \
 && ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_ed25519_key \
 && echo 'root:123123' | chpasswd

EXPOSE 22

#CMD [/usr/sbin/sshd, -D]

################################################################
VOLUME /root

