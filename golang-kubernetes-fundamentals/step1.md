# Starting Our Microservices with Docker Compose

Before we dive into Kubernetes, let's first instrument our application using `docker-compose`. 

Using `docker-compose` when starting will allow us to simplify our environment, ensuring we focus on instrumentation concepts, before jumping into a live Kubernetes cluster.

We can inspect the `docker-compose.yml` in the `step01` folder, and see the exact services we'll be running.

`cd /golang-playground`{{execute}}

Let's first bring everything up with the following command:

`DD_API_KEY=<api key> docker-compose up`{{copy}}

If you get a error: 

`cannot send spans to agent:8126: [Errno -2] Name does not resolve` 

Make sure you entered your `DD_API_KEY`. 

With the services up, we should be able to view our services running on port 8080 in the web browser here: 

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/

After clicking the link, you should start to see traces come through in the Datadog UI. 

Try adding words at the end of the url like 'world' and see what happesn:

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/world

Next, let's see how this basic app and instrumentation work.