#!/bin/bash

CONFIG_FILE="$HOME/.ssh/config"

# 추가할 설정 블록
read -r -d '' BLOCK <<'EOF'
Host s1 s2 s3
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
EOF

# 설정이 이미 포함되어 있는지 확인하고 없으면 추가
if ! grep -q "Host s1 s2 s3" "$CONFIG_FILE" 2>/dev/null; then
    echo ">> Adding SSH config for s1, s2, s3"
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    echo -e "\n$BLOCK" >> "$CONFIG_FILE"
    chmod 600 "$CONFIG_FILE"
else
    echo ">> SSH config for s1, s2, s3 already exists"
fi
