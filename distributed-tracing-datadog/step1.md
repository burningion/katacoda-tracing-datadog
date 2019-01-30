# Looking at the Images

Run a `docker images` on the terminal environment. We should see `datadog/agent` among those listed. By the time our process is finished building, we'll see a list of 3 containers, each beginning with `distributedtracing`.

Once those are up, we can then do our:

`DD_API_KEY=<api key> docker-compose up -d`{{copy}}

With that running, we should be able to view our services running on port 5000 in the web browser here: 

https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/
