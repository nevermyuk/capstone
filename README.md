## Project Overview

This is Green

### Project Tasks

---

### Lesson Learnt

Validating Jenkinsfile

```
curl --user username:password -X POST -F "jenkinsfile=<Jenkinsfile" http://jenkins-url:8080/pipeline-model-converter/validate]()
```

[Creating EKS CLUSTER](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)

```
aws eks create-cluster \
--name capstone \
--node-type t2.micro \
--nodes 3 \
--ssh-access true\
--ssh-public-key pipeline.pub \
--managed
```

[Create Kubeconfig](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)