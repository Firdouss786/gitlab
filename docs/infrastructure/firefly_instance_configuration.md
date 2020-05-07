# Firefly Instance Configuration
The following is tested on AWS EC2 Ubuntu, 16.04 LTS


### Step 1. Configure Hostname
The hostname is not used for anything specifically, but helps to identify the environment while consoled into the instance

`sudo vim /etc/hostname` - Replace contents with `firefly-production`

`sudo vim /etc/hosts` – Add the line – `127.0.0.1 firefly-production`

`sudo reboot -h now`

### Step 2. Mount EBS
Lets mount the attached EBS drive, and create a directory to store firefly in `/mnt/apps`:

- `lsblk`
- `sudo mkfs.ext4 /dev/xvdb`
- `sudo mkdir /mnt/apps`
- `sudo mount /dev/xvdb /mnt/apps`

To ensure this mount is persisted, add it to the fstab:

`sudo vim /etc/fstab`

Insert – `/dev/xvdb    /mnt/apps    ext4    defaults, discard 0 0`

### Step 2.5 Associate Elastic IP
Needed to run apt-update

### Step 3. Install Ruby & Rails
Ruby is the language employed by Firefly, and Rails the MVC framework

Use this document to install ruby and rails:

[Install Ruby & Rails](install_ruby_and_rails.md)

### Step 4. Change owner of Firefly install directory
`sudo chown -R ubuntu:ubuntu /mnt/apps/`

### Step 5. Checkout source code from Github
All source code is in github

`cd /mnt/apps`

`git clone https://github.com/thalesinflyt/firefly.git`


### Step 6. Install Firefly dependencies
`cd firefly`

`bundle`

Add in master.key:
`scp -i /location/to/dev.pem /location/to/master.key ubuntu@10.0.26.51:/mnt/apps/firefly/config/master.key`

### Step 7. Create Database
`RAILS_ENV=production bundle exec rake db:create`


### Step 8. Configure Nginx
Nginx is used as the web server. It serves static assets (images, javascript, css) and also serves as a reverse-proxy to the rails server.
Replace the contents of `/etc/nginx/sites-available/default` with the following:
[Nginx Configuration](nginx_config.md)

Note: There must only be ONE file in `/etc/nginx/sites-available/`. The idea is that you can have multiple configurations in sites-available, and symlink one of them to sites-enabled which will be used by Nginx.

The commands to start / stop Nginx are:
- `sudo systemctl status nginx`
- `sudo systemctl start nginx`
- `sudo systemctl stop nginx`


### Step 9. Precompile Rails Assets
`cd /mnt/apps/firefly`

`RAILS_ENV=production bundle exec rails assets:precompile`


### Step 10. Create Puma Upstart Script
Firefly Puma Systemctl (Uptstart) -
[Puma Upstart Script](puma_upstart_script.md)


### Step 11. Import database
The database is a migration from the Servo database, and thus needs to go through a migration script.

You must first import the Servo 1 database, then run `rails db:migrate`


### Step 12. Setup SSH key
`ssh-keygen`



### Step 13. Install Yarn
`curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list`

`sudo apt-get update && sudo apt-get install yarn`

https://yarnpkg.com/lang/en/docs/install/#debian-stable

### Step 14. Install pv
`sudo apt-get install pv`


### Log Locations
`tail -f /var/log/nginx/error.log`


Useful Links
Encrypted Rails Credentials
https://www.engineyard.com/blog/rails-encrypted-credentials-on-rails-5.2
