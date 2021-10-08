# family

# I Use microk8s for development (and will probably use it finally)

I installed kubectl additionally to use the kubectl commands directly instead of microk8s.kubectl<br/>


# How to deploy
Create the secrets as defined in secretconfig.md

deploy the configmap like so:
helm upgrade --install credval k8s/credvalidate --values k8s/credvalidate/values.yaml

deploy the app like so:
helm upgrade --install familyapp k8s/familychart --values k8s/familychart/values.yaml

# Further documentation
For further documentation see the docs folder

# Jenkins
Every repo contains its own Jenkinsfile. It is for validating the app.
This repo also contains one. It is mostly used for overall testing and securing (kube-bench, kube-hunter, kube-score on helm).
I get the cluster resources and the helm template once and it use it multiple times from the outputted file


## Jenkins validates following things:

* Exposing of secrets (trufflehog)
* kube-benching (as a pod in cluster)
* kube-benching of helm template
* kube-benching (out of cluster)
* kube-hunter (as a pod in cluster)
* kube-hunter (out of cluster)
* kube-chunter (active mode out of cluster)
* kube-score (based on existing cluster resources)
* kube-score (based on helm template)
* kube-val (based on existing cluster resources)
* kube-val (based on helm template)
* nmap (based on ingress URL)
* harvester (to see url leaks in the internet)



