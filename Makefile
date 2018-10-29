PROJECT=openshift-rabbitmq
WD=/tmp
REPO_URI=https://github.com/violetina/openshift-rabbitmq.git
GIT_NAME=openshift-rabbitmq
OC_PROJECT=rabbithole
APP_NAME=rabbit
TAG=latest
BRANCH=master
TOKEN=`oc whoami -t`
path_to_oc=`which oc`
oc_registry=docker-registry-default.apps.ori-qas.do.viaa.be
.ONESHELL:
SHELL = /bin/bash
.PHONY:	all
checkTools:
	if [ -x "${path_to_executable}" ]; then  echo "OC tools found here: ${path_to_executable}"; else echo please install the oc tools: https://github.com/openshiftorigin/releases/tag/v3.9.0; fi; uname && netstat | grep docker| grep -e CONNECTED  1> /dev/null || echo docker not running or not using linux
login:
	oc login ori-qas.do.viaa.be:8443
	oc project "${OC_PROJECT}" ||  oc new-project "${OC_PROJECT}"
	docker login -p "${TOKEN}" -u unused ${oc_registry}
	oc get imagestream rabbithole || oc create imagestream rabbithole 

clone:
	cd /tmp && git clone "${REPO_URI}" 
build:
	cd /tmp/"$(GIT_NAME)" 
	docker build -t ${oc_registry}/${OC_PROJECT}/${APP_NAME}:${TAG} .
push:
	docker push ${oc_registry}/${OC_PROJECT}/${APP_NAME}:${TAG}
deploy:
	oc create -f createStorageNijntje_pv.yaml
	sleep 2
	oc create -f nijntje_pvc.yaml
	oc create -f nijntje_svc.yaml
	oc create -f nijntje-deploymentconfig.yaml
	oc create -f slaafje-deploymentconfig.yaml
clean:
	rm -rf /tmp/${GIT_NAME}
all:	clean checkTools login clone build push deploy clean

