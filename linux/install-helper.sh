#!/bin/bash

isInstalled()
{
    type "$1" 2>/dev/null
}

#Add google chrome repository
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#Add java oracle repository
sudo add-apt-repository ppa:webupd8team/java
#Add grub customizer repository
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
#Add dropbox nautilus repository
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
#Add monodevelop repository
sudo add-apt-repository ppa:keks9n/monodevelop-latest
#Add ruby-experimental repository
sudo add-apt-repository ppa:brightbox/ruby-ng-experimental

#Update
sudo apt-get update

#Installs the mighty git
sudo apt-get install git

#Utilities
sudo apt-get install grub-customizer
sudo apt-get install rar unrar
sudo apt-get install synaptic

#Programming languages and tools
sudo apt-get install perl cpan
sudo apt-get install cmake autoconf automake

#Install Ruby, rbenv, gem
cd "/home/$USER/"
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.1.2
rbenv global 2.1.2

#Install Node.js and related
sudo apt-get install nodejs npm
#For Bower
sudo ln -s /usr/bin/nodejs /usr/bin/node

#Developer tools
sudo apt-get install oracle-java8-installer
sudo apt-get install monodevelop
sudo apt-get install qtcreator
sudo apt-get install eclipse
sudo apt-get install tortoisehg
sudo apt-get install retexter

#Browsers
sudo apt-get install google-chrome-stable

#Fonts
sudo apt-get install ttf-mscorefonts-installer

#Cloud
sudo apt-get install dropbox
sudo apt-get install libappindicator1

#Removes Amazon lens
sudo apt-get remove unity-lens-shopping

#Selects which java version to use
sudo update-alternatives --config java

#Extra
if isInstalled "nautilus"; then
  sudo apt-get install nautilus-open-terminal
  sudo apt-get install dconf-editor
fi
