#!/bin/bash

wget https://nodejs.org/dist/v22.8.0/node-v22.8.0-linux-x64.tar.xz -O /tmp/node-v22.8.0-linux-x64.tar.xz

if [[ -d /usr/local/lib/node_modules ]]; then
  sudo mv /usr/local/lib/node_modules /usr/local/lib/node_modules.old
fi
if [[ -d /usr/local/include/node ]]; then
  sudo mv /usr/local/include/node /usr/local/include/node.old
fi
if [[ -d /usr/local/bin/node ]]; then
  sudo rm -rf /usr/local/bin/node
  sudo rm -rf /usr/local/bin/npm
  sudo rm -rf /usr/local/bin/npx
  sudo rm -rf /usr/local/bin/corepack
fi

sudo tar -xvf /tmp/node-v22.8.0-linux-x64.tar.xz -C /usr/local --strip-components=1
