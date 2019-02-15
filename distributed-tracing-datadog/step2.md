# How Distributed Tracing works with Datadog

If you paid attention when looking through our `docker-compose.yaml`, you noticed that we run a single `datadog-agent` container, which ships off the traces, logs, and metrics for our entire cluster.

Datadog's Agent is meant to be run once per host. Depending on your environment, this may mean running the Agent as a container, or as a DaemonSet. 

Open up the `docker-compoose.yaml`, and let's walk through the configuration options we've enabled for this project:

