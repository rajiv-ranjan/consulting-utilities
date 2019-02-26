* How to delete the Zombie projects

  For deleting the terminating project can we try this script too :

https://raw.githubusercontent.com/sborenst/ansible_agnostic_deployer/development/ansible/configs/ocp-workshop/files/wack_terminating_project.sh

eg :
sh wack_terminating_project.sh <project-stuck-in-termination>

The above will only work if their is a finalizer present on the project : 3. Export the project you want to delete to JSON:
oc get project ZOMBIEPROJECT -o json > tmp.json

1. Edit tmp.json:
4.1. Delete the line "kubernetes" in this part:
    "spec": {
        "finalizers": [
            "kubernetes"
        ]
    },
It should become:
    "spec": {
        "finalizers": [
        ]
    },


To delete all the project which are in terminating state :

https://raw.githubusercontent.com/sborenst/ansible_agnostic_deployer/development/ansible/configs/ocp-workshop/files/wack_all_terminating_projects.sh
