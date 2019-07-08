# Adding Services to Our Cluster

You can `kubectl apply -f <filename>` for each one of the remaining files in the YAML directory, and we should see our entire cluster spin up.

You should start with the two databases we have, `redis` and `postgres`, as the other containers rely on them running. After the databases, bring up the other services, and then finally, the `frontend-service`.

The `frontend-service` requires the other services to be running first, so it knows where to connect to for API requests.

If you accidentally spin up the `frontend-service` before the rest, simply type `kubectl delete pod f<TAB>`, to have autocomplete finish the name of the running frontend service pod.

Check your services are running with a `kubectl get services`. If one has an error, you may need to `kubectl delete pod <podname>`.

Make sure you can visit your services by viewing the link below:

https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/

In the editor to the right, you should be able to also navigate to the `k8s-yaml-files` directory, and see your YAML files you've deployed.

Next, let's take a closer look at our YAML files, and see how we've instrumented our application.
