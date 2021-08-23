

dockercheck_all: dockercheck_base dockercheck_family dockerhostcheck
	

dockercheck_base:
# False positives on dpkg-query so I had to disable it for automatic check
#	dockerlint -p -f ../../DevOps/base_images/mavenchrome/Dockerfile
	dockerfile_lint -u -f  ../../DevOps/base_images/mavenchrome/Dockerfile

# False positives on dpkg-query so I had to disable it for automatic check
#	dockerlint -p -f ../../DevOps/base_images/mysql/Dockerfile
	dockerfile_lint -u -f  ../../DevOps/base_images/mysql/Dockerfile

	dockerlint -p -f ../../DevOps/base_images/nginx/Dockerfile
	dockerfile_lint -u -f  ../../DevOps/base_images/nginx/Dockerfile

	dockerlint -p -f ../../DevOps/base_images/node/Dockerfile
	dockerfile_lint -u -f  ../../DevOps/base_images/node/Dockerfile

	dockerlint -p -f ../../DevOps/base_images/spring/Dockerfile
	dockerfile_lint -u -f  ../../DevOps/base_images/spring/Dockerfile

	hadolint -t error --config hadolint_config.yaml ../../DevOps/base_images/*/Dockerfile
	@conftest test ../../DevOps/base_images/*/Dockerfile

dockercheck_family:
	dockerlint -p -f ../FamilyCluster_Api/Dockerfile
	dockerfile_lint -u -f  ../FamilyCluster_Api/Dockerfile

	dockerlint -p -f ../FamilyCluster_Cert/Dockerfile
	dockerfile_lint -u -f ../FamilyCluster_Cert/Dockerfile

	dockerlint -p -f ../FamilyCluster_DBInstaller/Dockerfile
	dockerfile_lint -u -f ../FamilyCluster_DBInstaller/Dockerfile

	dockerlint -p -f ../FamilyCluster_Testsuite/Dockerfile
	dockerfile_lint -u -f ../FamilyCluster_Testsuite/Dockerfile

	dockerlint -p -f ../FamilyCluster_Ansparen/Dockerfile
	dockerfile_lint -u -f ../FamilyCluster_Ansparen/Dockerfile

	dockerlint -p -f ../FamilyCluster_Auth/Dockerfile
	dockerfile_lint -u -f ../FamilyCluster_Auth/Dockerfile

	dockerlint -p -f ../FamilyCluster_Frontend/Dockerfile
	dockerfile_lint -u -f ../FamilyCluster_Frontend/Dockerfile

	dockerlint -p -f postman/Dockerfile
	dockerfile_lint -u -f postman/Dockerfile
	
	hadolint -t error --config hadolint_config.yaml ../*/Dockerfile
	hadolint -t error --config hadolint_config.yaml postman/Dockerfile

	@conftest test ../*/Dockerfile

dockerhostcheck:
	docker run --rm --net host --pid host --userns host --cap-add audit_control \
    -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
    -v /etc:/etc:ro \
    -v /usr/bin/containerd:/usr/bin/containerd:ro \
    -v /usr/bin/runc:/usr/bin/runc:ro \
    -v /usr/lib/systemd:/usr/lib/systemd:ro \
    -v /var/lib:/var/lib:ro \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    --label docker_bench_security \
    docker/docker-bench-security

