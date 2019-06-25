# Instrumenting with the Our Application for Observability 

Let's open up our basic Golang app and see how it's been instrumented.

Start with the `Dockerfile` for our application itself. 

You'll see we use a build step, but there's nothing obvious within it for observability specifically.

If we jump into the Golang source code instead, we'll start to see some of the instrumentation necessary.

First, we import the Datadog tracer, along with an `httptracer` to wrap Mux.

We then initialize the tracer, and wrap our URL endpoints:

```
	// start the tracer with zero or more options
	tracer.Start()
	defer tracer.Stop()

	mux := httptrace.NewServeMux(httptrace.WithServiceName("test-go"), httptrace.WithAnalytics(true)) // init the http tracer
	mux.HandleFunc("/ping", sayPong)
	mux.HandleFunc("/", sayHello) // use the tracer to handle the urls
```

If we look a bit further up in our imports, we also see a logger has been added. 

Jump to the Datadog Live Tail Page under Logs and try reloading the page below. We shoulde also see the logs show up.

https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/

Next, let's look into the `docker-compose.yml`, and see all the configuration for sending logs and traces in one place.