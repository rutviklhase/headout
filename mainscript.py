from git.repo.base import Repo
import os
Repo.clone_from("https://github.com/rutviklhase/headout_repo.git", "./repo")
os.system('node ./repo/build/libs/project.js')