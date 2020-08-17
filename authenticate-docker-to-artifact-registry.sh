#!/bin/sh
cat /home/alexi/Downloads/adhadjilambris-1-352eee1c8c13.json | docker login -u _json_key --password-stdin \
    https://us-docker.pkg.dev