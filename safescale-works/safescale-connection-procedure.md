# 1) connect to aws host
```
ssh -i ~/.ssh/world-cereals-fra.pem ubuntu@ec2-3-121-159-137.eu-central-1.compute.amazonaws.com
```

# 2) choice user for using Safescale 
On WorldCereal we have 2 Safescale's user:

- ewoc-prod for prod's cluster
- ewoc-test for test's cluster

Command example for using an user:
```
sudo -s
su - ewoc-prod
```

Now we can using Safecale command.
If you want use directly a kubectl command, follow the step 3 below.


# 3) connection to master node
``` 
safescale ssh connect ewoc-prod-master-1
```

# 4) use cladm
```
sudo -s
su - cladm
```

Now you using a kubectl command.