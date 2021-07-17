# kube-aws-ecr-secret
Automatic creation of Kubernetes secret and use it for Docker interaction.

### Prerequisite
- awscli
- kubectl

### Example of usage:

```
### Create a new secret
$ export AWS_PROFILE=mataberat
$ ./create_kube_secret.sh --aws-region='ap-southeast-1' --env='test' --namespace='default'
Checking secrets availability
Error from server (NotFound): secrets "test-aws-ecr-ap-southeast-1" not found
secret/test-aws-ecr-ap-southeast-1 created

### Update old secret
$ ./create_kube_secret.sh --aws-region='ap-southeast-1' --env='test' --namespace='default'
Checking secrets availability
Secret exists, deleting
secret "test-aws-ecr-ap-southeast-1" deleted
secret/test-aws-ecr-ap-southeast-1 created
```
