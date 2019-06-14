curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod +x skaffold
mv skaffold /usr/local/bin
git clone https://github.com/burningion/microservices-demo.git /hipster-shop
cd /hipster-shop
git checkout datadog-instrumented