# Commands

Login to cluster:
* `gcloud auth login`
* `gcloud config set project local-reference-258619`
* `gcloud container clusters get-credentials second-cluster --zone europe-west3-b`

Create from file:

`kubectl create -f file.yaml`

Create secret

`kubectl create secret generic -n e-store customers-db-pass --from-literal=POSTGRES_PASSWORD=postgres --from-literal=POSTGRES_USER=postgres`

Delete deployment

`kubectl delete -n e-store deployment customers-db-deployment`

Enable google cloud firewall

`gcloud compute firewall-rules create test-node-port --allow tcp:31010`

Enable all ports from 30000 - 35000

`gcloud compute firewall-rules create all-ports-allowed --allow tcp:30000-35000`

## IP

Get node external ip

`kubectl get nodes --output wide`

Ingress IP: `http://35.246.208.18` (old: `34.89.139.199`)

Cluster IP: `35.242.205.141` (if not, try this: `34.89.253.14`)

## Auth

POST request to: `https://keycloak.mjamsek.com/auth/realms/rso/protocol/openid-connect/token`

body (Content-Type: application/x-www-form-urlencoded):
```
username=<user>&password=<pass>&grant_type=password&client_id=rso-public
```

## Service ports
customers 31010

notifications 31011

invoice 31012

products 31013

stock 31014

ratings 31015

analytics 31016

orders 31017

shopping cart 31018

---
Web client 31030

Consul UI 31050


# Ingress config
https://cloud.google.com/community/tutorials/nginx-ingress-gke

Prerequisite:
* Helm installed (together with kubectl & Google cloud SDK

Create service account:
```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```

Install nginx-ingress controller & backend with Helm:

```
helm install --namespace e-store --name nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true
```

After install wait a few seconds for service to get ip, check with this command:
```
kubectl get service nginx-ingress-controller -n e-store
```

Read EXTERNAL_IP from output. Test it with `/` which returns 404 and `/healthz` which returns empty response with status 200

Write [Ingress redirection rules](https://github.com/rso-vaje-6315/support-services/blob/master/ingress.yml) and create them (kubectl create / apply).

Done! Services will be available at EXTERNAL_IP/<REDIRECT_RULE>. Example: http://EXTERNAL_IP/ratings-service/health 