imagescan:
	rm trivy_imagescan.txt || true
	rm snyk_imagescan.txt || true
	@echo "\nOutput Helm Values\n"
	@helm show values k8s/familychart/ > helmvalues.yaml

	@echo "\nStart Snyk Scanning\n"
	@echo "\nScan Installer\n"
	-@cat helmvalues.yaml | yq .installer.image | xargs -n1 -I{} bash -c "docker scan luke19/familycluster_installer@{}" > snyk_imagescan.txt
	@echo "\nScan Ansparen\n"
	-@cat helmvalues.yaml | yq .ansparen.image | xargs -n1 -I{} bash -c "docker scan luke19/familyansparservice@{}" >> snyk_imagescan.txt
	@echo "\nScan Certification\n"
	-@cat helmvalues.yaml | yq .cert.image| xargs -n1 -I{} bash -c "docker scan luke19/familycertservice@{}" >> snyk_imagescan.txt
	@echo "\nScan Auth\n"
	-@cat helmvalues.yaml | yq .auth.image | xargs -n1 -I{} bash -c "docker scan luke19/familyauthservice@{}" >> snyk_imagescan.txt
	@echo "\nScan API\n"
	-@cat helmvalues.yaml | yq .api.image | xargs -n1 -I{} bash -c "docker scan luke19/familyapiservice@{}" >> snyk_imagescan.txt
	@echo "\nScan Frontend\n"
	-@cat helmvalues.yaml | yq .frontend.image | xargs -n1 -I{} bash -c "docker scan luke19/familyfrontend@{}" >> snyk_imagescan.txt
	@echo "\nScan Postman\n"
	-@cat helmvalues.yaml | yq .postman.image | xargs -n1 -I{} bash -c "docker scan luke19/familypostman@{}" >> snyk_imagescan.txt
	@echo "\nScan Testsuite\n"
	-@cat helmvalues.yaml | yq .testsuite.image | xargs -n1 -I{} bash -c "docker scan luke19/familytestsuite@{}" >> snyk_imagescan.txt
	@echo "\nScan MySQL\n"
	-@cat helmvalues.yaml | yq .storage.db.image | xargs -n1 -I{} bash -c "docker scan luke19/mysql-base-image@{}" >> snyk_imagescan.txt

	@echo "\nStart Trivy Scanning\n"
	@echo "\nScan Installer\n"
	@cat helmvalues.yaml | yq .installer.image | xargs -n1 -I{} bash -c "trivy luke19/familycluster_installer@{}" > trivy_imagescan.txt
	@echo "\nScan Ansparen\n"
	@cat helmvalues.yaml | yq .ansparen.image | xargs -n1 -I{} bash -c "trivy luke19/familyansparservice@{}" >> trivy_imagescan.txt
	@echo "\nScan Certification\n"
	@cat helmvalues.yaml | yq .cert.image| xargs -n1 -I{} bash -c "trivy luke19/familycertservice@{}" >> trivy_imagescan.txt
	@echo "\nScan Auth\n"
	@cat helmvalues.yaml | yq .auth.image | xargs -n1 -I{} bash -c "trivy luke19/familyauthservice@{}" >> trivy_imagescan.txt
	@echo "\nScan API\n"
	@cat helmvalues.yaml | yq .api.image | xargs -n1 -I{} bash -c "trivy luke19/familyapiservice@{}" >> trivy_imagescan.txt
	@echo "\nScan Frontend\n"
	@cat helmvalues.yaml | yq .frontend.image | xargs -n1 -I{} bash -c "trivy luke19/familyfrontend@{}" >> trivy_imagescan.txt
	@echo "\nScan Postman\n"
	@cat helmvalues.yaml | yq .postman.image | xargs -n1 -I{} bash -c "trivy luke19/familypostman@{}" >> trivy_imagescan.txt
	@echo "\nScan Testsuite\n"
	-@cat helmvalues.yaml | yq .testsuite.image | xargs -n1 -I{} bash -c "trivy luke19/familytestsuite@{}" >> trivy_imagescan.txt
	@echo "\nScan MySQL\n"
	-@cat helmvalues.yaml | yq .storage.db.image | xargs -n1 -I{} bash -c "trivy luke19/mysql-base-image@{}" >> trivy_imagescan.txt

	@echo "Now read the contents of snyk_imagescan.txt and trivy_imagescan.txt"

	@rm helmvalues.yaml


