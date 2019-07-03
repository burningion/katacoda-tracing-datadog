# Instrumenting During Development

Now that we've got a function wrapper to pass Trace and Logging information around in our service, let's see how instrumentation works in practice during development, and why you'd want to use it.

Right now if we look in our `step02` folder, we see a `main.go` with two url routes:

```go
	mux := httptrace.NewServeMux(httptrace.WithServiceName("test-go"), httptrace.WithAnalytics(true)) // init the http tracer
	mux.HandleFunc("/ping", withSpanAndLogger(sayPong))
	mux.HandleFunc("/", withSpanAndLogger(sayHello)) // use the tracer to handle the urls
```

We have one called `/ping`, which responds with `pong`, and one called `/`, which returns a hello with the string of the URL called.

Let's create another view, called `/yo`, which responds with a string saying "yo" and the rest of the URL called afterwards.

We'll need to add the route, and then make sure the `sayYo` function gets passed in the context, along with the trace and span:

```go
func sayYo(span tracer.Span, l *log.Entry, w http.ResponseWriter, r *http.Request) {
	message := r.URL.Path

	span.SetTag("url.path", message)

	message = strings.SplitAfter(message, "/yo/")[1]

	l.WithFields(log.Fields{
		"message": message,
	}).Info("yo called with " + message)

	message = "Yo " + message

	w.Write([]byte(message))
}
```

Great! We can see how adding instrumenation in Go becomes a part of development, allowing us to keep context about what's happening within the working systems.

Next, let's move on to distributed tracing, and see how it unlocks visibility in distributed systems.