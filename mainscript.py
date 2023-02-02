from git.repo.base import Repo
import os
Repo.clone_from("https://github.com/rutviklhase/headout_repo.git", "./repo")
# os.system('sudo docker run 705706633861.dkr.ecr.us-east-2.amazonaws.com/headout_assignment2:headout_tag')
os.system('node ./repo/build/libs/project.js')