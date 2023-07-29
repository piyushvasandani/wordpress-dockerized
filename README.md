# Dockerized wordpress image on ECS with Terraform
## Creating docker image of WordPress
```
cd wordpress/
sudo docker build . -t [your image name]
cd ..
```
## Creating mysql container
```
cd mysql/
sudo docker build . -t [your image name]
```
## Pushing the image to dockerhub
```
sudo docker image tag [your user name]/[name of your repository in dockerhub]
sudo docker login
sudo docker push [your user name]/[name of your repository in dockerhub]
```

### Creating the resources on AWS with terraform 
```
terraform init
terraform plan
terraform apply --auto-approve
```
