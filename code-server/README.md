
```bash
brew install mkcert

mkdir $HOME/.vscode-server-cert
cd $HOME/.vscode-server-cert

mkcert -install
mkcert localhost 127.0.0.1

docker rm -f vscode-server || true

docker run -d \
    --restart=always \
    --name=vscode-server \
    -v $HOME/.npm:/root/.npm \
    -v $HOME/.m2/repository:/root/.m2/repository \
    -v devbox-home:/root \
    -v devbox-workspace:/workspace \
    -v $HOME/.vscode-server-cert:/root/certs \
    -w /workspace \
    -p 127.0.0.1:10443:8443 \
    subchen/code-server \
    --no-auth \
    --cert=/root/certs/localhost+1.pem \
    --cert-key=/root/certs/localhost+1-key.pem

```
