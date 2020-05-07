### Step 1 - Create Systemctl script
`sudo vim /etc/systemd/system/puma.service`


`[Unit]
Description=Puma Rails Server
After=network.target
[Service]
Type=simple
User=ubuntu
WorkingDirectory=/mnt/apps/firefly_cap/current
ExecStart=/home/ubuntu/.rbenv/bin/rbenv exec bundle exec puma -e staging -C /mnt/apps/firefly_cap/current/config/puma.rb
ExecStop=/home/ubuntu/.rbenv/bin/rbenv exec bundle exec pumactl -S /mnt/apps/firefly_cap/current/tmp/pids/puma.state stop
TimeoutSec=15
Restart=always
[Install]
WantedBy=multi-user.target`


### Step 2. Enable the service to start on boot
`sudo systemctl enable puma`


### Step 3. Start Puma
`sudo systemctl start puma`

`sudo systemctl status puma`
