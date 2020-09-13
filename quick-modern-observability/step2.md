# Grokking Software with Datadog

Whenever working with new code, it can be daunting to understand a system and how all of its subsystems interact.

Datadog instrumentation allows us to get an immediate insight into what's going on with our software systems, and begin exploring places that may need improvement. 

If we open our `docker-compose-files/docker-compose-broken-instrumented.yml`{{open}}, we can begin to understand how instrumentation is done with our application:

```
  agent:
    image: "datadog/agent:7.21.1"
    environment:
      - DD_API_KEY
      - DD_APM_ENABLED=true
      - DD_LOGS_ENABLED=true
      - DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true
      - DD_PROCESS_AGENT_ENABLED=true
      - DD_TAGS='env:ruby-shop'
    ports:
      - "8126:8126"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /proc/:/host/proc/:ro
      - /sys/fs/cgroup/:/host/sys/fs/cgroup:ro
    labels:
      com.datadoghq.ad.logs: '[{"source": "datadog-agent", "service": "agent"}]'
```

With this, we've added a Datadog Agent container, and along with it, volumes to see the resource usage on our host,  and the Docker socket so we can read all of the containers running on the host.

We've also added a `DD_API_KEY`, along with enabling logs and the process Agent. Finally, we've opened the port `8126`, where traces get shipped to for collection at the Agent level.

If we run the `env` command in a new shell tab for our lab, we can see that our lab environment already has the Datadog API key injected into our scenario.

Speaking of which, there's also a line, `DD_TAGS='env:ruby-shop'`. In this line, we've set an `env` tag for Datadog. This allows us to filter to a specific environment, and make sure we don't pollute other environments while testing.

And with that, we should start to see info coming in to Datadog. Head over to the Logs Live Tail page, and see if you can find logs flowing into your account, now that the application has been running for a while.

Next, if we _were_ instrumenting an application from scratch, we'd need to add the Datadog APM library to each of our application level languages, and set environment variables to correctly configure our application.
