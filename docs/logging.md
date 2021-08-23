- [General Information](#general-information)
- [Installation](#installation)
- [Additional Input](#additional-input)
- [Splunk](#splunk)

# General Information
I use grafana loki for logging to have monitoring and logging in one platform. I installed loki in the monitoring namespace and is then accessible in grafana ui with this url: http://loki.monitoring:3100


# Installation
<code>
helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

helm upgrade --install loki -n monitoring grafana/loki-stack  --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false
</code>

# Additional Input
* https://github.com/grafana/loki
* https://grafana.com/docs/loki/latest/installation/helm/
* https://grafana.com/docs/loki/latest/getting-started/grafana/


# Splunk
Normally I would use splunk but since i don't have the compute power at home i won't use any log analysis tool