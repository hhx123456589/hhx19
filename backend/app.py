from flask import Flask, send_from_directory
from flask import Flask, jsonify, request
from flask import render_template
import subprocess
from flask_cors import CORS  # 解决跨域问题

app = Flask(__name__)
CORS(app)  # 允许所有跨域请求（开发环境用，生产环境需配置具体域名）

@app.route('/api/ansible/ping', methods=['GET'])
def ansible_ping():
    """执行 ansible ping 测试"""
    try:
        result = subprocess.run(
            ['ansible', 'all', '-m', 'ping'],
            capture_output=True,
            text=True
        )
        return jsonify({
            'success': True,
            'output': result.stdout,
            'error': result.stderr
        })
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

@app.route('/api/hosts/add', methods=['POST'])
def add_host():
    """添加主机到 Ansible inventory"""
    host = request.json.get('host')
    if not host:
        return jsonify({'success': False, 'error': 'Host IP required'})
    
    try:
        with open('/etc/ansible/hosts', 'a') as f:
            f.write(f"\n{host} ansible_connection=ssh ansible_user=root")
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/')
def home():
    return send_from_directory('templates', 'index.html')  # 确保有 templates/index.html 文件

from flask import Flask, send_from_directory

app = Flask(__name__, static_folder='../static')  # 指向static目录

@app.route('/static/<path:filename>')
def static_files(filename):
    return send_from_directory(app.static_folder, filename)
