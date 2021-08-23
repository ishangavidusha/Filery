from flask_jwt_extended import jwt_required
from src.models.filery_path import FileryPath
from flask import request
from flask_restful import Resource
import os
from pathlib import Path


class FileryDir(Resource):
    @jwt_required()
    def get(self):
        HOME = str(Path.home())
        try:
            pathObj = FileryPath(HOME)
            return {
                "msg": "",
                "data": pathObj.toJson()
            }, 200
        except Exception as e:
            return {
                "msg": str(e),
                "data": None
            }, 400
    
    @jwt_required()
    def post(self):
        body = request.get_json()
        if not body:
            return {
            "msg": "Request should contain json body",
            "data": None
        }, 400
        path = ""
        HOME = str(Path.home())
        if "path" in body and os.path.isdir(body["path"]):
            path = body["path"]
        else:
            path = HOME
        try:
            pathObj = FileryPath(path)
            return {
                "msg": "",
                "data": pathObj.toJson()
            }, 200
        except Exception as e:
            return {
                "msg": str(e),
                "data": ""
            }, 400