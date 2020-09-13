# Our Broken Legacy Web Application

Our legacy monolith shop uses Ruby on Rails and Spree. We've started to build out a first set of microservices, and these have been added to an initial set of containers.

We use `docker-compose` to bring it up and running. There's a prebuilt Rails Docker container image, along with the new Python / Flask microservice which handle our Coupon codes and Ads which display in the store.

In this workshop, we're going to spin up and instrument our application to see where things are broken, and next, find a few bottlenecks.

We'll focus on thinking through what observability might make sense in a real application, and see how setting up observability works in practice.

Our application should be cloned from Github in this scenario, and if we change into the directory, we should be able to start the code with the following:

```
$ cd /ecommerce-observability/docker-compose-files
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres  docker-compose -f docker-compose-broken-instrumented.yml up
```

Once our images are pulled, we should be able to jump into and view the application within Katacoda:

https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/

Try browsing around, and notice the homepage takes a very long time to load. 

![storedog](https://github.com/burningion/katacoda-tracing-datadog/raw/master/assets/ecommerce/storedog.png)

## Spinning up Traffic for Our Site

In our `/ecommerce-observability` folder, we've got a copy of [GoReplay](https://goreplay.org).

We've also got a capture of "production" traffic using GoReplay. Let's spin up an infinite loop of that traffic. Click the "+" sign next to the `storedog` tab, and open a new terminal to spin it up:

```
$ cd /ecommerce-observability
$ ./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"
```

Once we spin up that traffic, we can then take a look at the issues we've come across since the new team rolled out their first few microservices.

Before being instrumented with Datadog, there'd been reports that the new `advertisements-service` broke the website. With the new deployment on staging, the `frontend` team has blamed the `ads-service` team, and the `advertisements-service` team has blamed the ops team.

With Datadog and APM instrumented in our code, let's see what's really been breaking our application.
