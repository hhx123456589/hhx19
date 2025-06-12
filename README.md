1. 构建 Docker 镜像
bash
docker build -t ansible-dashboard .
2. 运行容器
bash
docker run -d -p 5000:5000 -p 8080:80 --name ansible-dashboard ansible-dashboard
3. 访问服务
前端页面: http://localhost:8080

后端API: http://localhost:5000/api/ansible/ping

项目结构
bash
ansible_dashboard/
├── Dockerfile             # 容器构建配置
├── backend/
│   ├── app.py             # Flask 主程序
│   └── requirements.txt   # Python 依赖
├── templates/
│   └── index.html         # 前端页面
└── network_scan.sh        # 网络探测脚本
接口文档
1. Ansible Ping 检测
端点: GET /api/ansible/ping

响应:

json
{
  "output": "localhost | SUCCESS => {...}",
  "success": true
}
2. 网络扫描
端点: GET /api/network/scan

功能: 扫描局域网活动主机

3. 添加主机
端点: POST /api/hosts/add

参数:

json
{"host": "192.168.1.100"}
使用指南
主机状态检测：

点击"检测主机状态"按钮

查看饼图显示在线/离线比例

主机列表实时更新状态

添加新主机：

在输入框输入 IP 地址

点击"添加主机"按钮

系统将自动更新 Ansible hosts 文件

网络扫描：

点击"扫描网络"按钮

系统自动探测局域网设备

扫描结果将显示在日志区域

常见问题
Q: 如何进入容器内部调试？
A: 使用命令：

bash
docker exec -it ansible-dashboard /bin/bash
Q: 如何查看实时日志？
A: 使用命令：

bash
docker logs -f ansible-dashboard
Q: 如何修改 Ansible 配置？
A: 容器内配置文件路径：
/etc/ansible/hosts

