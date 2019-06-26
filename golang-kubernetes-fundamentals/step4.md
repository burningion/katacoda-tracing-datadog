# Configuring the Application Container for Logs and Traces

With the same `docker-compose` still open, let's look further into the configuration of our Go service:

```
 frontend:
    build: .
    environment:
      - DD_AGENT_HOST=agent
      - DD_TRACE_AGENT_PORT=8126
    ports:
      - "8080:8080"
    depends_on:
      - agent
    labels:
      com.datadoghq.ad.logs: '[{"source": "go", "service": "frontend-go-service"}]'
```

This is much simpler! We just link the network to the `agent` container, so it's reachable, and then set it as the place for the Go APM library to ship it's traces. 

Finally, we label our logs as coming from Go, and name the service that's shipping the logs.

Our `env` parameter set in the Agent insures we are in the same namespace, so we don't need to re set it.