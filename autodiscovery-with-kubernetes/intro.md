# Creating a Kubernetes Cluster

Before we get add autodiscovery, let's spin up a kubernetes cluster on two hosts:

In the first host on the right, issue the following command to initialize the kubernetes cluster:

`kubeadm init --kubernetes-version $(kubeadm version -o short)`{{execute HOST1}}

Next, add the second host to the cluster with a `kubeadm` join:

`kubeadm join`{{execute HOST2}}

Great! Next, let's make sure our nodes are available with a `kubectl get nodes` on `host1`.