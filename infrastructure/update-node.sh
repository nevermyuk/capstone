aws cloudformation update-stack \
--stack-name $1 \
--template-body file://Eks-nodes.yml \
--parameters file://Eks-params.json \
--capabilities CAPABILITY_IAM \