# Our Broken Legacy Web Application

Our legacy monolith shop uses Ruby on Rails and Spree. We've started to build out a first set of microservices, and these have been added to an initial set of containers.

We use `docker-compose` to bring it up and running. There's a prebuilt Rails Docker container image, along with the new Python / Flask microservice which handle our Coupon codes and Ads which display in the store.

In this workshop, we're going to spin up and instrument our application to see where things are broken, and next, find a few bottlenecks.

We'll focus on thinking through what observability might make sense in a real application, and see how setting up observability works in practice.

Our application should be cloned from Github in this scenario, and if we change into the directory, we should be able to start the code with the following:

```
$ cd /ecommerce-observability/docker-compose-files
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres  docker-compose -f docker-compose-broken-no-instrumentation.yml up
```

Once our images are pulled, we should be able to jump into and view the application within Katacoda:

https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/

Try browsing around, and notice the homepage takes a very long time to load. 

![storedog](../assets/ecommerce/storedog.png)

Next, let's instrument our application with Datadog and see where the slow page load is coming from.