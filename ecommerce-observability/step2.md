# How to Grok an Application with Datadog

Whenever working with new code, it can be daunting to understand a system and how it all comes together.

Our Datadog instrumentation allows us to get an immediate insight into what's going on with the code. 

Let's add the Datadog Agent to our `docker-compose.yml`, and begin instrumenting our application:

```
  agent:
    image: "datadog/agent:6.13.0"
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

