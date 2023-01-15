# Docker Image for Grav with Xdebug

In Addition to the official Grav Docker Image, this one also includes Xdebug for those who want to make use of a state-of-the-art Debugger for Grav Development.  
It is still under development, but already works for me - see also [this Article](https://hoernerfranzracing.de/werner/kde-linux-web/tips-and-tricks/docker-grav-xdebug).  
Hints / Reports / Proposals are welcome.

This currently is pretty minimal and uses:

* apache-2.4.38
* GD library
* Unzip library
* exif library
* php8.0
* php8.0-opcache
* php8.0-acpu
* php8.0-yaml
* cron
* vim editor

In Addition, this one also includes xdebug with some utilitys, namely:

* xdebug
* iputils-ping
* iproute2

## Persisting data

To save the Grav site data to the host file system (so that it persists even after the container has been removed), simply map the container's `/var/www/html` directory to a named Docker volume or to a directory on the host.

> If the mapped directory or named volume is empty, it will be automatically populated with a fresh install of Grav the first time that the container starts. However, once the directory/volume has been populated, the data will persist and will not be overwritten the next time the container starts.

## Building the image from Dockerfile

```
docker build -t grav-xdebug:latest .
```

## Running Grav Image with Latest Grav + Admin:

```
docker run -p 8080:80 grav-xdebug:latest
```

Point browser to `http://localhost:8080` and create user account...

## Running Grav Image with Latest Grav + Admin with a named volume (can be used in production)

```
docker run -d -p 8080:80 --restart always -v grav-data:/var/www/html grav-xdebug:latest
```

## Running Grav Image with docker-compose and a volume mapped to a local directory

Running `docker-compose up -d` with the following docker-compose configuration will start the Grav container with all of the site data persisted to a named volume grav-data.

```.yml
volumes:
    grav-data:
      driver: local
      driver_opts:
        type: none
        device: $PWD/grav
        o: bind
  
services:
    docker-grav:
        image: grav-xdebug:latest
        container_name: grav-xdebug
        ports:
            - "8080:80"
        volumes:
            - ./grav-data/grav:/var/www/html/grav:rw
            - ./logs/xdebug:/logs/xdebug
            - ./xdebug.ini:/usr/local/etc/php/conf.d/xdebug.ini
```

## TODO:
- make Xdebug inclusion optional at build time, so image with or without Xdebug can be built on request (Default: no Xdebug)
