#!/bin/bash

# 探测当前网络
NETWORK=$(ip route | awk '/default/ {print $3}' | cut -d'.' -f1-3)
START_IP=1
END_IP=254

echo "探测网络: ${NETWORK}.0/24"

# 创建临时hosts文件
echo "[all]" > /tmp/ansible_hosts.tmp

for i in $(seq $START_IP $END_IP); do
    IP="${NETWORK}.${i}"
    if ping -c 1 -W 1 $IP &> /dev/null; then
        echo "$IP ansible_connection=ssh ansible_user=root" >> /tmp/ansible_hosts.tmp
        echo "发现主机: $IP"
    fi
done

# 更新Ansible hosts文件
cp /tmp/ansible_hosts.tmp /etc/ansible/hosts
echo "Ansible hosts文件已更新"#!/bin/bash
echo "Network scan placeholder"
