import os
import time

class FileryFolder:
    def __init__(self, path):
        self.path = path
        self.name = os.path.basename(path)
        self.itemCount = len(os.listdir(path))
        self.isMount = os.path.ismount(path)
        self.mtime = time.ctime(os.path.getmtime(path))
        self.ctime = time.ctime(os.path.getctime(path))
    
    def toJson(self):
        return {
            "name": self.name,
            "path": self.path,
            "itemCount": self.itemCount,
            "isMount": self.isMount,
            "mtime": self.mtime,
            "ctime": self.ctime
        }