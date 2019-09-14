# APM Automatic Instrumentation with Python

Now that we've set up our Ruby on Rails application, we can now instrument our downstream Python services.

Looking at the docs for the Python tracer, we have a utility called `ddtrace-run`. 

Wrapping our Python executable in a `ddtrace-run` allows us to spin up a running instance of our application fully instrumented with our tracer.

For supported applications like Flask, `ddtrace-run` dramatically simplifies the process of instrumentation.

In our Dockerfile for the applications we wish to instrument, our `command` goes from:

```
flask run --port=5002 --host=0.0.0.0
```

To a:

```
ddtrace-run flask run --port=5002 --host=0.0.0.0
```

With this, our application has been instrumented.

As for configuring this instrumentation, we can do it via environment variables in our `docker-compose.yml`:

```
      - DATADOG_SERVICE_NAME=advertisements-service
      - DATADOG_TRACE_AGENT_HOSTNAME=agent
      - DD_LOGS_INJECTION=true
      - DD_ANALYTICS_ENABLED=true
```

With this, we've connected and instrumented all of our services to APM.

The last thing we need to add is a _label_ to our container, so our logs are shipped with the label of the service, and with the proper language processor:

```
    labels:
      com.datadoghq.ad.logs: '[{"source": "python", "service": "discounts-service"}]'
```

And:

```
    labels:
      com.datadoghq.ad.logs: '[{"source": "python", "service": "ads-service"}]'
```

Next, let's take a closer look at _why_ and _where_ our application may be failing.