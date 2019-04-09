# Following a Trace Across Services

The main benefit for distributed tracing is to be able to see your requests across databases and services in a single view.

Let's now jump in to our frontend service, and look for the slowest part of our request.



We can click down into our service, and then drill down to all the endpoints.

As our `iot-frontend` services is just a single page app, it seems the services behind the frontend must be where bottlenecks lie.

And under our APM Services, we can see a list of each service, along with their average latency.

To the rightmost, we can see the ability to add Monitors to our specific services.

Click to create a new Monitor for our `users-api`.