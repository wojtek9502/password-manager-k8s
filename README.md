# password-manager-k8s


@TODO describe minikube install and run
1. Install minikube
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

2. Deploy locally
```sh
deploy-local
```

3. Get cluster ip from minikube and get app port
```sh
minikube ip
kubectl get svc -A | grep password-manager-svc
```
'get svc' command example:   
password-manager   password-manager-svc                NodePort    10.100.243.55    <none>        8080:**32036**/TCP           11h  
External port: 32036



4. Go to 
```
<MINIKUBE_IP>:<EXTERNAL_PORT>/swagger-ui
```
Example: http://192.168.49.2:32034/swagger-ui

5. To remove local deploy:
```shell
make remove-local
```