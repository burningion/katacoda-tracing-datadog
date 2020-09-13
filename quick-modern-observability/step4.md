# APM Automatic Instrumentation with Python

Now that we've set up our main Ruby on Rails application, we can now instrument our downstream Python services.

Looking at the [documentation](http://pypi.datadoghq.com/trace/docs/web_integrations.html#flask) for the Python tracer, we have a utility called `ddtrace-run`. 

Wrapping our Python executable in a `ddtrace-run` allows us to spin up a running instance of our application fully instrumented with our tracer, so long as our libraries are supported by `ddtrace`.

For supported applications like Flask, `ddtrace-run` dramatically simplifies the process of instrumentation.

## Instrumenting the Advertisements Service

In our `docker-compose-files/docker-compose-broken-instrumented.yml`{{open}} there's a command to bring up our Flask server. If we look, we'll see it's a:

```
ddtrace-run flask run --port=5002 --host=0.0.0.0
```

The `ddtrace` Python library includes an executable that allows us to automatically instrument our Python application. We simply call the `ddtrace-run` application, followed by our normal deployment, and magically, everything is instrumented.

With this, we're now ready to _configure_ our application's instrumentation.

Automatic instrumentation is done via environment variables in our `docker-compose-files/docker-compose-broken-instrumented.yml`{{open}}:

```
      - DATADOG_SERVICE_NAME=advertisements-service
      - DD_AGENT_HOST=agent
      - DD_LOGS_INJECTION=true
      - DD_VERSION=1.0
```

With this, we've connected and instrumented all of our services to APM.

The last thing we need to add is a _label_ to our container, so our logs are shipped with the label of the service, and with the proper language processor:


```
    labels:
      com.datadoghq.ad.logs: '[{"source": "python", "service": "ads-service"}]'
```

We can repeat the process, and fill out the settings for the `discounts-service`:

```
  discounts:
    environment:
      - FLASK_APP=discounts.py
      - FLASK_DEBUG=1
      - POSTGRES_PASSWORD
      - POSTGRES_USER
      - DATADOG_SERVICE_NAME=discounts-service
      - DATADOG_TRACE_AGENT_HOSTNAME=agent
      - DD_LOGS_INJECTION=true
    image: "ddtraining/discounts-service:latest"
    command: ddtrace-run flask run --port=5001 --host=0.0.0.0
    ports:
      - "5001:5001"
    volumes:
      - "./discounts-service:/app"
    depends_on:
      - agent
      - db
    labels:
      com.datadoghq.ad.logs: '[{"source": "python", "service": "discounts-service"}]'
```

To verify for yourself, take a look at the `discounts-service/discounts.py`{{open}} file. You'll see there's no reference to Datadog at all.

Now that we've fully instrumented our application, let's hop back in to Datadog to take a closer look at _why_ and _where_ our application may be failing.