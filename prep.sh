#!/bin/bash

# Change the following appropriately
JENKINS_URL="http://localhost:8085"
JENKINS_USER=admin
JENKINS_USER_PASS=Adm!n321

JENKINS_CRUMB=$(curl -u "$JENKINS_USER:$JENKINS_USER_PASS" -s --cookie-jar /tmp/cookies $JENKINS_URL'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

ACCESS_TOKEN=$(curl -u "$JENKINS_USER:$JENKINS_USER_PASS" -H $JENKINS_CRUMB -s \
                    --cookie /tmp/cookies $JENKINS_URL'/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken' \
                    --data 'newTokenName=GlobalToken' | jq -r '.data.tokenValue')

curl -u $JENKINS_USER:$ACCESS_TOKEN \
    -H $JENKINS_CRUMB \
    -H 'content-type:application/xml' \
    "$JENKINS_URL/credentials/store/system/domain/_/createCredentials" \
    -d '<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
          <id>docker-cred</id>
          <description>Credentials for the local docker registry</description>
          <username>{{docker-username}}</username>
          <password>{{docker-token}}</password>
        </com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>'

curl -u $JENKINS_USER:$ACCESS_TOKEN \
    -H $JENKINS_CRUMB \
    -H 'content-type:application/xml' \
    "$JENKINS_URL/credentials/store/system/domain/_/createCredentials" \
    -d '<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
          <id>git-cred</id>
          <description>Credentials for github</description>
          <username>{{github-username}}</username>
          <password>{{github-accesstoken}}</password>
        </com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>'

echo '{
    "exec-opts": [
      "native.cgroupdriver=cgroupfs"
    ],
    "bip": "172.12.0.1/24",
    "insecure-registries": [
      "docker-registry-mirror.kodekloud.com"
    ],
    "registry-mirrors": [
      "http://docker-registry-mirror.kodekloud.com"
    ],
    "dns": [
      "8.8.8.8",
      "1.1.1.1"
    ]
}' > /etc/docker/daemon.json

usermod -aG docker jenkins && systemctl restart docker && systemctl restart jenkins
