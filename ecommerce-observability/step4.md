# APM Automatic Instrumentation with Python

Now that we've set up our Ruby on Rails application, we can now instrument our downstream Python services.

Looking at the [documentation](http://pypi.datadoghq.com/trace/docs/web_integrations.html#flask) for the Python tracer, we have a utility called `ddtrace-run`. 

Wrapping our Python executable in a `ddtrace-run` allows us to spin up a running instance of our application fully instrumented with our tracer.

For supported applications like Flask, `ddtrace-run` dramatically simplifies the process of instrumentation.

## Instrumenting the Advertisements Service

In our `docker-compose.yml` there's a command to bring up our Flask server. If we look, we'll see it's a:

```
flask run --port=5002 --host=0.0.0.0
```

Once we install the Python `ddtrace` by adding it to our `requirements.txt` (it should already be there), we edit this command by putting a `ddtrace-run` in front:

```
ddtrace-run flask run --port=5002 --host=0.0.0.0
```

With this, we're ready to configure out application's insturmentation.

Automatic instrumentation is done via environment variables in our `docker-compose.yml`:

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
      - DD_ANALYTICS_ENABLED=true
    image: "burningion/ecommerce-spree-discounts:latest"
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

Next, let's take a closer look at _why_ and _where_ our application may be failing.