- [Toolusage](#toolusage)
- [Makefile](#makefile)
  - [dockercheck_base](#dockercheck_base)
  - [dockercheck_family](#dockercheck_family)
  - [dockerhostcheck](#dockerhostcheck)
  - [dockercheck_all](#dockercheck_all)
  - [imagescan](#imagescan)
  - [k8scheck](#k8scheck)
  - [dynamicscan](#dynamicscan)
  - [unittest](#unittest)
  - [integrationtest](#integrationtest)
  - [malwareanalsis_generate](#malwareanalsis_generate)
  - [malwareanalsis_run](#malwareanalsis_run)
  - [security_check](#security_check)
- [kube-score](#kube-score)
  - [Installation:](#installation)
  - [Usage:](#usage)
- [kubeval](#kubeval)
  - [Installation](#installation-1)
  - [Usage](#usage-1)
- [ZAP scanning](#zap-scanning)
- [Conftest](#conftest)
- [Unittests](#unittests)
  - [Dockerfile Validation](#dockerfile-validation)
- [hadolint](#hadolint)
  - [Installation](#installation-2)
  - [Usage](#usage-2)
- [dockerlint](#dockerlint)
  - [Installation](#installation-3)
  - [usage](#usage-3)
- [dockerfile_lint](#dockerfile_lint)
  - [Installation](#installation-4)
  - [usage](#usage-4)
- [Image Scanning](#image-scanning)
  - [Snyk](#snyk)
  - [Trivy](#trivy)
    - [Installation:](#installation-5)
    - [usage](#usage-5)
      - [Parse based on helm input:](#parse-based-on-helm-input)
  - [Clair](#clair)
    - [Installation:](#installation-6)
    - [Usage:](#usage-6)
      - [Destroy env:](#destroy-env)
  - [Anchore](#anchore)
- [WAF](#waf)
- [helm docs](#helm-docs)
- [Kubesec](#kubesec)
  - [Installation](#installation-7)
  - [Usage:](#usage-7)
- [Kubeaudit](#kubeaudit)
  - [Installation](#installation-8)
  - [Usage](#usage-8)
- [Checkov](#checkov)
  - [Installation](#installation-9)
  - [Usage:](#usage-9)
- [Terrascan](#terrascan)
  - [Installation](#installation-10)
  - [usage](#usage-10)
  - [Disclaimer](#disclaimer)
- [Datree](#datree)
  - [Installation:](#installation-11)
  - [Usage](#usage-11)
- [yara:](#yara)
  - [Installation](#installation-12)
  - [Usage](#usage-12)
- [yarGen](#yargen)
  - [Installation](#installation-13)
  - [Usage](#usage-13)
- [kube-bench](#kube-bench)
  - [Usage](#usage-14)
    - [Docker](#docker)
- [kube-hunter](#kube-hunter)
  - [Usage](#usage-15)
    - [Docker](#docker-1)
    - [Kubernetes see security folder under k8s/familychart](#kubernetes-see-security-folder-under-k8sfamilychart)
- [kube-linter](#kube-linter)
  - [Installation](#installation-14)
  - [Usage](#usage-16)
- [kube-scape](#kube-scape)
  - [Installation](#installation-15)
  - [Usage](#usage-17)
- [Docker-bench](#docker-bench)
  - [Installation](#installation-16)
  - [Usage](#usage-18)
- [ffuf](#ffuf)
  - [Installation](#installation-17)
  - [Usage](#usage-19)

# Toolusage 

I use several tools in the pipeline (makefile)

# Makefile


There are several targets:

## dockercheck_base
Runs following tools on all baseimages from the baseimage repo https://github.com/KieniL/base_images

- dockerlint
- dockerfile_lint
- hadolint
- conftest

## dockercheck_family
Runs following tools on the images used in the helm release:

- dockerlint
- dockerfile_lint
- hadolint
- conftest

## dockerhostcheck
Creates a dockercontainer with docker bench security

## dockercheck_all
Runs dockercheck_base, dockercheck_family and dockerhostcheck

## imagescan
Does imagescanning on the images used by the helm release.
Uses following tools:

* snyk
* trivy

## k8scheck
Runs following tools against the helm release

* helm lint
* kubeval
* kube-score
* datree
* kubesec
* kubeaudit
* checkov
* helm conftest

## dynamicscan
Runs the fullscan and apiscan from owasp zap
## unittest
Deploys a k8s release with helm and runs the single tests on auth, ansparen and cert
## integrationtest
Deploys a k8s release with helm and runs the api tests

## malwareanalsis_generate
Generates a yara rule with yarGen on the Ansparen Dir
## malwareanalsis_run
runs the generated rule against the Ansparen Dir

## security_check
runs kube-bench and kube-hunter (active and passive) from outside the cluster


# kube-score

A tool which checks k8s ressources against CIS Benchmarks

## Installation:

I installed kubescore with:
<br/>wget https://github.com/zegl/kube-score/releases/download/v1.11.0/kube-score_1.11.0_linux_amd64.tar.gz
<br/>tar xvzf kube-score_1.11.0_linux_amd64.tar.gz
<br/> mv kube-score /usr/local/bin

## Usage:
Then i can use it with kube-score

e.g. on all resources in cluster:
kubectl api-resources --verbs=list --namespaced -o name \
  | xargs -n1 -I{} bash -c "kubectl get {} --all-namespaces -oyaml && echo ---" \
  | kube-score score - -o ci

or
helm template familyapp k8s/familychart/ --values k8s/familychart/values.yaml | kube-score score - -o ci



# kubeval

A tool which checks k8s yaml against validity (indents)

## Installation
I installed kubeval with:
wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
tar xf kubeval-linux-amd64.tar.gz
sudo cp kubeval /usr/local/bin


## Usage
Use kubeval on all cluster resources
kubectl api-resources --verbs=list --namespaced -o name   | xargs -n1 -I{} bash -c "kubectl get {} --all-namespaces -oyaml && echo ---"   | kubeval --ignore-missing-schemas

Use kubeval on helm:
helm template familyapp k8s/familychart/ --values k8s/familychart/values.yaml | kubeval --ignore-missing-schemas



# ZAP scanning
I use the docker image for it: https://hub.docker.com/r/owasp/zap2docker-stable
docker run -v $(shell pwd):/zap/wrk/:rw --net=host --rm -t owasp/zap2docker-stable zap-full-scan.py -t https://frontend.kieni.at/frontend -r zap_fullscan_report.html -I

The -v is there to see the report in your directory
The python script is what should be run from the container
-t is the url
-r is the outputurl
-I is not fail on warning

Then you can look for zap_fullscan_report.html

the makefile also does apiscan



# Conftest
To use conftest in helm just install it with:
helm plugin install https://github.com/instrumenta/helm-conftest

Then you can use the unittests in policy folder

Either
helm conftest unittest k8s/familychart/

or
conftest test ../*/Dockerfile


# Unittests
A helm deployment is done on a separate namespace and helm tests are run (mostly postman calls)


## Dockerfile Validation

In the policy folder there are docker_util.rego (boolean methods) and docker.rego for checking.
The policy checks
* that every from image is from the defined source (described by starting with a specific marker).
* no usage of . in copy and add
* no usage of cmd instead of entrypoint
* no usage of maintainer
* checks that the label maintainer with the defined email is there


# hadolint

https://github.com/hadolint/hadolint:

## Installation
Install with:
wget https://github.com/hadolint/hadolint/releases/download/v2.6.0/hadolint-Linux-x86_64
chmod u+x hadolint-Linux-x86_64
sudo cp hadolint-Linux-x86_64 /usr/local/bin/hadolint
sudo chown USER /usr/local/bin/hadolint

## Usage
I created a config file (hadolint_config.yaml) on which i overwrite all code to have an error and also added a label structure. On the command there is also -t which means it will only stop on errors


hadolint -t error --config hadolint_config.yaml ../FamilyCluster_Api/Dockerfile



# dockerlint

## Installation
npm install -g dockerlint

## usage
dockerlint ../FamilyCluster_Api/Dockerfile


# dockerfile_lint

## Installation
npm install -g dockerfile_lint
## usage
dockerfile_lint -u -p -f  ../FamilyCluster_Api/Dockerfile 

# Image Scanning
Will be run on make imagescan


## Snyk

Can be run from docker scan
docker scan luke19/familycluster_installer:9

## Trivy

### Installation:
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy


You will also need yq and jq:

pip3 install yq
sudo apt install jq


### usage

trivy IMAGE

e.g

trivy luke19/familycluster_installer:1

#### Parse based on helm input:

helm show values k8s/familychart/ > helmvalues.yaml

cat helmvalues.yaml | yq .installer.image


## Clair

I don't use it myself. It is just for completion

An quay vulnerability scanner from redhat
https://github.com/quay/clair

### Installation:

Check which architecture: dpkg --print-architecture

wget https://github.com/quay/clair/releases/download/v4.1.1/clairctl-linux-amd64
mv clairctl-linux-amd64 clairctl

chmod u+x clairctl
sudo cp clairctl /usr/local/bin/clairctl
sudo chown USER /usr/local/bin/clairctl


### Usage:
There is a local test dev environment to setup:
git clone git@github.com:quay/clair.git
cd clair
make local-dev-up-with-quay

You will then have a docker-compose file everything you need

You will then need to add localhost:8080 as an insecure repository to docker

Create an account (username: admin= on localhost:8080.
I then created an organizsation named luke19

docker pull luke19/familycluster_installer:9
docker login localhost:8080
docker tag luke19/familycluster_installer:9 localhost:8080/luke19/familycluster_installer:9
docker push localhost:8080/luke19/familycluster_installer:9 

After this quay scans the tag:


#### Destroy env:
make local-dev-down

## Anchore

I don't use it myself. It is just for completion

Run the docker-compose.yaml to deploy anchore (downloaded with: curl -O https://engine.anchore.io/docs/quickstart/docker-compose.yaml)

I updated the versions to v0.10.0.

It is better to run docker-compose up -d some time before testing to have the engine synced everything. It needs around 10 Minutes on first time.

You can check the sync status with: docker-compose exec api anchore-cli system feeds list



# WAF

At first:
I installed wafw00f (known from kali linux): sudo apt-get install -y wafw00f

wafw00f frontend.kieni.at

No WAF was detected

Then I added modsecurity to the ingress:

annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/modsecurity-transaction-id: "$request_id"
    nginx.ingress.kubernetes.io/enable-modsecurity: "true"
    nginx.ingress.kubernetes.io/enable-owasp-core-rules: "true"
    enable-owasp-modsecurity-crs: "true"

It is still not found by wafw00f


# helm docs

wget https://github.com/norwoodj/helm-docs/releases/download/v1.5.0/helm-docs_1.5.0_linux_amd64.deb

sudo dpkg -i helm-docs_1.5.0_linux_amd64.deb

in the helm-chart directory run helm-docs to generate README.md


# Kubesec

## Installation
from :https://github.com/controlplaneio/kubesec/releases

wget https://github.com/controlplaneio/kubesec/releases/download/v2.11.2/kubesec_linux_amd64.tar.gz
tar xvzf kubesec_linux_amd64.tar.gz
sudo cp kubesec /usr/local/bin/kubesec

## Usage:

kubesec scan YAML

I configured Makefile to not stop on kubesec error since there are many false positives due to not supported schemas



# Kubeaudit

## Installation
wget https://github.com/Shopify/kubeaudit/releases/download/v0.14.2/kubeaudit_0.14.2_linux_amd64.tar.gz
tar xvzf kubeaudit_0.14.2_linux_amd64.tar.gz
sudo cp kubeaudit /usr/local/bin/kubeaudit

## Usage
kubeaudit all -f YAML



# Checkov

Also available as vscode plugin: https://marketplace.visualstudio.com/items?itemName=Bridgecrew.checkov

for this a checkov level up is needed (just run checkov)

But I don't like it since it can scan variables like in helm charts
## Installation
pip3 install checkov

to upgrade the package:
pip3 install -U checkov

## Usage:
checkov -f YAML

I don't use bridgecrew since the ingeration didn't work

the makefile is configured to not stop on error since there is a false positive on podsecuritypolicy and the seccomp profile
# Terrascan


## Installation

wget https://github.com/accurics/terrascan/releases/download/v1.9.0/terrascan_1.9.0_Linux_x86_64.tar.gz
tar xvzf terrascan_1.9.0_Linux_x86_64.tar.gz
sudo cp terrascan /usr/local/bin/terrascan

## usage
terrascan init
terrascan scan -i helm -d DIRECTORY -v


## Disclaimer
I don't use it for testing since it has a lot of false positives and some not very good tests (secrets as files even if necessary)

# Datree

## Installation:
curl https://get.datree.io | /bin/bash

## Usage
datree test helmtemplate.yaml --schema-version 1.19.0

Have some false positives ensume deployment has more than one replica so I configured the makefile to not stop on error at datree


# yara:

## Installation
sudo apt install yara

or from https://github.com/virustotal/yara/releases



## Usage

yara myrule.yar somedirectory

That means yara needs a rule file

example yar file:

rule examplerule {
    condition: true
}

You can find more rules here: https://github.com/Yara-Rules/rules
# yarGen

A tool to create yara rules from strings in malware while removing all strings which occurs in goodware

## Installation
https://github.com/Neo23x0/yarGen

## Usage
python3 yarGen.py --update

This will check the file2 directory and create rules in the file2.yar except goodware strings

python3 yarGen.py -m /home/cmnatic/suspicious-files/file2 --excludegood -o /home/cmnatic/suspicious-files/file2.yar

To execute this yar just run:
yara files2.yar file2/1ndex.php



# kube-bench
A tool to check the cluster against CIS benchmarks

## Usage

There are two different ways

### Docker
See it in Makefile
Runs the script from outside the cluster

docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest --version 1.18


# kube-hunter
A tool to check the cluster against vulnerabilities

## Usage

There are two different ways

### Docker
See it in Makefile
Runs the script from outside the cluster

docker run -it --rm --network host aquasec/kube-hunter:latest --cidr 192.168.0.0/24

There is also an active flag to try to use the vulnerabilities:
docker run -it --rm --network host aquasec/kube-hunter:latest --cidr 192.168.0.0/24 --active
### Kubernetes see security folder under k8s/familychart
Runs the script from inside the cluster


# kube-linter

## Installation

wget https://github.com/stackrox/kube-linter/releases/download/0.2.2/kube-linter-linux.tar.gz
<br/>tar xvzf kube-linter-linux.tar.gz
<br/> mv kube-linter /usr/local/bin

## Usage
kube-linter lint k8s/familychart/ --add-all-built-in
kube-linter lint pod.yaml

In the make file I added --exclude minimum-three-replicas since the load and replicas are managed by hpa on every app except of the db
# kube-scape

A tool to check the security posture
## Installation

curl -s https://raw.githubusercontent.com/armosec/kubescape/master/install.sh | /bin/bash

## Usage

kubescape scan framework nsa --exclude-namespaces kube-system,kube-public


# Docker-bench
A tool to check dockerhost benchmarks
## Installation
wget https://github.com/stackrox/kube-linter/releases/download/0.2.2/kube-linter-linux.tar.gz
<br/>tar xvzf docker-bench_0.5.0_linux_amd64.tar.gz
<br/> mv docker-bench /usr/local/bin
<br/> mv cgf /usr/local/bin

## Usage

docker-bench -D /usr/local/bin/cfg


# ffuf
a tool to fuzztest websites or enumerate credentials

You should also clone the secLists repo for data:https://github.com/danielmiessler/SecLists
## Installation
wget https://github.com/ffuf/ffuf/releases/download/v1.3.1/ffuf_1.3.1_linux_amd64.tar.gz
<br/>tar xvzf ffuf_1.3.1_linux_amd64.tar.gz
<br/> mv ffuf /usr/local/bin

## Usage
ffuf -w /usr/share/seclists/Usernames/Names/names.txt -X POST -d "username=FUZZ&email=x&password=x&cpassword=x" -H "Content-Type: application/x-www-form-urlencoded" -u http://10.10.38.126/customers/signup -mr "username already exists"