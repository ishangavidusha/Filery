from src.utils.sys_info_data import sysInfo
from flask import Flask
from config.database import Config, db
from config.security import JWT
from flask_jwt_extended import JWTManager
from dotenv import load_dotenv
from flask_cors import CORS
from flask_restful import Api
from flask_socketio import SocketIO, send, emit
from time import sleep

app = Flask(__name__, static_folder='public/build/web', static_url_path='/')
api = Api(app)
load_dotenv()
app.config.from_object(Config)
app.config.from_object(JWT)
jwt = JWTManager(app)
cors = CORS(app)

from src.controller.user_controller import Login, Refresh, IsUser, SuperAdmin
from src.controller.stream_controller import jobProgressStream
from src.controller.streams.sysinfo_controller import getSysInfoStream
from src.controller.directory_controller import FileryDir
from src.controller.download_controller import Download
from src.controller.job_controller import TaskJob


db.init_app(app)
socketio = SocketIO(app, cors_allowed_origins="*")

@app.route('/')
def home():
    return app.send_static_file('index.html')

# Socket.io Start Here
# To Enable WebSocket Transport Use gunicorn (debug > --reload)
# gunicorn --worker-class eventlet -w 1 --reload --bind 0.0.0.0:5000 server:app

@socketio.on('connect')
def test_connect(data):
    print('Client Connected!')
    

@socketio.on('disconnect')
def test_disconnect():
    print('Client disconnected!')

@socketio.on('sysdata')
def test_disconnect(data):
    print(f'Got Some Data From Client: {data}')
    while True:
        data = {
            "msg": "Server, System Infomation",
            "info": sysInfo()
        }
        emit("sysdata", data)
        sleep(1)

@app.route('/api/stream', methods=['GET'])
def get_user():
    return jobProgressStream()

@app.route('/api/sysinfo', methods=['GET'])
def get_sys():
    return getSysInfoStream()

api.add_resource(Login, '/api/v1/auth/login')
api.add_resource(Refresh, '/api/v1/auth/refresh-token')
api.add_resource(SuperAdmin, '/api/v1/auth/signup')
api.add_resource(IsUser, '/api/v1/auth/isuser')
api.add_resource(FileryDir, '/api/v1/browse')
api.add_resource(Download, '/api/v1/download')
api.add_resource(TaskJob, '/api/v1/task')

 
if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    socketio.run(app, debug=True)