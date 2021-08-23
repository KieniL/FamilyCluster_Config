
# Prometheus and Grafana

For Prometheus on microk8s the addon is enabled with microk8s enable prometheus (default username and password is admin)<br/>

Otherwise this repo can be used (username: admin, pw: orom-operator): https://gitlab.com/nanuchi/youtube-tutorial-series/-/blob/master/prometheus-exporter/install-prometheus-commands.md


# accessing the grafana UI
For accessing the Grafana UI an ingress should be created (see monitoring-ingress.yaml)


# Definition of the Dashboard
I Used https://itnext.io/k8s-monitor-pod-cpu-and-memory-usage-with-prometheus-28eec6d84729 for the definition of the dashboard
You can import the dashboard (https://grafana.com/docs/grafana/latest/dashboards/export-import/#importing-a-dashboard) by using the Family Dashboard.json


It shows the limits of cpu and memory for all containers and also the logs of them


# See resource usage:
run
<code>kubectl top node</code>
or (on microk8s)
<code>microk8s.kubectl top node</code>
on the master to see the resource usage on all nodes



# Istio (not used)

I used this youtube tutorial: https://youtu.be/voAyroDb6xk
I installed istioctl with curl -L https://istio.io/downloadIstio | sh - and added the bin folder in it to my PATH
I installed istioctl in the cluster with: istioctl install
I labelled the family namespace with: kubectl label namespace family istio-injection=enabled.
With this it is necessary to redeploy all services in the namespace to have the istio proxy also deployed.
Then I deployed all addons from istio folder samples/addons.
I created an ingress for kiali. This is a tool which displays a workload graph. The label app is needed in the deployments.