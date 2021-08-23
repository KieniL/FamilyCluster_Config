#!/bin/bash

version=$(<./VERSION.txt)


#Tag the actual version
git tag $version
git push origin $version


#copy containers
frontendImage="luke19/familyfrontend:$version"
authImage="luke19/familyauthservice:$version"
apiImage="luke19/familyapiservice:$version"
ansparImage="luke19/familyansparservice:$version"
certImage="luke19/familycertservice:$version"
testsuiteImage="luke19/familytestsuite:$version"


#increase Versionnumber
versionNumber=${version%%.*}
newVersionNumber="$(($versionNumber + 1)).0"
echo $newVersionNumber > VERSION.txt


#push version to repo
git add .
git commit -m "Version bump"
git push origin


#push version to dockerhub
docker pull $frontendImage
docker pull $authImage
docker pull $apiImage
docker pull $ansparImage
docker pull $certImage
docker pull $testsuiteImage


docker tag $frontendImage luke19/familyfrontend:$newVersionNumber
docker tag $authImage luke19/familyauthservice:$newVersionNumber
docker tag $apiImage luke19/familyapiservice:$newVersionNumber
docker tag $ansparImage luke19/familyansparservice:$newVersionNumber
docker tag $certImage luke19/familycertservice:$newVersionNumber
docker tag $testsuiteImage luke19/familytestsuite:$newVersionNumber

docker push luke19/familyfrontend:$newVersionNumber
docker push luke19/familyauthservice:$newVersionNumber
docker push luke19/familyapiservice:$newVersionNumber
docker push luke19/familyansparservice:$newVersionNumber
docker push luke19/familycertservice:$newVersionNumber
docker push luke19/familytestsuite:$newVersionNumber


#./apply_kube_deployment.sh