server {
  listen       80;
  listen  [::]:80;
  server_name  www.walktocircle.com;
  return       301 http://walktocircle.com$request_uri;
}

server {
  listen       80;
  listen  [::]:80;
  server_name  walktocircle.com;
  root         /home/ubuntu/web/walktocircle.com;
  access_log   /var/log/nginx/walktocircle.log combined;

  # static content
  location ~ \.(?:ico|jpg|css|png|js|swf|woff|eot|svg|ttf|gif)$ {
    access_log  off;
    log_not_found off;
    add_header  Pragma "public";
    add_header  Cache-Control "public";
    expires     7d;
  }
}