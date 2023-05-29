#source: https://github.com/benoitc/gunicorn/blob/master/examples/example_config.py
import multiprocessing
bind = '0.0.0.0:8000'
backlog = 2048
workers = multiprocessing.cpu_count() * 2 + 1
worker_connections = 1000
timeout = 300
graceful_timeout = 60
keepalive = 5
keyfile = '/var/www/ssl/server.key'
certfile = '/var/www/ssl/server.crt'
