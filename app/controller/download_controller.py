from flask import request, send_from_directory, jsonify, make_response
from flask_restful import Resource
from flask_jwt_extended import jwt_required
import os

class Download(Resource):
    @jwt_required()
    def post(self):
        body = request.get_json()
        if not body:
            return {
            "msg": "Request should contain json body",
            "data": None
        }, 400
        if "filePath" in body and os.path.isfile(body["filePath"]):
            return send_from_directory(os.path.split(body["filePath"])[0], os.path.abspath(body["filePath"]), os.path.basename(body["filePath"]), as_attachment=True)
        else:
            return make_response(jsonify({
                "msg": "File not found!",
                "data": None
            })), 404