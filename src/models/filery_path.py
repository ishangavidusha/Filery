import os
from src.models.filery_file import FileryFile
from src.models.filery_folder import FileryFolder
import shutil


class FileryPath:
    def __init__(self, current):
        self.currentPath = current
        self.goBackPath = os.path.split(current)[0]
        self.directories = []
        self.files = []
        self.diskUsage = shutil.disk_usage(current)
        self.scanDir()

    def scanDir(self):
        if self.currentPath != None:
            fileList = os.listdir(self.currentPath)
            self.directories = []
            self.files = []
            for item in fileList:
                if os.path.isdir(os.path.join(self.currentPath, item)):
                    self.directories.append(FileryFolder(os.path.join(self.currentPath, item)))
                else:
                    self.files.append(FileryFile(os.path.join(self.currentPath, item)))

    def toJson(self):
        return {
            "currentPath" : self.currentPath,
            "goBackPath" : self.goBackPath,
            "directories": [item.toJson() for item in self.directories],
            "files": [item.toJson() for item in self.files],
            "diskUsage": self.diskUsage
        }