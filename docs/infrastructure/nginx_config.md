upstream firefly {
  server 0.0.0.0:3000;
}
server {
  listen 80;
  server_name firefly.staging.topcareife.com;
  root /mnt/apps/firefly_cap/current/public;
  if ($http_x_forwarded_proto != "https") {
    rewrite ^(.*)$ https://$host$1 permanent;
  }
  try_files $uri/index.html $uri.html @firefly;
  location ~ ^/(assets|packs)/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }
  location @firefly {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://firefly;
  }
}
