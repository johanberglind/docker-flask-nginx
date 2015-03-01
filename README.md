# Docker - nginxflask

This repo hosts a Dockerimage for running your flask application using gunicorn and nginx as a reverse proxy.

## Building the image:
`sudo docker build -t johanberglind/nginflask .`

## Running the image:
`sudo docker run -d -v /flask_app_folder:/app -p 80:80 -t johanberglind/nginflask`

## License:
See LICENSE file

## TODOS:
Currently this image is missing options to inject dependencies during runtime, I don't really like the idea that python's dependencies are installed during the build of the dockerimage. If you know a good way to do this, submit a pull request!


