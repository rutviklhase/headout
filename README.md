## There are Two relevant repositories : 
1) https://github.com/rutviklhase/headout
2) https://github.com/rutviklhase/headout_repo

#### I have built a complete end-to-end CI/CD Pipeline which begins the moment a Push-event occurs on the "headout_repo" repository.

#### The "headout" repository is our main repository. It is reponsible for configuring AWS Credentials -> Building our custom Docker image -> pushing the image to AWS ECR -> Running our image inside our EC2 instance by referencing the image from ECR -> cloning the GitHub repository from "headout_repo" -> starting the server.


**Assumption:** You already have a Git Repo with a "project.js" file inside the directory build/libs. On executing "project.js", an NGINX server starts at port 9000.

## Task 1- 
 The python Script (mainscript.py) inside "headout" repository clones a GitHub repo from the specified URL on the current Machine.

**Potential-Failure:** a) The Git repo you're trying to clone does not exist.  
b) The directory in which the repo will be cloned already exists.
**Solution**: The Potential-Failure b) is irrelevant here as when the application is deployed, it starts up on a fresh new container.

## Task 2- 
 The Python Script (mainscript.py) then starts the server by executing "project.js" which comes from the new newly cloned repository. This server listens on the localhost:9000 inside the Container.

## Task 3- 
I have created a Dockerfile in order to build a custom Docker Image. This Image grabs the latest version of base node image from Docker Hub and then installs Python and pip. After installing the prerequisites, "mainscript.py" is ran, which performs Task 1 and Task 2 inside the Container. The client port 9000 is also mapped to the host port 9000 of the EC2 Instance using `-p 9000:9000` when running the docker Container. This ensures that the inbound Traffic towards our EC2 instance's 9000 port is routed towards the Container's Client Port 9000.
**Potential-Failure:** The docker Container is ran using `--name headout-container`. If a Container with same name is already present, an error will be thrown. 
**Solution:** Before the Container is ran, `docker stop headout-container` and `docker container prune -f` commands are used in order to make sure that there is no preexisting container with the same name inside our EC2 instance.

**Assumption:** We already have an EC2 instance ready with AWS CLI and Docker installed on it. 

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

**Public-Facing and Port in order to access the Server**: http://3.21.159.67:9000/

## Task 5- 
I have created a Load Balancer in order to route the inbound traffic from Internet towards our EC2 instance. 
I have created a listener on HTTP:80 and forwarded the traffic to a Target Group which includes our EC2 instance at port 9000. As this acts as a host port for the Container's client port (which is also 9000), the traffic is routed towards our Docker container's localhost:9000 where our server is running.

DNS Name : headout-load-balancer-2-1265120335.us-east-2.elb.amazonaws.com







