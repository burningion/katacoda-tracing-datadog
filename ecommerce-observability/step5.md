# Debugging Our Application with APM

Now that we've instrumented all of our code, let's take a look at the issues we've come across since the new team rolled out their first microservice, the `advertisements-service`.

Before instrumenting with Datadog, there'd been reports that the new `advertisements-service` broke the website. With the new deployment on staging, the `frontend` team has blamed the `ads-service` team, and the `advertisements-service` team has blamed the ops team.

Now that we've got Datadog and APM instrumented in our code, let's see what's really been breaking our application.

The first place we can check is the Service Map, to get an idea for our current infrastructure and microservice dependencies.

In doing so, we can tell that we've got two microservices that our frontend calls, a `discounts-service`, along with an `advertisements-service`.

If we click in to view our Service Overview in Datadog, we can see that our API itself isn't throwing any errors. The errors must be happening on the frontend.

So let's take a look at the frontend service, and see if we can find the spot where things are breaking.

If we look into the service, we can see that it's been laid out by views. There's at least one view that seems to only give errors. Let's click into that view and see if a trace from that view can tell us what's going on.

It seems the problem happens in a template. Let's get rid of that part of the template so we can get the site back up and running while figuring out what happened.

Open `sandbox/app/views/spree/layouts/spree_application.html.erb` and delete the line under `<div class="container">`.

With that, our project should be up and running. Let's see if there's anything else going on.


