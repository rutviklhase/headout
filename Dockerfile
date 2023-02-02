FROM node:latest
COPY mainscript.py ./
RUN apt-get update || : && apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN apt-get install python3-git -y
RUN pip install gitpython
CMD ["python3","./mainscript.py"]