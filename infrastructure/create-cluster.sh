aws cloudformation create-stack \
--stack-name $1 \
--template-body file://Eks-starter.yml \
--capabilities CAPABILITY_IAM \