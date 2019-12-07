# Install ERPNext development Environment

## Install package dependencies

```sh
sudo apt install \
    docker \
    docker-compose \
    python3 \
    python3-pip \
    cron \
    libssl1.0-dev \
    xfonts-75dpi
    fonts-cantarell
```

## NodeJS LTS using NVM

```sh
# Install nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
source ~/.bashrc

# Install node lts
nvm install --lts

# Install yarn
npm install -g yarn
```

## Install wkhtmltopdf

```sh
wget -c https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb && rm wkhtmltox_0.12.5-1.bionic_amd64.deb
```

## Install Frappe Bench

```sh
# install bench python package
git clone https://github.com/frappe/bench ~/.bench
pip3 install --user -e ~/.bench

# set local path for user
echo -e "export PATH=\$HOME/.local/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
```

# Use frappe bench with dockerized backing service

## Create first frappe-bench

```sh
bench init \
    --python python3 \
    --skip-redis-config-generation \
    frappe-bench
```

## Start docker based services

```sh
# Clone repo with docker-compose.yml
cd $HOME
git clone <repo> && cd repo

# Copy example .env
cp env-example .env

# Start services
docker-compose up
```

## Setup bench procfile for using docker services

```sh
# For dockerized mariadb
bench config set-common-config --config db_host 127.0.0.1

# For developer mode
bench config set-common-config --config db_host 127.0.0.1

# setup procfile, if not already created
bench setup procfile

# To use Dockerized redis, comment first 3 lines of Procfile
sed -i '2,4 s/^/#/' Procfile
```

## Start the bench

```sh
bench start
```
