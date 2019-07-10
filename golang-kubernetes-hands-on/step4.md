# Instrumenting Applications in Multi-Language Architectures

For most companies, legacy infrastructure exists, and is a constant source of complication for new feature development.

Often times, legacy code is written in different languages or patterns, ones not ideal for the current set of constraints given when developing code. Once a piece of software becomes popular, the priorities switch to keeping it up and running, rather than keeping it clean.

Distributed Tracing gives us a tool to help deal with these sorts of constraints. Given a legacy application, using traces allows us to see if we're getting performance improvements immediately, and helps eliminate any "mythology" about how legacy systems behave.

Let's take some time now and walk through the Datadog UI while generating some traffic with the legacy code we'll start replacing with performant Golang services.