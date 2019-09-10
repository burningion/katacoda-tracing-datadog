# Spotting Bottlenecks with the Service List

With the Service List, we can see at a quick glance see endpoints that are running slower than the rest.

If we look at the Frontend Service, we can see there are two endpoints in particular that are substantially slower than the rest. 

Both the `HomeController#index` and the `ProductController#show` enpoints are showing _much_ longer latency times. If we click in, and view a trace, we'll see that we've got downstream microservices taking up a substantial portion of our load time.

Use the span list to see where it may be, and we can then take a look at each of the downstream services and where things may be going wrong.