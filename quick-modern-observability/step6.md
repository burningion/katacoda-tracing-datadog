# Communicating Observability Practices to Your Team

With the Service List, we can see at a quick glance see endpoints that are running slower than the rest. When working with a team migrating to microservices, this view can be a great first approach to breaking down existing problems.

For example, if we look at the Frontend Service, we can see there are two endpoints in particular that are substantially slower than the rest. 

![Slow Services](https://github.com/burningion/katacoda-tracing-datadog/raw/master/assets/ecommerce/bottleneck.gif)

Both the `HomeController#index` and the `ProductController#show` enpoints are showing _much_ longer latency times. If we click in, and view a trace, we'll see that we've got downstream microservices taking up a substantial portion of our load time.

Use the span list to see where it may be, and we can then take a look at each of the downstream services and where things may be going wrong.

It seems two microservices in particular are being called for the homepage. We can see both the `advertisements-service` and `discounts-service` are each taking over 2.5 seconds for each request. Let's look within their specific urls to see if there isn't something amiss.

Look into the spans for the `discounts-service` to try finding the specific route with a 2.5 second delay, and then open the file: `discounts-service/discounts.py`{{open}}

Looking at the code, it appears we've accidentally left a line in from testing what happens if latency goes up. 

Try spotting the line and removing the code to see if you can bring the latency down again for the application. 

We can do the same with the `advertisements-service`, again finding the Flask view based upon the span, and then searching through the source code in `ads-service/ads.py`{{open}}

What sort of an improvement in page load time did it give you? Can you graph the differences over time?
