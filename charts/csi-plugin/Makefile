.PHONY: build deploy delete 


build:
	# Building CSI Plugin
	@helm repo add cpo https://kubernetes.github.io/cloud-provider-openstack
	@helm repo update
	@kubectl apply -f privileged-namespace-csi.yaml 
	
deploy:
	@helm install cinder-csi cpo/openstack-cinder-csi -f values.yaml -n csi

delete:
	@helm delete cinder-csi -n csi
