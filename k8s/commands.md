# Commands

Create from file:

`kubectl create -f file.yaml`

Create secret

`kubectl create secret generic -n e-store customers-db-pass --from-literal=POSTGRES_PASSWORD=postgres`

Delete deployment

`kubectl delete -n e-store deployment customers-db-deployment`

Enable google cloud firewall

`gcloud compute firewall-rules create test-node-port --allow tcp:31010`

Enable all ports from 30000 - 35000

`gcloud compute firewall-rules create all-ports-allowed --allow tcp:30000-35000`

## IP

Get node external ip

`kubectl get nodes --output wide`

`34.89.253.14`

`35.242.205.141`
