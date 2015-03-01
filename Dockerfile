FROM ubuntu:trusty
MAINTAINER Johan Berglind <johan@berglind.me>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y nginx python python-pip python-virtualenv gunicorn supervisor && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/lib/nginx && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -p /app

ADD run.sh /run.sh
RUN chmod 755 /run.sh

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD nginx_flask /etc/nginx/sites-available/nginx_flask
RUN rm /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/nginx_flask /etc/nginx/sites-enabled/nginx_flask

ADD flask_supervisor.conf /etc/supervisor/conf.d/flask_supervisor.conf
ADD nginx_supervisor.conf /etc/supervisor/conf.d/nginx_supervisor.conf

EXPOSE 80
EXPOSE 443

CMD supervisord -n