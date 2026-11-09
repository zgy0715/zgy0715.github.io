#!/usr/bin/env bash
# 腾讯云轻量服务器（Ubuntu 24.04）：把个人网站加为独立站点，不影响已有项目
# 用法：bash setup-server.sh [端口]   默认 8080
# 安全设计：不占用 80、不设 default_server、不删除任何已有站点配置
set -euo pipefail

WEB_ROOT=/var/www/yzbzgy
PORT="${1:-8080}"

# 端口占用预检
if ss -tln | grep -q ":${PORT} "; then
  echo "❌ 端口 ${PORT} 已被占用。换一个端口重试，例如：bash setup-server.sh 9090"
  ss -tlnp | grep LISTEN | head -10
  exit 1
fi

sudo apt update
sudo apt install -y nginx rsync

sudo mkdir -p "$WEB_ROOT"
sudo chown -R "$USER":www-data "$WEB_ROOT"

# 写站点配置（__PORT__ 占位符后面替换，避免 heredoc 展开 $uri 等 nginx 变量）
sudo tee /etc/nginx/sites-available/yzbzgy >/dev/null <<'EOF'
server {
    listen __PORT__;
    listen [::]:__PORT__;
    server_name _;
    root __WEB_ROOT__;
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

sudo sed -i "s/__PORT__/${PORT}/; s|__WEB_ROOT__|${WEB_ROOT}|" /etc/nginx/sites-available/yzbzgy

sudo ln -sf /etc/nginx/sites-available/yzbzgy /etc/nginx/sites-enabled/yzbzgy
sudo nginx -t
sudo systemctl enable --now nginx
sudo systemctl reload nginx

echo ""
echo "✅ 个人网站已挂到 ${PORT} 端口（独立 server 块，未动任何已有站点）"
echo "⚠️  去腾讯云控制台 → 轻量应用服务器 → 防火墙，放行 TCP ${PORT}"
echo "🌐 访问地址：http://服务器公网IP:${PORT}"
echo "已有项目不受影响；以后想换端口，改 /etc/nginx/sites-available/yzbzgy 后 systemctl reload nginx"
