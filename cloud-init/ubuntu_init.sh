#!/bin/sh

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-add-repository --y --update ppa:ansible/ansible
sudo apt-get install -y ansible
sudo apt-get install -y python-pip
pip install "pywinrm>=0.3.0"
