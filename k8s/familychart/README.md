# familychart

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for my familyapp

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ansparen.deploy | bool | `true` | defines if the ansparen deployment should be deployed |
| ansparen.image | string | `"sha256:b9a132f7e61010cc41dcb5a92e3b72f2d7baa64d4d0cb0aa822711fbccc2e442"` | the image tag of the ansparen deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| ansparen.resources.cpu_limit | string | `"1000m"` | the cpu limit for the ansparen pod |
| ansparen.resources.cpu_request | string | `"150m"` | the cpu request for the ansparen pod |
| ansparen.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| ansparen.resources.hpa.max_replica | int | `5` | the max replicas for ansparen |
| ansparen.resources.hpa.min_replica | int | `1` | the min replicas for ansparen |
| ansparen.resources.memory_limit | string | `"512Mi"` | the memory limit for the ansparen pod |
| ansparen.resources.memory_request | string | `"256Mi"` | the memory request for the ansparen pod |
| api.deploy | bool | `true` | defines if the api deployment should be deployed |
| api.image | string | `"sha256:b09d430e95e4f28c3cd77af4f2adc1b336225fea5bb57c8953d800423a1bfeb4"` | the image tag of the api deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| api.resources.cpu_limit | string | `"750m"` | the cpu limit for the api pod |
| api.resources.cpu_request | string | `"150m"` | the cpu request for the api pod |
| api.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| api.resources.hpa.max_replica | int | `5` | the max replicas for api |
| api.resources.hpa.min_replica | int | `1` | the min replicas for api |
| api.resources.memory_limit | string | `"512Mi"` | the memory limit for the api pod |
| api.resources.memory_request | string | `"256Mi"` | the memory request for the api pod |
| auth.deploy | bool | `true` | defines if the authentication deployment should be deployed |
| auth.image | string | `"sha256:58bab6f753a23ec8473aab55d72a48e03435dfba5d3274e19ca22e7f0a8681a3"` | the image tag of the authentication deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| auth.resources.cpu_limit | string | `"1000m"` | the cpu limit for the authentication pod |
| auth.resources.cpu_request | string | `"150m"` | the cpu request for the authentication pod |
| auth.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| auth.resources.hpa.max_replica | int | `5` | the max replicas for authentication |
| auth.resources.hpa.min_replica | int | `1` | the min replicas for authentication |
| auth.resources.memory_limit | string | `"512Mi"` | the memory limit for the authentication pod |
| auth.resources.memory_request | string | `"256Mi"` | the memory request for the authentication pod |
| cert.deploy | bool | `true` | defines if the certifiction deployment should be deployed |
| cert.image | string | `"sha256:63b8c18fcc1a0cf0a53f3c396a1e1f688d3e0f64496b34ca126713bc7064c26b"` | the image tag of the certication deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| cert.resources.cpu_limit | string | `"1000m"` | the cpu limit for the certification pod |
| cert.resources.cpu_request | string | `"150m"` | the cpu request for the certification pod |
| cert.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| cert.resources.hpa.max_replica | int | `5` | the max replicas for certification |
| cert.resources.hpa.min_replica | int | `1` | the min replicas for certification |
| cert.resources.memory_limit | string | `"512Mi"` | the memory limit for the certification pod |
| cert.resources.memory_request | string | `"256Mi"` | the memory request for the certification pod |
| frontend.deploy | bool | `true` | defines if the frontend deployment should be deployed |
| frontend.image | string | `"sha256:c36cc8e80acd1449f67bbea8f07e0bbe675bc2f3b1363cd7e013934404eb07ef"` | the image tag of the frontend deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| frontend.resources.cpu_limit | string | `"750m"` | the cpu limit for the frontend pod |
| frontend.resources.cpu_request | string | `"150m"` | the cpu request for the frontend pod |
| frontend.resources.hpa.cpu_utilization | int | `60` | the amount of cpu utilization to check for scaling |
| frontend.resources.hpa.max_replica | int | `5` | the max replicas for frontend |
| frontend.resources.hpa.min_replica | int | `1` | the min replicas for frontend |
| frontend.resources.memory_limit | string | `"512Mi"` | the memory limit for the frontend pod |
| frontend.resources.memory_request | string | `"256Mi"` | the memory request for the frontend pod |
| ingress.limitrpm | int | `30` | the amount of allowed connection from an ip per minute |
| ingress.limitrps | int | `5` | the amount of allowed connections from an ip per second |
| ingress.tls.secret | string | `"tls-secret"` | the secret in the namespace for the ingress tls |
| ingress.url | string | `"frontend.kieni.at"` | the hostname for the ingress |
| installer.deploy | bool | `false` | defines if the installer job should be deployed |
| installer.dummy_data | bool | `false` | sets if the dummy_data should be added to the database |
| installer.image | string | `"sha256:b529fd4294c06e2f6a58195a1eacd41d9b9a812d81797f7c1214aa274b995660"` | the image tag of the installer (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| installer.resources.cpu_limit | string | `"1000m"` | the cpu limit for the installer pod |
| installer.resources.cpu_request | string | `"150m"` | the cpu request for the installer pod |
| installer.resources.memory_limit | string | `"512Mi"` | the memory limit for the installer pod |
| installer.resources.memory_request | string | `"256Mi"` | the memory request for the installer pod |
| monitoring.deploy | bool | `false` | set to true if networkpolicy should be deployed with allowing the namespace monitoring |
| postman.image | string | `"sha256:1eeb4fd8b3f53be09f46ee4fc1d4a47e9ee450a2681b4d58e82283b73e5739f7"` | defines the imagetag of the postman test (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| securitycheck.deploy | bool | `false` | defines if the security jobs (kube-hunter and kube-bench) should be deployed to check the service account token |
| securitycheck.resources.cpu_limit | string | `"1000m"` | the cpu limit for the security jobs |
| securitycheck.resources.cpu_request | string | `"150m"` | the cpu request for the security jobs |
| securitycheck.resources.memory_limit | string | `"1000Mi"` | the memory limit for the security jobs |
| securitycheck.resources.memory_request | string | `"100Mi"` | the memory request for the security jobs |
| storage.db.accessModes | string | `"ReadWriteMany"` | the accessModes used |
| storage.db.cpu_limit | string | `"400m"` | the cpu limit used for the mysql pod |
| storage.db.cpu_request | string | `"50m"` | the cpu request used for the mysql pod |
| storage.db.image | string | `"sha256:fef5341d666ccb7ad9213027fc1815c1243d29f94bd2c7392f7f0d7177cf6e91"` | the imagetag to deploy (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| storage.db.memory_limit | string | `"512Mi"` | the memory limit used for the mysql pod |
| storage.db.memory_request | string | `"256Mi"` | the memory request used for the mysql pod |
| storage.db.path | string | `"/mnt/k8s/dbdata"` | the path where to store the volume on disk |
| storage.db.persistance_needed | bool | `true` | sets if the volume for the db should be used or not |
| storage.db.size | string | `"15Gi"` | the size of the volume used |
| storage.db.storageClassName | string | `"manual"` | the storageClassName used in the volume |
| tests.cpu_limit | string | `"400m"` | the cpu limit used for the dbconnectiontets pod |
| tests.cpu_request | string | `"50m"` | the cpu request used for the dbconnectiontets pod |
| tests.deploy | bool | `false` | set to true if the testconfigmap should be deployed too |
| tests.memory_limit | string | `"512Mi"` | the memory limit used for the dbconnectiontets pod |
| tests.memory_request | string | `"256Mi"` | the memory request used for the dbconnectiontets pod |
| testsuite.deploy | bool | `false` | defines if the testsuite deployment should be deployed |
| testsuite.image | string | `"sha256:4a47d758559862512cabb90751c38f51b5fab0f81d65bd9ecea466f248d2ed15"` | the image tag of the testsuite deployment (a digest is used to have a unique identifier when an imagetag is pushed multiple times) |
| testsuite.resources.cpu_limit | string | `"1000m"` | the cpu limit for the testsuite pod |
| testsuite.resources.cpu_request | string | `"150m"` | the cpu request for the testsuite pod |
| testsuite.resources.memory_limit | string | `"1000Mi"` | the memory limit for the testsuite pod |
| testsuite.resources.memory_request | string | `"100Mi"` | the memory request for the testsuite pod |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
