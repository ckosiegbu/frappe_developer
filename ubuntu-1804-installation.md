# Install Frappe development Environment

## Install package dependencies Ubuntu

```sh
# Update repo and packages
sudo apt update && sudo apt -y dist-upgrade

# Install Docker
sudo apt install -y docker docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
# After addition of user logout
# or if setup is on VM reboot the VM

# Install Python 3 and pip3
sudo apt install -y python3 python3-pip

# Install Cron
sudo apt install -y cron

# Install MariaDB client
sudo apt install mariadb-client
```

### NodeJS LTS using NVM

With nvm, node is installed and used from local user directory and needs no root access.
Also dev machine may need different node versions for different projects.
Use nvm to install, manage and switch node versions for development.

```sh
# Install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc

# Install node lts
nvm install --lts

# Install yarn
npm install -g yarn
```

### Install wkhtmltopdf

```sh
# install wkhtmltopdf dependencies
sudo apt install -y \
    xfonts-base \
    xfonts-75dpi \
    fonts-cantarell \
    libssl1.0-dev \
    libxrender1 \
    libjpeg-turbo8

# Download, install and remove deb package
wget -c https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb && rm wkhtmltox_0.12.5-1.bionic_amd64.deb
```

## Install package dependencies MACOS

```sh
# Install Docker
Install docker by following the instructions at the following link:
```
https://docs.docker.com/docker-for-mac/install/

```sh
# Install Python 3 and pip3
brew install python3

# Install MariaDB client
brew install mariadb
```

### NodeJS LTS using NVM

With nvm, node is installed and used from local user directory and needs no root access.
Also dev machine may need different node versions for different projects.
Use nvm to install, manage and switch node versions for development.

```sh
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc

# Install node lts
nvm install --lts

# Install yarn
npm install -g yarn
```

### Install wkhtmltopdf

```sh
brew cask install wkhtmltopdf
```

## Install Frappe Bench

```sh
# create a frappe development folder and install virtual environment
pip3 install virtualenvwrapper 

mkdir frappe-development
cd frappe-development
virtualenv env --python=python3
source ./env/bin/activate

# install bench python package
git clone https://github.com/frappe/bench .bench
pip3 install -e ./.bench
```

# Use frappe bench with dockerized backing service

## Create first frappe-bench (assuing the name is frappe-bench-dev)

```sh
bench init \
    --python python3 \
    --skip-redis-config-generation \
    frappe-bench-dev
```

## Start docker based services

```sh
# Clone repo with docker-compose.yml
cd $HOME
git clone https://github.com/ckosiegbu/frappe_developer/frappe_developer.git && cd frappe_developer

# Copy example .env
cp env-example .env

# Start services
docker-compose --project-name bench up
```

## Setup bench for using docker services

Note: execute command from bench directory e.g. `frappe-bench-01`

```sh
# For dockerized mariadb
bench config set-common-config --config db_host 127.0.0.1

# For developer mode
bench config set-common-config --config developer_mode 1

# setup procfile, if not already created
# bench setup procfile

# To use Dockerized redis, comment first 3 redis lines of Procfile
sed -i '1,3 s/^/#/' Procfile
```

## Start the bench

```sh
bench start
```
