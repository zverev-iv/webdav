# Angie Webdav Image

## Reference

angie: https://angie.software/en/

angie dav module: https://angie.software/en/http_dav/ 

angie dav ext module: https://github.com/arut/nginx-dav-ext-module

nginx webdav docker image: https://github.com/duxlong/webdav

## Features

install oficial packages angie + angie-dav-ext-module from angie alpine repo

use `-e USERNAME xxx -e PASSWORD xxx` to set single user login

use `-v /your/htpasswd:/opt/nginx/conf/htpasswd:ro` to set multi-user login

The multi-user login method has higher priority

## Github

https://github.com/zverev-iv/webdav

## Docker hub

https://hub.docker.com/r/zvereviv/webdav

## Usage

docker pull
```
docker pull zvereviv/webdav
```

docker run for single user
```
docker run -d \
    -v /srv/dev-disk-by-label-2T/download:/data/download \
    -v /srv/dev-disk-by-label-3T/photo:/data/photo \
    -v /srv/dev-disk-by-label-3T/video:/data/video \
    -v /srv/dev-disk-by-label-3T/zoo:/data/zoo \
    -e USERNAME=xxx \
    -e PASSWORD=xxx \
    -p 8001:80 \
    --restart=unless-stopped \
    --name=webdav \
    zvereviv/webdav
```

docker run for multi user
```
docker run -d \
    -v /srv/dev-disk-by-label-2T/download:/data/download \
    -v /srv/dev-disk-by-label-3T/photo:/data/photo \
    -v /srv/dev-disk-by-label-3T/video:/data/video \
    -v /srv/dev-disk-by-label-3T/zoo:/data/zoo \
    -v /docker/webdav/htpasswd:/opt/nginx/conf/htpasswd:ro \
    -p 8001:80 \
    --restart=unless-stopped \
    --name=webdav \
    zvereviv/webdav
```

- Supports multiple users; before running the container, the online website needs to generate and configure the `htpasswd` file (default Md5 algorithm encryption)

- put files that need to be shared in the `/data` directory

- fill users information in the `/opt/nginx/conf/htpasswd` directory

docker-compose example for multi user configuration
```
version: "3"
services:
  webdav:
    container_name: webdav
    image: zvereviv/webdav
    network_mode: bridge
    restart: unless-stopped
    volumes:
      - /srv/dev-disk-by-label-2T/download:/data/download
      - /srv/dev-disk-by-label-3T/photo:/data/photo
      - /srv/dev-disk-by-label-3T/video:/data/video
      - /srv/dev-disk-by-label-3T/zoo:/data/zoo
      - /docker/webdav/htpasswd:/opt/nginx/conf/htpasswd:ro
    ports:
      - 8001:80
```