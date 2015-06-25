#!/usr/bin/env bash

echo "Installing pre-reqs"
echo -e "\n\n+++ Installing pre-reqs +++" >> provision.log
apt-get -y update >> ../provision.log 2>&1
apt-get -y install curl >> ../provision.log 2>&1
apt-get -y install ruby1.9.3 >> ../provision.log 2>&1
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 >> ../provision.log 2>&1
curl -L https://get.rvm.io | bash -s stable
rvm install ruby-1.9.3 >> ../provision.log 2>&1
rvm use 1.9.3 
gem install bundle


echo "Download Zombie application source"
echo -e "\n\n+++ Download Zombie application source +++" >> provision.log
git clone https://github.com/mjbrender/riak-inverted-index-demo.git



chown -R vagrant riak-inverted-index-demo/
cd riak-inverted-index-demo

echo "Running bundler"
echo -e "\n\n+++ Running bundler +++" >> provision.log
bundle install 

echo "Make sure Riak is online"
echo -e "\n\n+++ Make sure Riak is online +++" >> provision.log
riak start

echo "Go go gadget application!"

echo "Loading data into Riak KV on vagrant VMs' protobuff port 8098"
echo -e "\n\n+++ Loading data into Riak KV on 8098 +++" >> provision.log
ruby load_data.rb data.csv
cat load_progress.txt >> provision.log 2>&1
echo -e "\n\n+++ Completed loading of data +++" >> provision.log

echo -e "\n\n+++ running \"bundle exec unicorn -c uniccorn.rb\" +++" >> provision.log
bundle exec unicorn -c unicorn.rb -l 0.0.0.0:8080 & disown