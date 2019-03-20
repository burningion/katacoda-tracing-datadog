# Deploying Our Application to Kubernetes

The workshop already has an application ready to be deployed to kubernetes included.

Change into the YAML file directory with a `cd k8s-yaml-files/`. You should be able to `ls` and see the YAML files for every service we plan on running in our cluster.

You can `kubectl apply -f <filename>` for each one of these files, and we should see our entire cluster spin up.
