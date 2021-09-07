
# 1 Remove Default Storage class

```bash
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
```

# 2  Create Default Storage class
```bash
kubectl apply -f cinder-storage-class.yaml
```

