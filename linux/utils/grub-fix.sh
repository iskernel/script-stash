#!/bin/bash
#Installs the tools which are necessary for fixing the grub
sudo add-apt-repository ppa:yannubuntu/boot-repair
sudo add-apt-repository ppa:danielrichter2007/grub-customizer

sudo apt-get update

sudo apt-get install grub-customizer
sudo apt-get install -y boot-repair && (boot-repair &)
