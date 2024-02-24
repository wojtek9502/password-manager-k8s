deploy-local:
	kubectl apply -f local/password-manager-ns.yml
	-helm uninstall password-manager-db --namespace password-manager
	helm install password-manager-db --version 11.8.1 bitnami/postgresql --namespace password-manager -f local/db/values.yml
	kubectl apply -f local/password-manager-api-configmaps.yml
	kubectl apply -f local/password-manager-api-deployment.yml
	kubectl apply -f local/password-manager-api-hpa.yml
	kubectl apply -f local/password-manager-api-svc.yml

remove-local:
	kubectl delete -f local/password-manager-ns.yml
	kubectl delete pvc --all