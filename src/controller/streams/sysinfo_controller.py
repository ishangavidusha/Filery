import json
from flask import Response
from src.utils.sys_info_data import sysInfo

def getSysInfoStream():
    def getData():
        try:
            while True:
                data = sysInfo()
                sys_info = json.dumps({
                    "success": True,
                    "msg": "",
                    "sys_info": data
                })
                yield f"id: 1\ndata: {sys_info}\nevent: message\n\n"

        except Exception as e:
            sys_info = json.dumps({
                "success": False,
                "msg": str(e),
                "sys_info": None 
            })

            yield f"id: 1\ndata: {sys_info}\nevent: message\n\n"

    return Response(getData(), mimetype='text/event-stream')