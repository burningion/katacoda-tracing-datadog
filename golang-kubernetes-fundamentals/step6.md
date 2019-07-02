# Instrumenting During Development

Now that we've got a function wrapper to pass Trace and Logging information around in our service, let's see how instrumentation works in practice during development, and why you'd want to use it.

Right now if we look in our `step02` folder, we see a `main.go` with two url routes:

```go
	mux := httptrace.NewServeMux(httptrace.WithServiceName("test-go"), httptrace.WithAnalytics(true)) // init the http tracer
	mux.HandleFunc("/ping", withSpanAndLogger(sayPong))
	mux.HandleFunc("/", withSpanAndLogger(sayHello)) // use the tracer to handle the urls
```

We have one called `/ping`, which responds with `pong`, and one called `/`, which returns a hello with the string of the URL called.

Let's create another view, called `/better`, which responds with a string saying "better" and the rest of the URL called afterwards.