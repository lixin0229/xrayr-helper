#!/bin/bash

CONFIG_FILE="/etc/XrayR/config.yml"
BACKUP_FILE="/etc/XrayR/config.yml.bak"

# 检查文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
    echo "配置文件 $CONFIG_FILE 不存在！"
    exit 1
fi

# 备份原始文件
cp "$CONFIG_FILE" "$BACKUP_FILE"
echo "已备份原始配置文件到 $BACKUP_FILE"

# 默认值
DEFAULT_API_HOST="https://v2.shihao520.top"
DEFAULT_API_KEY="t3ZYQBBXu8cmmJV7s7xJ"
NODE_TYPE_OPTIONS=("V2ray" "Vmess" "Vless" "Shadowsocks" "Trojan" "Shadowsocks-Plugin")

# 获取用户输入
read -p "请输入 ApiHost [$DEFAULT_API_HOST]: " api_host
api_host=${api_host:-$DEFAULT_API_HOST}

read -p "请输入 ApiKey [$DEFAULT_API_KEY]: " api_key
api_key=${api_key:-$DEFAULT_API_KEY}

while true; do
  read -p "请输入 NodeID (必须输入): " node_id
  [[ -n "$node_id" ]] && break
  echo "NodeID 不能为空，请重新输入。"
done

echo "可选 NodeType: ${NODE_TYPE_OPTIONS[*]}"
while true; do
  read -p "请输入 NodeType: " node_type
  if [[ " ${NODE_TYPE_OPTIONS[*]} " == *" $node_type "* ]]; then
    break
  else
    echo "无效 NodeType，请选择: ${NODE_TYPE_OPTIONS[*]}"
  fi
done

# 使用 sed 修改配置文件
sed -i "s|^\(\s*ApiHost:\s*\).*|\1\"$api_host\"|" "$CONFIG_FILE"
sed -i "s|^\(\s*ApiKey:\s*\).*|\1\"$api_key\"|" "$CONFIG_FILE"
sed -i "s|^\(\s*NodeID:\s*\).*|\1$node_id|" "$CONFIG_FILE"
sed -i "s|^\(\s*NodeType:\s*\).*|\1$node_type|" "$CONFIG_FILE"

echo "配置文件已更新成功。"
