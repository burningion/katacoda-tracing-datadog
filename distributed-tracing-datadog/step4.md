# Following a Trace Across Services

The main benefit for distributed tracing is to be able to see your requests across databases and services in a single view.

Let's now jump in to our frontend service, and look for the slowest part of our request.

[ Images go here]

We can click down into our service, and then drill down to all the endpoints.

As our `iot-frontend` services is just a single page app, it seems the services behind the frontend must be where bottlenecks lie.

