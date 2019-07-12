# Instrumenting Kubernetes Applications in Multi-Language Architectures

For most companies, legacy infrastructure exists, and is a constant source of headhaches for new feature development.

Often times, legacy code is written in different languages or patterns, ones not ideal for the current set of constraints given when developing code. Once a piece of software becomes popular, the priorities switch to keeping it up and running, rather than keeping it clean.

Distributed Tracing gives us a tool to help deal with these sorts of constraints. Given a legacy application, using traces allows us to see if we're getting performance improvements from changes, and helps eliminate any "mythology" about how legacy systems behave.

Now that we've seen a bit of a high level for how our services are working or not, let's jump into the Datadog UI and start with a closer look at the service that calls all the subservices, `frontend-service`.

If we hop into the Service List for the `frontend-service`, we can see all of the URL endpoints along with latencies, etc.

In this interactive course, we also have the source code the `frontend-service` image was built from. 

If we look for the instrumentation for the `frontend-service` `api.py` source code, we'll notice there is _hardly any_ Datadog specific instrumentation. We merely grab a current context's `trace`, and set a `TRACE_PRIORITY`.

That's because the Python version of the Datadog Tracing library supports monkeypatching. If we look in our service's `Dockerfile`, we'll see that the final run command wraps Flask with a `ddtrace-run`:

```
CMD ["ddtrace-run", "flask", "run", "--host=0.0.0.0"]
```

In this way, we can quickly get a base idea for what's happening in legacy infrastucture, without having to do too much instrumenation or changes.

This works best in a supported language level library, as we'll have already made decisions about how and what to instrument out of the box.

Jumping now back into Datadog, take a look at Live Tail, Logs, APM's Service List, and finally, the Service Map.

All of this comes out of the box, helping you to get a handle on what's going on with your legacy systems, before jumping in to improve the state things with Go.