### Update Packages
`sudo apt-get update`

### Install NGINX
`sudo apt-get install curl git-core nginx -y`

### Install Ruby Dependencies
`sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libmysqlclient-dev libpq-dev`

### Install rbenv
`git clone https://github.com/rbenv/rbenv.git ~/.rbenv`

`echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc`

`echo 'eval "$(rbenv init -)"' >> ~/.bashrc`

`source ~/.bashrc`

### Install rbenv build
`git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build`

`rbenv install 2.5.0`

`rbenv global 2.5.0`

### Install bundler
`echo "gem: --no-document" > ~/.gemrc`

`gem install bundler`

### Install Rails
`gem install rails -v 5.2.0`

### Install JavaScript Runtime
`cd /tmp`

`curl -sSL https://deb.nodesource.com/setup_6.x -o nodejs.sh`

`cat /tmp/nodejs.sh | sudo -E bash -`

`sudo apt-get install -y nodejs`
