#!/bin/bash
git clone https://github.com/burningion/distributed-tracing-with-apm-workshop
cd distributed-tracing-with-apm-workshop
docker-compose pull
docker-compose build
