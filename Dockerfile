 FROM ubuntu:20.04

# 1. 设置非交互式环境和时区
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

# 2. 使用阿里云镜像源加速
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list


# 安装 Python 和 Nginx（用于托管前端）
RUN apt update && \
    apt install -y python3 python3-pip nginx && \
    rm -rf /var/lib/apt/lists/*


# 3. 安装基础工具（改用 pip 安装 Ansible）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    ssh \
    && pip3 install --no-cache-dir ansible -i https://mirrors.aliyun.com/pypi/simple/ \
    && rm -rf /var/lib/apt/lists/*

# 4. 配置工作目录
WORKDIR /app

COPY backend/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

# 5. 复制代码
COPY . .
COPY backend /app
COPY static /app/static
COPY templates /app/templates
COPY network_scan.sh /app/
RUN chmod +x /app/network_scan.sh

# 配置 Nginx
RUN rm /etc/nginx/sites-enabled/default && \
    echo "server { \
        listen 80; \
        root /app/templates; \
        index index.html; \
        location /api { \
            proxy_pass http://localhost:5000; \
        } \
    }" > /etc/nginx/sites-enabled/app.conf

# 6. 配置 Ansible
RUN mkdir -p /etc/ansible && \
    echo "[all]\nlocalhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3" > /etc/ansible/hosts

# 7. 复制前端
COPY templates /app/templates

EXPOSE 80 5000

# 启动脚本（同时运行 Flask 和 Nginx）
CMD service nginx start && \
    python3 /app/backend/app.py
