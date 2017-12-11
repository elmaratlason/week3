#!/bin/bash
# used to install needed tools on local machine
# Háskólinn í Reykjavík - 2017
# elmar.atlason@gmail.com / elmar14@ru.is

sudo npm install -g nodemon
sudo npm install -g create-react-app
sudo npm run startpostgres && sleep 10 && npm run migratedb
npm install

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

# install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
