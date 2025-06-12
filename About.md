# Ansible 运维控制台

## 项目简介
本系统是基于 Docker 和 Ansible 的自动化运维平台，提供：
- 主机状态实时监控
- 网络设备自动发现
- 运维任务可视化操作
- 数据大屏展示

## 技术栈
- **容器技术**: Docker
- **自动化运维**: Ansible
- **后端框架**: Flask
- **前端技术**: HTML5 + Chart.js
- **网络探测**: Shell 脚本

## 系统功能
✅ 主机状态检测  
✅ 网络设备扫描  
✅ 主机动态管理  
✅ 数据可视化展示  
✅ Docker 容器化部署  

## 使用说明
```bash
# 构建镜像
docker build -t ansible-dashboard .

# 运行容器
docker run -d -p 5000:5000 -p 8080:80 --name ansible-dashboard ansible-dashboard

# 访问界面
http://localhost:8080
项目结构
text
ansible_dashboard/
├── Dockerfile             # 容器配置
├── backend/               # 后端代码
│   ├── app.py             # Flask主程序
│   └── requirements.txt   # Python依赖
├── templates/             # 前端页面
│   └── index.html         
└── network_scan.sh        # 网络探测脚本
开发团队
姓名：XXX

学号：XXXXXXXX

课程：Docker容器技术与自动化运维技术

日期：2025年6月

text

### 提交到 GitHub 的步骤：
1. 在本地项目根目录创建 `ABOUT.md` 文件
2. 添加提交：
   ```bash
   git add ABOUT.md
   git commit -m "添加项目说明文档"
   git push origin main
最终 GitHub 仓库效果：
https://docs.github.com/assets/cb-29243/images/help/repository/repo-about-page.png

最佳实践建议：
同时使用两种方法：

在仓库设置中添加简短描述

在 ABOUT.md 中添加详细说明

添加 README.md（如果还没有）：

markdown
# Ansible 运维控制台
[![Docker](https://img.shields.io/badge/Docker-✓-blue)]()
[![Ansible](https://img.shields.io/badge/Ansible-✓-red)]()

> 基于 Docker 的 Ansible 自动化运维平台

## 快速开始
```bash
docker build -t ansible-dashboard .
docker run -d -p 8080:80 --name dashboard ansible-dashboard
访问地址
http://192.168.44.138:8080



作者信息
姓名：黄汇翔 黄梓峰 邓睿研
学号：2240668119 2240668140 2240668114
课程：Docker容器技术与自动化运维技术
日期：2025年6月
