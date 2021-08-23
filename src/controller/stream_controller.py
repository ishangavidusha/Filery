from sqlalchemy import update
import subprocess
import json
import time
from config.database import db
from flask import Response, request
from src.utils.rsync_progress import getRsyncProgress
from src.models.jobs import Job

def jobProgressStream():
    def streamData():
        try:
            job_id = request.args.get('job_id')
            if not job_id:
                return json.dumps({
                    "jobType": "copy",
                    "jobDone": False,
                    "msg": "No job id!",
                    "progress": {
                        "isProgress": False
                    },
                    "success": False,
                    "returncode": 1
                })
            
            job = Job.query.filter_by(job_id=job_id).first()

            if not job:
                return json.dumps({
                    "jobType": "unknown",
                    "jobDone": False,
                    "msg": "Invalid job id!",
                    "progress": {
                        "isProgress": False
                    },
                    "success": False,
                    "returncode": 1
                })
            
            stmt = update(job).where(job_id=job_id).values(executed=True)
            db.session.execute(stmt)
            fullCommand = job.command.split(" ")
            fullCommand.append(job.source)
            fullCommand.append(job.destination)
            process = subprocess.Popen(fullCommand, stdout=subprocess.PIPE, text=True)
            while True:
                output = process.stdout.readline()
                if output:
                    data = json.dumps({
                        "jobType": "copy",
                        "jobDone": False,
                        "msg": "Progressing Task...",
                        "progress": getRsyncProgress(output.strip()),
                        "success": False,
                        "returncode": 0
                    })
                    yield f"id: 1\ndata: {data}\nevent: message\n\n"
                result = process.poll()
                if result is not None:
                    data = json.dumps({
                        "jobType": "copy",
                        "jobDone": True,
                        "msg": "Task Done!",
                        "progress": {
                            "isProgress": False,
                        },
                        "success": process.returncode == 0,
                        "returncode": process.returncode
                    })
                    yield f"id: 1\ndata: {data}\nevent: message\n\n"
                    break
                time.sleep(0.5)

        except Exception as e:
            data = json.dumps({
                "jobType": "copy",
                "jobDone": False,
                "msg": str(e),
                "progress": {
                    "isProgress": False
                },
                "success": False,
                "returncode": 1
            })

            yield f"id: 1\ndata: {data}\nevent: message\n\n"
    


    return Response(streamData(), mimetype='text/event-stream')


    