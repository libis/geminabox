# Docker image of Gem in a Box

## Overview
[Geminabox](https://github.com/geminabox/geminabox) lets you host your own gems, and push new gems to it just like with rubygems.org.
This docker image include Geminabox on runtime of the latest [ruby:2.6-slim-buster](https://hub.docker.com/_/ruby).

## Usage

### Quick start
Do mapping local port to listening 9292 port on the container, which activate geminabox.
In order to open local port 8080 up to container, docker run command as follows.
```bash
docker run -d -p 8080:9292 libis/geminabox:latest
```
After executing the command, you can browse geminabox where http://localhost:8080.
<br>
Then, executing the follwing command enables gem networking your own geminabox.
```bash
gem sources -a http://localhost:8080/
```
Finally, you can upload or delete gems through browsing geminabox, and install gems by cli like as follows.
```bash
gem install GEM
```

### Options
Configure two environment variables activate basic authentication. Default inactive.
After activate Basic authentication, you need authentication when upload or delete gems.
#### `GEMSERVER_USER`
username for basic authentication.
#### `GEMSERVER_PASS`
password for basic authentication.
<br>
<br>
Docker run command as follows.
```bash
docker run -d -p 8080:9292 -e GEMSERVER_USER=username -e GEMSERVER_PASS=password libis/geminabox:latest
```
And in order to enabling auto authentication when you install gems on cli, you should run the command.
```bash
gem sources -a http://username:password@localhost:8080/
```

## Configurations

### persistent volume for gems
Gems are stored on the directory `/var/gems` on the geminabox container.
So, mount a directory on the host or a docker volume to `/var/gems`, gems persists.
For example, mount current directory,
```bash
docker run -d -p 8080:9292 -v $PWD/gems:/var/gems libis/geminabox:latest
```

### docker-compose.yml
Basic Authentication is activated and docker volume mounted to persist gems.
```yaml
version: '3.7'

services:
  geminabox:
    image: libis/geminabox:latest
    container_name: gemserver
    environment:
      - GEMSERVER_USER=username
      - GEMSERVER_PASS=password
    ports:
      - "8080:9292"
    restart: always
    volumes:
      - gems:/var/gems

volumes:
  gems:
```
