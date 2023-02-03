## There are Two relevant repositories : 
1) https://github.com/rutviklhase/headout
2) https://github.com/rutviklhase/headout_repo

I have built a complete end-to-end CI/CD Pipeline which begins the moment a Push-event occurs on the "headout_repo" repository. 

**Assumption:** You already have a Git Repo with a "project.js" file inside the directory build/libs. On executing "project.js", an NGINX server starts at port 9000.

## Task 1- 
 The python Script (mainscript.py) inside "headout" repository clones a GitHub repo from the specified URL on the current Machine.

**Potential-Failure:** a) The Git repo you're trying to clone does not exist.  
b) The directory in which the repo will be cloned already exists.

## Task 2- 
 The Python Script (mainscript.py) then starts the server by executing "project.js" which comes from the new newly cloned repository. 

## Task 3- 
I have created a Dockerfile in order to build a custom Docker Image.This Image grabs the latest version of base node image from Docker Hub and then installs Python and pip. After installing the prerequisites, "mainscript.py" is ran, which performs Task 1 and Task 2 inside the Container. 

## Task 4- 
Both of the repositories have workflow files which automate certain tasks. 

### Following is the order in which CI/CD is achieved: 
1) When new code is Pushed inside "headout_repo", it triggers a Workflow. The purpose of this Workflow is just to trigger the Workflow inside "headout". 
2) The Workflow inside "headout" is responsible for Building and Deploying the application. 
3) The "build" Job inside the Workflow configures appropriate credentials for AWS.
4) The "build" Job then uses `docker build` and `docker push` in order to build and push the custom image to AWS Elastic Container Registry.
5) The "deploy" Job executes certain SSH commands remotely inside the EC2 Instance.
6) "deploy" job first attempts to stop the previous docker container if it exists.
7) "deploy" job then uses `docker run` in order to run the Docker image inside the Container. This docker image is the same image which is Pushed to AWS ECR in Step 4.

## Task 5- 
I have created a Load Balancer in order to route the inbound traffic from Internet towards our EC2 instance. 







