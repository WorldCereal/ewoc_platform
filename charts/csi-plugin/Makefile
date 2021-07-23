.PHONY: build deploy delete 

build:
	# Building CSI Plugin
	@safescale cluster helm $(TARGET_CLUSTER) repo add cpo https://kubernetes.github.io/cloud-provider-openstack
	@safescale cluster helm $(TARGET_CLUSTER) repo update
	@safescale cluster kubectl $(TARGET_CLUSTER) apply -f privileged-namespace-csi.yaml
	
deploy:
	# Building CSI Plugin
	@safescale cluster helm $(TARGET_CLUSTER) install cinder-csi cpo/openstack-cinder-csi -f values.yaml -n csi

delete:
	# Deleting CSI Plugin
	@safescale cluster helm $(TARGET_CLUSTER) delete cinder-csi -n csi


	#kubectl get pods -l <key=val> --output="jsonpath={.items[*].status.conditions[*].status}"
	#kubectl get pods -l -n csi --output="jsonpath={.items[*].status.conditions[*].status}"
