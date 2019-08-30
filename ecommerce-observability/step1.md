# Spinning Up Our Legacy E-Commerce Shop

Our old shop uses Ruby on Rails and Spree. 

The first thing we'll need to do is get PostgreSQL up and running. We can do that with Docker:


```bash
$ docker run -d --network=host --name postgres postgres:11.5-alpine
```