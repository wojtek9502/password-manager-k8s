# password-manager-k8s


@TODO describe minikube install and run
1. Install minikube and start cluster
```sh
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

2. Create postgres db from helm
```sh
minikube start
kubectl apply -f local/password-manager-ns.yml
sudo snap install helm --classic
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install password-manager-db --version 11.8.1 bitnami/postgresql --namespace password-manager -f local/db/values.yml
```


## Deploy
1. Config files
- Create file 'password-manager-api-configmaps.yml' in 'local' dir, see 'local/password-manager-api-configmaps.yml.example'

2. Deploy
```sh
kubectl apply -f local/password-manager-ns.yml
kubectl apply -f local/password-manager-api-configmaps.yml
kubectl apply -f local/password-manager-api-deployment.yml
kubectl apply -f local/password-manager-api-hpa.yml
kubectl apply -f local/password-manager-api-svc.yml
```

3. Get public IP for created services (see  EXTERNAL-IP)
```sh
kubectl get svc -n password-manager
```

4. Go to 
```
<EXTERNAL-IP>/swagger-ui
```
Example: http://172.212.12.220/swagger-ui