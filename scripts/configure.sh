#!/bin/bash

# To run for new vms

# Copy the files - to be run manually
# sudo yum -y update
# sudo yum install -y git
# git clone "https://github.com/LuluDavid/AttestationGenerator.git"

# Python
sudo amazon-linux-extras install -y python3.8
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.8 get-pip.py
rm get-pip.py
# Selenium and urllib3
python3.8 -m pip install -r AttestationGenerator/requirements.txt

sudo -i << EOF
# Add a new user
adduser ec2-user
passwd ec2-user
P@$$word
P@$$word
# Add the user to sudoers
usermod -aG wheel ec2-user
# Add PYTHONPATH to sudo config
echo "export PYTHONPATH=/home/ec2-user/.local/lib/python3.8/site-packages" >> .bashrc
source .bashrc
echo 'Defaults    env_keep += "PYTHONPATH"' | sudo EDITOR='tee -a' visudo
echo 'Defaults    env_keep += "HOME"' | sudo EDITOR='tee -a' visudo
EOF

# Chromedriver
sudo wget https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/local/bin/chromedriver
sudo rm chromedriver_linux64.zip

# Google Chrome
sudo curl https://intoli.com/install-google-chrome.sh | bash
sudo mv /usr/bin/google-chrome-stable /usr/local/bin/google-chrome

# Update .bashrc
echo "export PATH=$PATH:/usr/local/bin" >> .bashrc
echo "alias python=python3.8" >> .bashrc
source /home/ec2-user/.bashrc

# Create Downloads directory
sudo mkdir Downloads
sudo chmod a+rwx Downloads

# Update locate
sudo updatedb

# In case
sudo chmod -R 777 AttestationGenerator
sudo chmod 777 /usr/local/bin/chromedriver
sudo chmod -R 777 /opt/google/chrome
sudo chmod 777 /usr/local/bin/google-chrome

# To run then
sudo python3.8 AttestationGenerator/src/main.py 'walk' 'Lucien' 'David' '24/11/1998' 'Poitiers' '130 allée des Chênes' 'Jard-sur-mer' '85520'
