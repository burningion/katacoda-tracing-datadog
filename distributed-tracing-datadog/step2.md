# How Distributed Tracing works with Datadog

If you paid attention when looking through our `docker-compose.yaml`, you noticed that we run a single `datadog-agent` container, which ships off the traces, logs, and metrics for our entire cluster.

Datadog's Agent is meant to be run once per host. Depending on your environment, this may mean running the Agent as a container, or as a DaemonSet. 

Open up the `docker-compose.yaml`, and let's walk through the configuration options we've enabled for this project:

```
agent:
    image: "datadog/agent:6.9.0"
    environment:
      - DD_API_KEY
      - DD_APM_ENABLED=true
      # Add DD_APM_ANALYZED_SPANS to the Agent container environment.
      # Compatible with version 12.6.5250 or above.
      - DD_APM_ANALYZED_SPANS=users-api|express.request=1,sensors-api|flask.request=1,pumps-service|flask.request=1,iot-frontend|flask.request=1
      - DD_LOGS_ENABLED=true
      - DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true
      - DD_PROCESS_AGENT_ENABLED=true
      - DD_TAGS='env:dev'
    ports:
      - "8126:8126"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /proc/:/host/proc/:ro
      - /sys/fs/cgroup/:/host/sys/fs/cgroup:ro
    labels:
      com.datadoghq.ad.logs: '[{"source": "datadog-agent", "service": "agent"}]'
```

The Datadog Agent container is configured via environment variables and mounting volumes on the underlying host.  We also open up port `8126`, where traces get shipped to from the underlying applications.

The most important environment variable we set is `DD_API_KEY`, which is generated when we create an account. 