# Install Frappe development Environment

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
brew services start mariadb

# Install Redis 
brew install redis
brew services start redis
```

### NodeJS LTS using NVM

With nvm, node is installed and used from local user directory and needs no root access.
Also dev machine may need different node versions for different projects.
Use nvm to install, manage and switch node versions for development.

```sh
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.zshrc
# If using bash use 'source ~/.bashrc'

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

mkdir frappe-projects && cd frappe-projects
virtualenv env --python=python3
source ./env/bin/activate

# install bench python package
git clone https://github.com/frappe/bench .bench
pip3 install -e ./.bench
```

# Use frappe bench

## Create first frappe-bench (e.g. frappe-bench-dev as a dedicated bench for development)

```sh
bench init \
    --python python3 \
    frappe-bench-dev
```

## Setup bench for using docker services

Note: execute command from bench directory e.g. `frappe-bench-dev` 

```sh
# For mariadb
bench config set-common-config --config db_host localhost

# For developer mode
bench config set-common-config --config developer_mode 1

# Setup procfile, if not already created
# bench setup procfile

# Create first site on bench (you can name this anything you like)
bench new-site default.local

# Set the active site to the one you've created
bench use default.local
```

## Start the bench

```sh
bench start
```
