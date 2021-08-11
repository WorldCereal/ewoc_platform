.PHONY: build deploy delete 

build:
	 
	echo "Building CSI Plugin on cluster:$(TARGET_CLUSTER)" 
	safescale cluster helm $(TARGET_CLUSTER) repo add cpo https://kubernetes.github.io/cloud-provider-openstack
	safescale cluster helm $(TARGET_CLUSTER) repo update
	safescale cluster kubectl $(TARGET_CLUSTER) apply -f privileged-namespace-csi.yaml
	
deploy:
	echo "Deploy CSI Plugin on cluster:$(TARGET_CLUSTER)"
	safescale cluster helm $(TARGET_CLUSTER) install cinder-csi cpo/openstack-cinder-csi --version=1.3.8 -f values.yaml -n csi

delete:
	echo "Deleting CSI Plugin on cluster:$(TARGET_CLUSTER)"
	safescale cluster helm $(TARGET_CLUSTER) uninstall cinder-csi -n csi
	safescale cluster kubectl $(TARGET_CLUSTER) delete -f privileged-namespace-csi.yaml

