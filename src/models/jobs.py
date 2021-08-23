from config.database import db
from datetime import datetime

class Job(db.Model):
    id = db.Column(db.String(100), primary_key=True)
    job_type = db.Column(db.String(50), nullable=False)
    command = db.Column(db.String(100), nullable=False)
    source = db.Column(db.String(250), nullable=False)
    destination = db.Column(db.String(250), nullable=False)
    executed = db.Column(db.Boolean, nullable=False, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    def __repr__(self) -> str:
        return '<Job {}>'.format(self.job_type)
    
    def setExecuted(self, value):
        self.executed = value
    
    def toJson(self):
        return {
            "id": self.id,
            "job_type": self.job_type,
            "command": self.command,
            "source": self.source,
            "destination": self.source,
            "executed": self.executed,
            "created_at": self.created_at.isoformat()
        }