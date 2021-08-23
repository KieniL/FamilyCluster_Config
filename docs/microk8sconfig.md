
- [kubeconfig](#kubeconfig)
- [addons enabled in microk8s:](#addons-enabled-in-microk8s)
- [Ingress](#ingress)
- [TLS](#tls)


## kubeconfig
For configuration I copied the content of /var/snap/microk8s/current/credentials/client.config to $HOME/.kube/config


## addons enabled in microk8s:
* dns (for service discovery)
* metrics-server (for autoscaling)
* metallb (for loadbalancing IP)
* ha-cluster (default enabled)



## Ingress
For ingress I defined a hostname which routes to backend/frontend/...<br/>
FOr installation this commands are used:<br/>
<code>
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress ingress-nginx/ingress-nginx -n ingress --create-namespace
</code>
On Microk8s i neeeded to enable metallb with an ip range to have an external-ip


## TLS
For TLS I used this document: https://gardener.cloud/v1.14.0/guides/applications/https/
