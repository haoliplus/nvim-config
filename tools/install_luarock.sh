set -ex
sudo apt install -y lua5.4 liblua5.4-dev
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz -O /tmp/luarocks-3.11.1.tar.gz
cd /tmp
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure && make && sudo make install
sudo luarocks install luasocket
