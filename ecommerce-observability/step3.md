# APM Automatic Instrumentation with Rails

Our code has already been set up with instrumentation from Datadog. 

Depending on the language your application runs in, you may have a different process for instrumenting your code. It's best to look at the [documentation]() for your specific language.

In our case, our applications run on [Ruby on Rails]() and Python's [Flask](). We'll instrument each language differently.

For Ruby on Rails, we need to first add the `ddtrace` Gem to our Gemfile. Take a look at `store-frontend/Gemfile` in the Katacoda file explorer.

Because we plan on also consuming logs from Rails and correlating them with traces, we've also added `logging-rails` and `lograge`. Both of these are documented on the Ruby [trace / logs]() correlation part of the documentation.

Once these are both added to the list of our application's requirements, we must then add a `datadog.rb` to the list of initializers.

There, we control a few settings:

```ruby
Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails, {'analytics_enabled': true}
  # Make sure requests are also instrumented
  c.use :http, {'analytics_enabled': true}
  c.tracer hostname: 'agent'
  c.tracer env: 'ruby-shop'
end
```

We set `analytics_enabled` to be `true` for both our Rails auto instrumentation, and the `http` instrumentation.

This allows us to use Trace Search and Analytics from within Datadog.

We then set a `hostname` for all our traces to be sent to. Because we set the Datadog Agent to listen on port `8126`, we set this to be the hostname available within our `docker-compose`.

Finally, we set an environment for our traces. This allows us to separate different environments, for example, staging and production.

With this, our Ruby application is instrumented. We're also able to continue traces downstream, utilizing Distributed Traces.

Next, let's look at how a Python application is instrumented.