# Starting Our Microservices with Docker Compose

This APM workshop uses multiple docker images in order to build a micro services environment.

We can inspect the `docker-compose.yml` in the distributed tracing folder, and see the exact services.

Let's first bring everything up with the following command:

`DD_API_KEY=<api key> docker-compose up`{{copy}}

If you get a error like: `cannot send spans to agent:8126: [Errno -2] Name does not resolve`, make sure you entered your `DD_API_KEY`. 

With the services up, we should be able to view our services running on port 5000 in the web browser here: 

https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/


Remember, you can press CTRL+c and exit your running `docker-compose`.