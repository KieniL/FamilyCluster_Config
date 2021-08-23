# familychart

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for my familyapp

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ansparen.deploy | bool | `true` | defines if the ansparen deployment should be deployed |
| ansparen.image | string | `"sha256:2337e19898cc76bf8aa310ad45f24e6630de1f060a78f5b14c58055b9f547e15"` | the image tag of the ansparen deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| ansparen.resources.cpu_limit | string | `"1000m"` | the cpu limit for the ansparen pod |
| ansparen.resources.cpu_request | string | `"150m"` | the cpu request for the ansparen pod |
| ansparen.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| ansparen.resources.hpa.max_replica | int | `5` | the max replicas for ansparen |
| ansparen.resources.hpa.min_replica | int | `1` | the min replicas for ansparen |
| ansparen.resources.memory_limit | string | `"512Mi"` | the memory limit for the ansparen pod |
| ansparen.resources.memory_request | string | `"256Mi"` | the memory request for the ansparen pod |
| api.deploy | bool | `true` | defines if the api deployment should be deployed |
| api.image | string | `"sha256:46002aebab00fcfcfeb915cbcbb4e1aaa32b241eec72716fe1dbb5595945d3cd"` | the image tag of the api deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| api.resources.cpu_limit | string | `"750m"` | the cpu limit for the api pod |
| api.resources.cpu_request | string | `"150m"` | the cpu request for the api pod |
| api.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| api.resources.hpa.max_replica | int | `5` | the max replicas for api |
| api.resources.hpa.min_replica | int | `1` | the min replicas for api |
| api.resources.memory_limit | string | `"512Mi"` | the memory limit for the api pod |
| api.resources.memory_request | string | `"256Mi"` | the memory request for the api pod |
| auth.deploy | bool | `true` | defines if the authentication deployment should be deployed |
| auth.image | string | `"sha256:557092397a4ffa75fe12a43e6cfe90ecb67c3944951274e6b8f577c5f3411d38"` | the image tag of the authentication deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| auth.resources.cpu_limit | string | `"1000m"` | the cpu limit for the authentication pod |
| auth.resources.cpu_request | string | `"150m"` | the cpu request for the authentication pod |
| auth.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| auth.resources.hpa.max_replica | int | `5` | the max replicas for authentication |
| auth.resources.hpa.min_replica | int | `1` | the min replicas for authentication |
| auth.resources.memory_limit | string | `"512Mi"` | the memory limit for the authentication pod |
| auth.resources.memory_request | string | `"256Mi"` | the memory request for the authentication pod |
| cert.deploy | bool | `true` | defines if the certifiction deployment should be deployed |
| cert.image | string | `"sha256:cead3eb7bc1ceb6d28ed089c1217652db46f1439e3cb4a56539a22ef527ed46e"` | the image tag of the certication deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| cert.resources.cpu_limit | string | `"1000m"` | the cpu limit for the certification pod |
| cert.resources.cpu_request | string | `"150m"` | the cpu request for the certification pod |
| cert.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| cert.resources.hpa.max_replica | int | `5` | the max replicas for certification |
| cert.resources.hpa.min_replica | int | `1` | the min replicas for certification |
| cert.resources.memory_limit | string | `"512Mi"` | the memory limit for the certification pod |
| cert.resources.memory_request | string | `"256Mi"` | the memory request for the certification pod |
| frontend.deploy | bool | `true` | defines if the frontend deployment should be deployed |
| frontend.image | string | `"sha256:4c4ecb4485c8f9f004b2073e64e9026887aac514a4014b66a966d35891cbb44e"` | the image tag of the frontend deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| frontend.resources.cpu_limit | string | `"750m"` | the cpu limit for the frontend pod |
| frontend.resources.cpu_request | string | `"150m"` | the cpu request for the frontend pod |
| frontend.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| frontend.resources.hpa.max_replica | int | `5` | the max replicas for frontend |
| frontend.resources.hpa.min_replica | int | `1` | the min replicas for frontend |
| frontend.resources.memory_limit | string | `"512Mi"` | the memory limit for the frontend pod |
| frontend.resources.memory_request | string | `"256Mi"` | the memory request for the frontend pod |
| ingress.tls.secret | string | `"tls-secret"` | the secret in the namespace for the ingress tls |
| ingress.url | string | `"frontend.kieni.at"` | the hostname for the ingress |
| installer.deploy | bool | `false` | defines if the installer job should be deployed |
| installer.dummy_data | bool | `false` | sets if the dummy_data should be added to the database |
| installer.image | string | `"sha256:ebaba21848b3b6b09a45e088853b49e9c5feacd0d9acc6ad0a1bda3aaf122b38"` | the image tag of the installer (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| installer.resources.cpu_limit | string | `"1000m"` | the cpu limit for the installer pod |
| installer.resources.cpu_request | string | `"150m"` | the cpu request for the installer pod |
| installer.resources.memory_limit | string | `"512Mi"` | the memory limit for the installer pod |
| installer.resources.memory_request | string | `"256Mi"` | the memory request for the installer pod |
| postman.image | string | `"sha256:e038e2f4e48c80d59dd222a3924ceae03deaed793b0dfd21830d6454875b0184"` | defines the imagetag of the postman test (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| securitycheck.deploy | bool | `false` | defines if the security jobs (kube-hunter and kube-bench) should be deployed to check the service account token |
| securitycheck.resources.cpu_limit | string | `"1000m"` | the cpu limit for the security jobs |
| securitycheck.resources.cpu_request | string | `"150m"` | the cpu request for the security jobs |
| securitycheck.resources.memory_limit | string | `"1000Mi"` | the memory limit for the security jobs |
| securitycheck.resources.memory_request | string | `"100Mi"` | the memory request for the security jobs |
| storage.db.accessModes | string | `"ReadWriteMany"` | the accessModes used |
| storage.db.cpu_limit | string | `"400m"` | the cpu limit used for the mysql pod |
| storage.db.cpu_request | string | `"50m"` | the cpu request used for the mysql pod |
| storage.db.image | string | `"sha256:af5266b81b639e73b437d28bbf503edd2e3cbd5e503bcf71fe0c15620792edcb"` | the imagetag to deploy (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| storage.db.memory_limit | string | `"512Mi"` | the memory limit used for the mysql pod |
| storage.db.memory_request | string | `"256Mi"` | the memory request used for the mysql pod |
| storage.db.path | string | `"/mnt/k8s/dbdata"` | the path where to store the volume on disk |
| storage.db.persistance_needed | bool | `true` | sets if the volume for the db should be used or not |
| storage.db.size | string | `"15Gi"` | the size of the volume used |
| storage.db.storageClassName | string | `"manual"` | the storageClassName used in the volume |
| tests.cpu_limit | string | `"400m"` | the cpu limit used for the dbconnectiontets pod |
| tests.cpu_request | string | `"50m"` | the cpu request used for the dbconnectiontets pod |
| tests.memory_limit | string | `"512Mi"` | the memory limit used for the dbconnectiontets pod |
| tests.memory_request | string | `"256Mi"` | the memory request used for the dbconnectiontets pod |
| testsuite.deploy | bool | `false` | defines if the testsuite deployment should be deployed |
| testsuite.image | string | `"sha256:59a3fade55a45449c96b601e0280c47bfeaa4cfc7d97361c21a1e213d4cdbbd8"` | the image tag of the testsuite deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| testsuite.resources.cpu_limit | string | `"1000m"` | the cpu limit for the testsuite pod |
| testsuite.resources.cpu_request | string | `"150m"` | the cpu request for the testsuite pod |
| testsuite.resources.memory_limit | string | `"1000Mi"` | the memory limit for the testsuite pod |
| testsuite.resources.memory_request | string | `"100Mi"` | the memory request for the testsuite pod |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
