#!/bin/bash

############################
# install rbenv
############################
sudo apt -y update
sudo apt -y install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

############################
# install ruby
############################
# $2が長さ$1の配列のindexに含まれるかどうか
input_check() {
  local i
  for i in $(seq 0 $(($1-1)))
  do
    if [[ $i == $2 ]]; then  
      return 0
    fi
  done
  return 1
}

# 2.7.0以上のバージョンversに挿入
vers=()
for v in $(rbenv install -l 2> /dev/null | grep -E '^[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}$')
do
  if [[ $v < 2.7.0 ]]; then
    continue
  fi
  vers+=($v)
done

# version選択
while :
do
  for i in $(seq 0 $((${#vers[*]}-1)))
  do
    echo "${vers[$i]} [$i]"
  done
  read -p "上記のバージョンから選んでください(2.7.0以上のみ) > " index
  if input_check ${#vers[*]} $index;  then
    break
  fi
  echo
done

rbenv install "${vers[$index]}"
rbenv global "${vers[$index]}"
ruby -v


############################
# install shopify-cli
############################
gem install shopify-cli

############################
# authenticate shopify 
############################
domain="reveclo.myshopify.com"
shopify login --store "$domain"

############################
# pull theme
############################
if [ ! -d src ]; then
  mkdir src
fi
cd src
shopify theme pull
