from flask import Flask
from config.database import Config, db
from config.security import JWT
from flask_jwt_extended import JWTManager, jwt_required
from dotenv import load_dotenv
from flask_cors import CORS
from flask_restful import Api
from time import sleep

flaskApp = Flask(__name__, static_folder='public/build/web', static_url_path='/')
api = Api(flaskApp)
load_dotenv()
flaskApp.config.from_object(Config)
flaskApp.config.from_object(JWT)
jwt = JWTManager(flaskApp)
cors = CORS(flaskApp)

from app.controller.user_controller import Login, Refresh, IsUser, SuperAdmin
from app.controller.stream_controller import jobProgressStream
from app.controller.streams.sysinfo_controller import getSysInfoStream
from app.controller.directory_controller import FileryDir
from app.controller.download_controller import Download
from app.controller.job_controller import TaskJob


db.init_app(flaskApp)

@flaskApp.route('/')
def home():
    return flaskApp.send_static_file('index.html')


@flaskApp.route('/api/stream', methods=['GET'])
def get_user():
    return jobProgressStream()

@flaskApp.route('/api/sysinfo', methods=['GET'])
def get_sys():
    return getSysInfoStream()

api.add_resource(Login, '/api/v1/auth/login')
api.add_resource(Refresh, '/api/v1/auth/refresh-token')
api.add_resource(SuperAdmin, '/api/v1/auth/signup')
api.add_resource(IsUser, '/api/v1/auth/isuser')
api.add_resource(FileryDir, '/api/dir')
api.add_resource(Download, '/api/download')
api.add_resource(TaskJob, '/api/task')

 
if __name__ == "__main__":
    flaskApp.run()