# Improving Legacy Infrastructure with Go

Let's jump into our first replacement service.

Looking at the source code for the `frontend-service` in `api.py`, I notice that both the `/generate_requests` and `/generate_requests_user` are called via a `subprocess.call` function.

This spawns a shell for every request and doesn't look great. Let's write a web service to replace this with Golang, and add better visibility across the requests.

We'll use our existing Golang application from the first part of this lesson as a skeleton, and add endpoints for those requests.

Let's create a concurrent request generator using our existing application, Goroutines and the `http` library's `MaxConnsPerHost`. For reference, the docs are [here](https://golang.org/pkg/net/http/#Transport).

If you `cd ../golang-concurrent-generator/`, you should be able to see our replacement Golang service. 

Type `ls`, and see that we've got a `concurrent-requests.yaml` file for Kubernetes. Let's add it to the existing cluster with a:

`$ kubectl apply -f concurrent-requests.yaml`

We can also navigate to the replacement service directory with the file browser on the right.

Once the pod comes up, we can test our service with a `curl` or click at the following URL:

https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/

Looking at our source code, we should now see `pong` returned. Let's try `curl` at one of the API endpoints, and see if we can generate the proper requests:

https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/generate_requests_user