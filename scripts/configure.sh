#!/bin/bash

# To run for new vms

# Copy the files - to be run manually
# sudo yum install -y git
# git clone "https://github.com/LuluDavid/AttestationGenerator.git"

# Python
sudo yum install -y python3
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
rm get-pip.py

# Selenium and urllib3
pip3 install -r AttestationGenerator/requirements.txt

# Chromedriver
wget https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/local/bin/chromedriver
sudo rm chromedriver_linux64.zip

# Google Chrome
sudo curl https://intoli.com/install-google-chrome.sh | bash
sudo mv /usr/bin/google-chrome-stable /usr/local/bin/google-chrome

# Update .bashrc
echo "export PATH=$PATH:/usr/local/bin" >> .bashrc
echo "alias python=python3" >> .bashrc
source /home/.bashrc

# Create Downloads directory
sudo mkdir Downloads
sudo chmod a+rwx Downloads