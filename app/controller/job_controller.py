from app.models.jobs import Job
from flask_jwt_extended import jwt_required
from flask import request
from flask_restful import Resource
import os
import uuid
from config.database import db


class TaskJob(Resource):
    @jwt_required()
    def get(self):
        try:
            data = [item.toJson() for item in Job.query.all()]
            return {
                'msg': "All Jobs",
                'data': data
            }, 200
        except Exception as e:
            return {
                'msg': str(e),
                'data': None
            }, 400
    
    @jwt_required()
    def post(self):  # sourcery skip: move-assign
        try:
            body = request.get_json()
            if not body:
                return {
                "msg": "Request should contain json body",
                "data": None
            }, 400
            job_type = body['job_type']
            # source and destination
            if job_type in ['copy', 'move']:
                source = body['source']
                destination = body['destination']
                command = 'rsync -aP'
                if os.path.isdir(source):
                    command += ' -r'
                elif not os.path.isfile(source):
                    return {
                        "msg": "Unknown sources or destination!",
                        "data": {
                            "error_code": "FTJ001",
                            "error_dis": "Source is not a file or directory"
                        }
                    }, 303
                if not os.path.isdir(destination):
                    return {
                        "msg": "Unknown sources or destination!",
                        "data": {
                            "error_code": "FTJ002",
                            "error_dis": "Destination is not a directory"
                        }
                    }, 303
                
                if os.path.isfile(source):
                    basename = os.path.basename(source)
                    ds_file = os.path.join(destination, basename)
                    if os.path.exists(ds_file) and not body['replace']:
                        return {
                            "msg": "File already exists!",
                            "data": {
                                "error_code": "FTJ003",
                                "error_dis": "File already exists in the destination"
                            }
                        }, 303
                
                job = Job(id=str(uuid.uuid4()), job_type=body['job_type'], command=command, source=source, destination=destination)

                db.session.add(job)
                db.session.commit()
                
                return {
                    "msg": "Data added successfully!",
                    "data": job.toJson()
                }, 200


        except Exception as e:
            return {
                'sucsess': False, 
                'msg': str(e), 
                'data': None
            }, 400