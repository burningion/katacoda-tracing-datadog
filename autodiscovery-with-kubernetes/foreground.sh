#!/bin/bash
kubeadm init --kubernetes-version $(kubeadm version -o short)