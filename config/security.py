import os
from datetime import timedelta
basedir = os.path.abspath(os.path.dirname(__file__))


class JWT(object):
    JWT_SECRET_KEY = str(os.environ.get("JWT_SECRET"))
    JWT_ACCESS_TOKEN_EXPIRES = timedelta(hours=1)
    JWT_REFRESH_TOKEN_EXPIRES = timedelta(days=30)
    JWT_BLACKLIST_ENABLED = True
    JWT_BLACKLIST_TOKEN_CHECKS = ['access', 'refresh']