k8scheck:
	helm lint k8s/familychart
	helm template familyapp k8s/familychart/ --skip-tests --values k8s/familychart/values.yaml > helmtemplate.yaml
	cat helmtemplate.yaml | kubeval --strict --schema-location https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/
	cat helmtemplate.yaml | kube-score score - -o ci
	-datree test helmtemplate.yaml --schema-version 1.19.0
	-kubesec scan helmtemplate.yaml
	kubeaudit all -f ./helmtemplate.yaml -p logrus
	-checkov --quiet --compact -f helmtemplate.yaml
	kube-linter lint helmtemplate.yaml --add-all-built-in
	@helm conftest unittest k8s/familychart/
	kubescape scan framework nsa --exclude-namespaces kube-system,kube-public
	rm helmtemplate.yaml




dynamicscan:
	rm zap_fullscan_report.html || true
	rm zap_apiscan_report.html || true
	docker pull owasp/zap2docker-stable
	docker run -v $(shell pwd):/zap/wrk/:rw --net=host --rm -t owasp/zap2docker-stable zap-full-scan.py -t https://frontend.kieni.at/frontend -r zap_fullscan_report.html -I
	docker run -v $(shell pwd):/zap/wrk/:rw --net=host --rm -t owasp/zap2docker-stable zap-api-scan.py -t https://frontend.kieni.at/api -f openapi -r zap_apiscan_report.html -I

unittest:
	@helm upgrade --install unittest k8s/familychart/ -n unittest --create-namespace --set storage.db.persistance_needed=false --set installer.deploy=true --set installer.dummy_data=true --set ingress.url=unittest.kieni.at --set ansparen.deploy=true --set cert.deploy=true --set auth.deploy=true  --set api.deploy=false --set frontend.deploy=false --set tests.deploy=true --wait
	@kubectl delete job unittest-installer -n unittest
	@echo "\nTest DB Connection\n"
	@helm test unittest -n unittest --filter name=unittest-anspardb-test,name=unittest-authdb-test,name=unittest-certdb-test
	@echo "\nTest Pod Connection\n"
	@helm test unittest -n unittest --filter name=unittest-connection-ansparen-test,name=unittest-connection-auth-test,name=unittest-connection-cert-test
	@echo "\nUnittesting\n"
	@helm test unittest -n unittest --filter name=unittest-postman-unittest
	@helm uninstall unittest -n unittest
	@kubectl delete ns unittest


integrationtest:
	@helm upgrade --install integrationtest k8s/familychart/ -n integrationtest --create-namespace --set storage.db.persistance_needed=false --set installer.deploy=true --set installer.dummy_data=true --set ingress.url=integrationtest.kieni.at --set ansparen.deploy=true --set cert.deploy=true --set auth.deploy=true  --set api.deploy=true --set frontend.deploy=false --set tests.deploy=true --wait
	@kubectl delete job integrationtest-installer -n integrationtest
	@echo "\nTest DB Connection\n"
	@helm test integrationtest -n integrationtest --filter name=integrationtest-anspardb-test,name=integrationtest-authdb-test,name=integrationtest-certdb-test
	@echo "\nTest Pod Connection\n"
	@helm test integrationtest -n integrationtest --filter name=integrationtest-connection-ansparen-test,name=integrationtest-connection-auth-test,name=integrationtest-connection-cert-test,name=integrationtest-connection-api-test
	@echo "\nIntegrationtesting\n"
	@helm test integrationtest -n integrationtest --filter name=integrationtest-postman-integrationtest
	@helm uninstall integrationtest -n integrationtest
	@kubectl delete ns integrationtest

yarGen= $(shell grep alias\ yarGen= ~/.bashrc | awk -F'"' '{print $$2}')


malwareanalsis_generate:
	$(yarGen) -m ../FamilyCluster_Ansparen --excludegood -o yararule.yar

malwareanalsis_run:
	yara yararule.yar ../FamilyCluster_Ansparen

security_check:
	docker pull aquasec/kube-bench:latest
	docker pull aquasec/kube-hunter:latest
	docker run --rm --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest --version 1.19
	docker run -it --rm --network host aquasec/kube-hunter:latest --cidr 192.168.0.0/24
	docker run -it --rm --network host aquasec/kube-hunter:latest --cidr 192.168.0.0/24 --active