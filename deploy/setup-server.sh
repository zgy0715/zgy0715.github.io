#!/usr/bin/env bash
# 腾讯云轻量服务器（Ubuntu 24.04）一次性初始化：nginx 托管 Astro 静态站
# 用法：把本脚本传到服务器后执行  bash setup-server.sh
set -euo pipefail

WEB_ROOT=/var/www/yzbzgy

sudo apt update
sudo apt install -y nginx rsync

sudo mkdir -p "$WEB_ROOT"
sudo chown -R "$USER":www-data "$WEB_ROOT"

sudo tee /etc/nginx/sites-available/yzbzgy >/dev/null <<'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    root /var/www/yzbzgy;
    index index.html;

    # Astro 静态站：/xxx/ → /xxx/index.html
    location / { try_files $uri $uri/ $uri/index.html =404; }

    # 自制 404 页（构建产物自带）
    error_page 404 /404.html;

    # 带内容哈希的静态资源：长缓存
    location /_astro/ { expires 30d; add_header Cache-Control "public, immutable"; }
    location /fonts/  { expires 30d; add_header Cache-Control "public, immutable"; }

    gzip on;
    gzip_comp_level 5;
    gzip_types text/css application/javascript application/json image/svg+xml application/rss+xml text/xml;
}
EOF

sudo ln -sf /etc/nginx/sites-available/yzbzgy /etc/nginx/sites-enabled/yzbzgy
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl enable --now nginx
sudo systemctl reload nginx

echo ""
echo "✅ nginx 就绪，站点根目录：$WEB_ROOT"
echo "⚠️  别忘了去腾讯云控制台 → 轻量应用服务器 → 防火墙，放行 TCP 80 端口"
echo "⚠️  以后如果域名备好了：把 server_name 改成域名，再跑 certbot --nginx -d 域名 上 HTTPS"
