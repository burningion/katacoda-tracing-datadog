#!/bin/bash
#kubeadm init --kubernetes-version $(kubeadm version -o short)
#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config
source <(kubektl completion bash)