# Adding our Goroutine Based Traffic Generator

Let's create a concurrent request generator using our existing application, Goroutines and the `http` library's `MaxConnsPerHost`. For reference, the docs are [here](https://golang.org/pkg/net/http/#Transport).

