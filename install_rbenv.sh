#!/bin/bash

# install rbenv
sudo apt -y update
sudo apt -y install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# install ruby
rbenv install -l
echo "上記のリストからインストールしたいバージョンを入力してください"
echo -n ">> "
read v

rbenv install "$v"
rbenv global "$v"
ruby -v

# install shopify-cli
gem install shopify-cli

# authenticate shopify 
domain="reveclo.myshopify.com"
shopify login --store "$domain"

# pull theme
if [ ! -d src ]; then
  mkdir src
fi
cd src
shopify theme pull
