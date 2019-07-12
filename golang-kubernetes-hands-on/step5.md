# Improving Legacy Infrastructure with Go

Let's jump into our first replacement service.

Looking at the source code for the `frontend-service` in `api.py`, I notice that both the `/generate_requests` and `/generate_requests_user` are called via a `subprocess.call` function.

This spawns a shell for every request and doesn't look great. Let's write a web service to replace this with Golang, and add better visibility across the requests.

We'll use our existing Golang application from the first part of this lesson as a skeleton, and add endpoints for those requests.

Let's create a concurrent request generator using our existing application, Goroutines and the `http` library's `MaxConnsPerHost`. For reference, the docs are [here](https://golang.org/pkg/net/http/#Transport).

If you `cd ../concurrent-requests-generator`, you should be able to see our code. Alternatively, you can also just navigate to the directory with the file browser on the right.

We can now test that our service is up and running with a `curl`:

https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/

Looking at our source code, we should now see `pong` returned. Let's try `curl`, and see if we can generate the proper requests:

https://[[HOST_SUBDOMAIN]]-30002-[[KATACODA_HOST]].environments.katacoda.com/generate_requests_user