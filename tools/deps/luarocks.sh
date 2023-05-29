wget https://luarocks.org/releases/luarocks-3.9.2.tar.gz
tar zxpf luarocks-3.9.2.tar.gz
cd luarocks-3.9.2
./configure  --prefix=${HOME}/.local/opt/rocks && make && sudo make install
