# Instrumenting Kubernetes Applications in Multi-Language Architectures

For most companies, legacy infrastructure exists, and is a constant source of headhaches for new feature development.

Often times, legacy code is written in different languages or patterns, ones not ideal for the current set of constraints given when developing code. Once a piece of software becomes popular, the priorities switch to keeping it up and running, rather than keeping it clean.

Distributed Tracing gives us a tool to help deal with these sorts of constraints. Given a legacy application, using traces allows us to see if we're getting performance improvements from changes, and helps eliminate any "mythology" about how legacy systems behave.

Now that we've seen a bit of a high level for how our services are working or not, let's start with a closer look at the service that calls all the subservices, `frontend-service`.

If we hop into the Service List for the `frontend-service`, we can see all of the URL endpoints along with latencies, etc.

In this interactive course, we also have the source code the `frontend-service` image was built from. 

Let's jump into it and get a feel for where we might want to create our first replacement service.

Looking at the source code, I notice that both the `/generate_requests` and `/generate_requests_user` are called via a `subprocess.call` function.

This spawns a shell for every request and doesn't look great. Let's write a web service to replace this with Golang, and add better visibility across the requests.

We'll use our existing Golang application from the first part of this lesson, and add endpoints for those requests.