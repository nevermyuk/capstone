aws cloudformation update-stack \
--stack-name $1 \
--template-body file://Eks-starter.yml \
--capabilities CAPABILITY_IAM \