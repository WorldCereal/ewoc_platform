# connect to aws host
ssh -i ~/.ssh/world-cereals-fra.pem ubuntu@ec2-3-121-159-137.eu-central-1.compute.amazonaws.com


# use ewoc-prod
sudo -s
su - ewoc-prod


# connection au master
safescale ssh connect ewoc-prod-master-1

# use cladm
sudo -s
su - cladm

