# Configuring the Datadog Agent 

If we open our `docker-compose.yml` file in the editor, we can see there are a few environment variables set to our sample application.

Let's run through the ones that are relevant to setting up the Datadog Agent first:

```
  agent:
    image: "datadog/agent:6.11.3"
    environment:
      - DD_API_KEY
      - DD_APM_ENABLED=true
      - DD_LOGS_ENABLED=true
      - DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true
      - DD_PROCESS_AGENT_ENABLED=true
      - DD_TAGS='env:golang-k8s-workshop'
    ports:
      - "8126:8126"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /proc/:/host/proc/:ro
      - /sys/fs/cgroup/:/host/sys/fs/cgroup:ro
    labels:
      com.datadoghq.ad.logs: '[{"source": "datadog-agent", "service": "agent"}]'
```

A few things to note here. First, we've made sure to acknowledge that the `DD_API_KEY` is going to be passed through. This is what allows us to link our account to Datadog, and we want to make sure we don't accidentally commit it to source control. 

Next in importance, we have the `DD_TAGS` key set with our environment as `env`. This allows us to create separate spaces within the Datadog UI for our environments. By adding this, each container that runs along together in the same service will be discoverable as such.

Next, we set the optional things for Datadog to be enabled. This includes logs, traces (APM), and process monitoring.

We also open up a port (8126), allowing for traces to be ingested across containers. Traces are collected at a container level via a language level library, and then shipped to the Agent for processing. Once processed, they then get shipped of to the Datadog backend.

We'll need to configure our downstream applications to know where the Agent lives. For our containers in `docker-compose`, we've set the network route to be it's container. If we were running the Agent in Kubernetes, we'd set it to run as a DaemonSet, and we'd then ship things to the Node's HostPort using the Downward API.

We then mount volumes, first so we can see the docker containers running on our host, and then see the host level metrics like CPU usage and memory.

Finally, we set labels for our container so our logs are properly ingested and labeled.
