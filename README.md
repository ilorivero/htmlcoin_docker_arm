 Build HTMLCoin Docker Images for Arm devices




## HTMLCoin Docker dockerfile and scripts for Arm devices

This Dockerfile was tested in an ArmV7 device (Raspberry Pi 3B) and in an Arm64 device (Dragonboard 410C). This Dockerfile uses an Ubuntu 18.04 base image.

### Method 1:

The easiest way to run HTMLCoin on Docker is to pull from Docker Hub:

```
docker pull ilorivero/htmlarm:latest
```
 
This way you will avoid spending hours of compilation time that are required to do the method 2 below.

### Method 2:

This repository contains the Dockerfile and scripts to build a HTMLCoin node version 2.5 Docker image for ARM devices.

Clone this repository with

```
git clone https://github.com/ilorivero/htmlcoin_docker.git
```

## To build the Ubuntu 18.04 Bionic Arm version image:

You have to configure Docker BuildX prior to run the docker commands below

```bash
cd ./htmlcoin_docker/Arm/
docker buildx build --platform linux/arm,linux/arm64 -t ilorivero/htmlarm --push .
```


## To build and run the container image:

```bash
docker run -d --rm --name htmlcoinarm -p 14889:14889 -v data:/root/.htmlcoin/ ilorivero/htmlarm
```

To check if the htmlcoin container is running:

```bash
 docker exec -i -t htmlcoinarm /bin/bash
```

You should be prompted with the Ubuntu command line. 

```bash
root@0670472b9f64:/HTMLCOIN#
```

Check the Ubuntu version:

```bash
lsb_release -a
```

You shoud get something like this:

``` 
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.4 LTS
Release:        18.04
Codename:       bionic
``` 

To check if HTMLCoin daemon is running, call the htmlcoin-cli app with --getinfo parameter:

```bash
htmlcoin-cli --getinfo
```

The result should be something like this:

```json
{
  "version": 2050000,
  "protocolversion": 70017,
  "blocks": 1337236,
  "timeoffset": 0,
  "connections": 1,
  "proxy": "",
  "difficulty": {
    "proof-of-work": 2807.914485770511,
    "proof-of-stake": 1879528578.109458
  },
  "chain": "main",
  "moneysupply": 0,
  "walletversion": 169900,
  "balance": 0.00000000,
  "stake": 0.00000000,
  "keypoololdest": 1594231883,
  "keypoolsize": 1000,
  "paytxfee": 0.00000000,
  "relayfee": 0.00400000,
  "warnings": ""
}
```


