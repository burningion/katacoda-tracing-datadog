# Standardizing Observability Across Endpoints

In our original `main.go`, instrumenting our application required a lot of boilerplate in order to grab the context, and set up logging.

In a language like Python, we can monkey patch methods and automatically instrument all of our views. In Go, we need to be more obvious about what we're doing.

So how do we reduce boilerplate for all of our urls?

Let's look at our original `sayHello` function, and see what we can strip out:

```go
func sayHello(w http.ResponseWriter, r *http.Request) {
	span, _ := tracer.SpanFromContext(r.Context())
	traceID := span.Context().TraceID()
	spanID := span.Context().SpanID()

	message := r.URL.Path

	// set a tag for the current path
	span.SetTag("url.path", message)

	message = strings.TrimPrefix(message, "/")

	// log with matching trace ID
	log.WithFields(log.Fields{
		"dd.trace_id": traceID,
		"dd.span_id":  spanID,
		"message":     message,
	}).Info("root url called with " + message)

	message = "Hello " + message

	w.Write([]byte(message))
}
```

Putting this into a wrapper function would allow us to have the trace and log context injected into every view we have. Creating that is straightforward enough.

```go
// Define a type for a handler that provides tracing parameters as well
type tracedHandler func(tracer.Span, *log.Entry, http.ResponseWriter, *http.Request)

// Write a wrapper function that does the magic preparation before calling the traced handler.
// This returns a function that is suitable for passing to mux.HandleFunc
func withSpanAndLogger(t tracedHandler) func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		span, _ := tracer.SpanFromContext(r.Context())
		traceID := span.Context().TraceID()
		spanID := span.Context().SpanID()
		entry := log.WithFields(log.Fields{
			"dd.trace_id": traceID,
			"dd.span_id":  spanID,
		})
		t(span, entry, w, r)
	}
}
```

With this wrapper, our function definition now takes a logger, along with a span:

```go
func sayHello(span tracer.Span, l *log.Entry, w http.ResponseWriter, r *http.Request) {
	message := r.URL.Path

	// set a tag for the current path
	span.SetTag("url.path", message)

	message = strings.TrimPrefix(message, "/")

	// log with matching trace ID
	l.WithFields(log.Fields{
		"message": message,
	}).Info("root url called with " + message)

	message = "Hello " + message

	w.Write([]byte(message))
}
```

Test it out yourself by doing a CTRL+C, and `cd ../step02`. You should then be able to run your application again, this time instrumented with your `docker-compose up` the same way as before.

Let's add a new url, along with a trace and logger to see how our views now receive log and span context along with the request and response.