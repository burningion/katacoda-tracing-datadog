## Adding Monitors to Our Services

When we click into each of the services we've configured in APM, we see some default suggestions for monitors. Let's add some of these monitors so we can tell whenour application isn't performing properly.

In my case, I'm going to add the default, suggested `P90` latency monitors, so we can tell when things are taking too long to respond.

## Debugging an Application with Datadog

The first place we can check is the Service Map, to get an idea for our current infrastructure and microservice dependencies.

![Datadog Service Map](https://github.com/burningion/katacoda-tracing-datadog/raw/master/assets/ecommerce/service-map.png)

In doing so, we can tell that we've got two microservices that our frontend calls, a `discounts-service`, along with an `advertisements-service`.

If we click in to view our Service Overview in Datadog, we can see that our API itself isn't throwing any errors. The errors must be happening on the frontend.

![Services List](https://github.com/burningion/katacoda-tracing-datadog/raw/master/assets/ecommerce/problematic-service.gif)

So let's take a look at the frontend service, and see if we can find the spot where things are breaking.

If we look into the service, we can see that it's been laid out by views. There's at least one view that seems to only give errors. Let's click into that view and see if a trace from that view can tell us what's going on.

![Problematic Traces](https://github.com/burningion/katacoda-tracing-datadog/raw/master/assets/ecommerce/500-trace-errors.gif)

It seems the problem happens in a template. Let's get rid of that part of the template so we can get the site back up and running while figuring out what happened.

Our developers can see that they'll need to open `store-frontend-broken-instrumented/store-frontend/app/views/spree/layouts/spree_application.html.erb`{{open}} and delete the line under `<div class="container">`. It should begin with a `<br />` and end with a `</center>`.

In this case, the banner ads were meant to be put under `store-frontend-broken-instrumented/store-frontend/app/views/spree/products/show.html.erb` and `store-frontend-broken-instrumented/store-frontend/app/views/spree/home/index.html.erb`{{open}}.

For the `index.html.erb`, under `<div data-hook="homepage_products">` our developers would add the code:

```ruby
<br /><center><a href="<%= @ads['url'] %>"><img src="data:image/png;base64,<%= @ads['base64'] %>" /></a></center>

```

And for the `show.html.erb` at the very bottom add:

```ruby 
<br /><center><a href="<%= @ads['url'] %>"><img src="data:image/png;base64,<%= @ads['base64'] %>" /></a></center><br />
```

We can assume our developers have done that, and deploy the code changes with our new Docker image name, `ddtraining/ecommerce-frontend:latest`.

Edit the `docker-compose-files/docker-compose-broken-instrumented.yml`{{open}}, changing the `frontend` service to point to the:

```
  image: "ddtraining/ecommerce-frontend:latest"
```

With that, we can spin up our project. Let's see if there's anything else going on.


