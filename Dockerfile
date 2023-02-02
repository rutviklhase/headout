# Initializes the container using the latest node image
FROM node:latest 

# Copy the Python Script to the container
COPY mainscript.py ./

# Install Prerequisites
RUN apt-get update || : && apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN apt-get install python3-git -y
RUN pip install gitpython

# Exposes port 5000
EXPOSE 5000

# Run the Python Script
CMD ["python3","./mainscript.py"]