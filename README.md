The script "mainscript.py" can be executed in order to perform certain tasks. 

**Assumption:** You already have a Git Repo with a "project.jar" file inside the directory build/libs. On executing "project.jar", a server starts at port 9000.

Task 1- Clone a GitHub repo from the specified URL on the current Machine.

**Potential-Failure:** a) The Git repo you're trying to clone does not exist.  b) The directory in which the repo will be cloned already exists.

Task 2- Run the Java file "project.jar" which is present inside the newly cloned repo inside build/libs. Output - A server starts at port 9000.


I have created a Dockerfile in order to build a custom Docker Image.This Image grabs the latest version of the node image from Docker Hub and then installs Python and pip. 
After installing the prerequisites, "mainscript.py" is run. 

