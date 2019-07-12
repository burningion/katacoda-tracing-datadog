# Improving Legacy Infrastructure with Go

Let's jump into our first replacement service.

Looking at the source code for the `frontend-service` in `api.py`, I notice that both the `/generate_requests` and `/generate_requests_user` are called via a `subprocess.call` function.

This spawns a shell for every request and doesn't look great. Let's write a web service to replace this with Golang, and add better visibility across the requests.

We'll use our existing Golang application from the first part of this lesson, and add endpoints for those requests.

Let's create a concurrent request generator using our existing application, Goroutines and the `http` library's `MaxConnsPerHost`. For reference, the docs are [here](https://golang.org/pkg/net/http/#Transport).


