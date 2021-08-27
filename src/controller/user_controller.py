from src.models.user import SecUsers
from config.database import db
from flask import request
from flask_jwt_extended import create_refresh_token, create_access_token, jwt_required, get_jwt_identity
from flask_restful import Resource
import uuid


class Login(Resource):
    def post(self):
        try:
            body = request.get_json()
            if not body:
                return {
                "msg": "Request should contain json body",
                "data": None
            }, 400
            username = body['username']
            password = body['password']

            user = SecUsers.query.filter_by(username=username).first()

            if not user:
                return {
                    'msg': "Incorrect Username or Password!",
                    'data': None
                }, 400

            if not user.checkPassword(password):
                return {
                    'msg': "Incorrect Username or Password!",
                    'data': None
                }, 400

            data = {'id': user.id, 'username': user.username, 'fullName': user.full_name}

            access_token = create_access_token(data)
            refresh_token = create_refresh_token(data)
            return {
                'msg': "Login successful",
                'data': {
                    'user': data,
                    'access_token': access_token,
                    'refresh_token': refresh_token
                }
            }, 200
        except Exception as e:
            return {
                'msg': str(e),
                'data': None
            }, 400


class Refresh(Resource):
    @jwt_required(refresh=True)
    def get(self):
        try:
            identity = get_jwt_identity()
            access_token = create_access_token(identity=identity)
            response = {
                'msg': "New Access Token",
                'data': {
                    "access_token": access_token
                }
            }
            return response, 200
        except Exception as e:
            return {
                'msg': str(e),
                'data': None
            }, 400


class SuperAdmin(Resource):
    def post(self):  # sourcery skip: extract-method
        try:
            body = request.get_json()
            if not body:
                return {
                "msg": "Request should contain json body",
                "data": None
            }, 400
            full_name = body['full_name']
            username = body['username']
            password = body['password']

            user = SecUsers.query.filter_by(username=username).first()

            if user:
                return {
                    'msg': "User already exists!",
                    'data': None
                }, 400

            data = [{
                'username': username,
                'full_anme': full_name
            }]

            user = SecUsers(id=str(uuid.uuid4()), full_name=full_name, username=username)
            user.setPassword(password)
            db.session.add(user)
            db.session.commit()

            return {
                "msg": "Data added successfully!",
                "data": data
            }, 200

        except Exception as e:
            return {
                "msg": str(e),
                "data": None
            }, 400

class IsUser(Resource):
    def post(self):
        try:
            body = request.get_json()
            if not body:
                return {
                "msg": "Request should contain json body",
                "data": None
            }, 400

            id = body["userId"]

            data = SecUsers.query.filter_by(id=id).first() if id else None
            all_user = SecUsers.query.all()

            result = {
                'msg': "User is available" if data else "User is not available",
                'data': {
                    'current_user': bool(data),
                    'user_count': len(all_user)
                },
            }

            return result, 200

        except Exception as e:
            return {'msg': str(e), 'data': None}, 400