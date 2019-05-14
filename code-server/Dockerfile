FROM subchen/centos:7-dev

RUN wget http://download-ib01.fedoraproject.org/pub/fedora/linux/updates/29/Everything/x86_64/Packages/l/libstdc++-8.3.1-2.fc29.x86_64.rpm \
 && wget http://download-ib01.fedoraproject.org/pub/fedora/linux/updates/28/Everything/x86_64/Packages/g/glibc-common-2.27-38.fc28.x86_64.rpm \
 && wget http://download-ib01.fedoraproject.org/pub/fedora/linux/updates/28/Everything/x86_64/Packages/g/glibc-2.27-38.fc28.x86_64.rpm \
 && wget http://download-ib01.fedoraproject.org/pub/fedora/linux/updates/28/Everything/x86_64/Packages/g/glibc-langpack-en-2.27-38.fc28.x86_64.rpm \
 && rpm -ivh --force *.rpm \
 && rm -f *.rpm

RUN curl -s -fSL https://github.com/cdr/code-server/releases/download/1.939-vsc1.33.1/code-server1.939-vsc1.33.1-linux-x64.tar.gz -o code-server.tar.gz \
 && tar -zxf code-server.tar.gz -C /usr/local/bin --strip-components=1

RUN curl -fSL https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 -o /usr/local/bin/dumb-init \
 && chmod +x /usr/local/bin/dumb-init

WORKDIR /workspace

ENTRYPOINT ["dumb-init", "code-server"]

#docker run -it --rm \
#    -p 8443:8443 \
#    -v $HOME/.m2/repository:/root/.m2/repository \
#    -v devbox-home:/root \
#    -v devbox-workspace:/workspace \
#    -w /workspace \
#    code-server \
#    --allow-http --no-auth
