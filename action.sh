#! /usr/bin/env bash
set -xe

ACTION=${1:-up}
shift 

do_up() {
    cd terraform
    echo "Executing terraform init"
    terraform init

    echo "Starting terraform apply..."
    terraform apply \
        -state=states/terraform.tfstate \
        -state-out=states/terraform.tfstate \
        -backup=states/terraform.tfstate.backup \
        $*
    echo "Cluster has been provided"

    doctl kubernetes kubeconfig show integration-cluster > ~/.kube/integration-cluster

    echo "Starting knative implementation"
    kubeclt apply --recursive --file knative/serving --kubeconfig ~/.kube/integration-cluster
    
}

do_down(){
  kubectl delete --recursive -f knative/serving --kubeconfig ~/.kube/integration-cluster

  cd terraform
  terraform destroy \
    -state=states/terraform.tfstate \
    -state-out=states/terraform.tfstate \
    -backup=states/terraform.tfstate.backup \
    $*
}

if [[ "$ACTION" =~ "up" ]] ;  then
  do_up $*
  exit 0
elif [[ "$ACTION" =~ "down" ]];  then
  do_down $*
  exit 0
else
  echo "Invalid action! Plese use apply/destroy"
  exit 1
fi
