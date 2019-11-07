# Spinning Up Our Legacy E-Commerce Shop

Our legacy shop uses Ruby on Rails and Spree. 

We use `docker-compose` to bring it up and running. There's a prebuilt Rails Docker container image, along with a few Python / Flask microservice which handle our Coupon codes and Ads which run on the store.

In this workshop, we're going to spin up and instrument our application to see where bottlenecks exist.

We'll focus on thinking through what observability might make sense in a real application, and see how setting up observability works in practice.

Our application should be cloned from Github in this scenario, and if we change into the directory, we should be able to start the code with the following:

```
$ cd /ecommerce-observability
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres  docker-compose up
```

Once our images are pulled, we should be able to jump into and view the application within Katacoda:

https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/

Try browsing around, and notice the homepage takes an especially long time to load. 

The first thing we'll do is see where that slow load time may be coming from.