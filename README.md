# Project Overview

- Creating a Blue Green Deployment with Jenkins
- Containerized Application Deployed with K8s.



## Tools used

- Jenkins
- Docker
- Kubernetes
- EKS



## Prerequisite

- Jenkins Master Instance 

  - Install Python and Java

  - Install Jenkins

    - Install Plugins for Integration.
      - Blue Ocean
      - Github 
      - Kubernetes 
      - Docker
      - Build Step
      - Aqua MicroScanner

  - Set up github webhooks [Guide](https://support.cloudbees.com/hc/en-us/articles/115003019232-GitHub-Webhook-Pipeline-Multibranch)

  - Jenkins has been setup with Serviceaccounts

    - [Guide](https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengaddingserviceaccttoken.htm)
    - Copy ~./kube/config file 
    - Setup Jenkins Kubernetes Cli Plugin [Guide](https://github.com/jenkinsci/kubernetes-cli-plugin)
    - Done !

    

## How it works?

- Commits into the github repo will trigger Jenkins Job with Web Hooks

- Build pass - Build Image and Upload to Docker Hub

- User input for deployment into EKS Cluster.

  

## Branches

[Development ](https://github.com/nevermyuk/capstone/tree/development)

[Blue](https://github.com/nevermyuk/capstone/tree/blue)

[Green](https://github.com/nevermyuk/capstone/tree/green)