import os
import mimetypes
import time

class FileryFile:
    def __init__(self, path):
        self.path = path
        self.name = os.path.basename(path)
        self.size = os.path.getsize(path) if not os.path.islink(path) else 0
        self.type = mimetypes.guess_type(path, strict=True)
        self.isLink = os.path.islink(path)
        self.extention = os.path.splitext(path)[1]
        self.mtime = time.ctime(os.path.getmtime(path)) if not os.path.islink(path) else ""
        self.ctime = time.ctime(os.path.getctime(path)) if not os.path.islink(path) else ""

    def toJson(self):
        return {
            "name": self.name,
            "path": self.path,
            "size": self.size,
            "type": self.type,
            "isLink": self.isLink,
            "ext": self.extention,
            "mtime": self.mtime,
            "ctime": self.ctime
        }