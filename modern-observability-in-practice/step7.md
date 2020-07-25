# Discovering a Suboptimal SQL Query

With the Service List, we can see at a quick glance see endpoints that are running slower than the rest.

If we look at the Frontend Service, we can see there are two endpoints in particular that are substantially slower than the rest. 

![Slow Services](https://github.com/burningion/katacoda-tracing-datadog/raw/master/assets/ecommerce/bottleneck.gif)

Both the `HomeController#index` and the `ProductController#show` enpoints are showing _much_ longer latency times. If we click in, and view a trace, we'll see that we've got downstream microservices taking up a substantial portion of our load time.

Use the span list to see where it may be, and we can then take a look at each of the downstream services and where things may be going wrong.

It seems two microservices in particular are being called for the homepage. If we look into our `docker-compose.yml`, we can see both the `advertisements-service` and `discounts-service` are each taking over 2.5 seconds for each request. Let's look within their specific urls to see if there isn't something amiss.

Looking at the code, it appears we've accidentally left a line in from testing what happens if latency goes up.

Delete the line of code, and we can see there's another problem. It looks like we've got a classic N+1 query on our `discounts-service`.

It seems the last developer didn't realize the way they structured their code meant making multiple trips to the database when there shouldn't have been. 

There should be a line of code which states what happened, with a fix. Edit the `discounts.py` file, and let's see if the changes written work.