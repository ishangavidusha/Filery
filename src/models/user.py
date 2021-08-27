from datetime import datetime
from config.database import db
from werkzeug.security import generate_password_hash, check_password_hash


class SecUsers(db.Model):
    id = db.Column(db.String(100), primary_key=True)
    full_name = db.Column(db.String(250), nullable=True)
    username = db.Column(db.String(250), index=True, unique=True, nullable=False)
    password = db.Column(db.String(250), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    def __repr__(self):
        return '<SecUsers {}>'.format(self.name)

    def setPassword(self, password):
        self.password = generate_password_hash(password)

    def checkPassword(self, password):
        return check_password_hash(self.password, password)
