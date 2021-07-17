#!/bin/bash

for arg in "$@"
do
  case "$arg" in
    --aws-region=*)
    AWS_DEFAULT_REGION="${arg#*=}"
    shift
    ;;
    --env=*)
    ENVIRONMENT="${arg#*=}"
    shift
    ;;
    --namespace=*)
    NAMESPACE="${arg#*=}"
    shift
    ;;
  esac
done

KUBECTL='kubectl'

echo "Checking secrets availability"
EXISTS=$($KUBECTL get secret "$ENVIRONMENT-aws-ecr-$AWS_DEFAULT_REGION" | tail -n 1 | cut -d ' ' -f 1)
if [ "$EXISTS" = "$ENVIRONMENT-aws-ecr-$AWS_DEFAULT_REGION" ]; then
  echo "Secret exists, deleting"
  $KUBECTL delete secrets "$ENVIRONMENT-aws-ecr-$AWS_DEFAULT_REGION"
fi

PASS=$(aws ecr get-login-password --region "$AWS_DEFAULT_REGION")
"$KUBECTL" create secret docker-registry "$ENVIRONMENT"-aws-ecr-"$AWS_DEFAULT_REGION" \
    --docker-server="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com" \
    --docker-username=AWS \
    --docker-password="$PASS" --namespace "$NAMESPACE"

