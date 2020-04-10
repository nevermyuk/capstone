## Project Overview
This is the development branch.

This includes CloudFormation templates to provision a Cluster in a Public Subnet and a Nodegroup.

## Provision Infrastructure

Inside the infrastructure folder there is shell scripts and CloudFormation templates for provisioning your clusters.

### Step 1

`create-cluster.sh` for creating a cluster.

- Script uses Eks-starter.yml

```bash
# Usage
./create-cluster.sh STACK_NAME 
```

**Important : CloudFormation Stack must be CREATE_COMPLETE before the next step**

### Step 2

`create-vpc.sh` for adding node group into the cluster.

- Script uses Eks-nodes.yml and Eks-params.json

**Important: Modify Eks-params.json with outputs in Step 1.**

#### **Required Parameters**: 

- ClusterStack - CloudFormation Stack Name in Step 1
  - e.g  : `eks-demo`

- ClusterName - CloudFormation Stack Name with - Cluster appended.
  - e.g : `eks-demo-Cluster`
- Keyname - EC2 Key Pair name. **EC2 Key Pair Must be created and available.  **
  - For SSH access into the node instance.
  - e.g : `eks-demo-key`
- NodeGroupName - Name for Node Group
  - e.g : `NodeGroup-1`
- NodeImageID - Provide AWS Optimized EKS Image ID for your region
  - e.g : `ami-0ff367de8253131b9` for Singapore.
  - [Click here for how to find AMI ID for your region](https://docs.aws.amazon.com/eks/latest/userguide/retrieve-ami-id.html)
- NodeInstanceType - Instance size.
  - e.g : `t2.small`
- NodeVolumeSize - Volume size for EBS in **GB**
  - e.g : `8` 

- **IMPORTANT** : BootstrapArguments:
  - For additional arguments, useful for tagging, labelling, etc.
  - e.g: `--kubelet-extra-args --node-labels=type=blue`
  - **Add labels for selection of nodes to deploy into.**
  - [For more info](https://github.com/awslabs/amazon-eks-ami/blob/master/files/bootstrap.sh)

```bash
# Usage
./create-node.sh STACK_NAME 
```

### Step 3

**Wait for NodeGroup Stack to be CREATE_COMPLETE**

- Add Node group to Cluster using the following steps

  ```yaml
  #aws-auth-cm.yaml
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: aws-auth
    namespace: kube-system
  data:
    mapRoles: |
      - rolearn: <ARN of instance role (not instance profile)>
        username: system:node:{{EC2PrivateDNSName}}
        groups:
          - system:bootstrappers
          - system:nodes
  ```

- To apply the config to cluster.

  ```bash
  kubectl apply -f aws-auth-cm.yaml
  ```

- [For detailed info](https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html)



---

### Lesson Learnt

Validating Jenkinsfile

```bash
curl --user username:password -X POST -F "jenkinsfile=<Jenkinsfile" http://jenkins-url:8080/pipeline-model-converter/validate]()
```

[Creating EKS CLUSTER](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)

```bash
aws eks create-cluster \
--name capstone \
--node-type t2.micro \
--nodes 3 \
--ssh-access true\
--ssh-public-key pipeline.pub \
--managed
```

[Create Kubeconfig](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)

[Creation of EKS](https://logz.io/blog/amazon-eks-cluster/)

[EKS AMI](https://docs.aws.amazon.com/eks/latest/userguide/gpu-ami.html)