# Vérifier si le namespace est fourni en argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

namespace=$1

# Récupérer la liste des pods dans le namespace
pods=$(kubectl get pods -n "$namespace" -o jsonpath='{.items[*].metadata.name}')

# Parcourir chaque pod et récupérer les logs
rm pods.log
for pod in $pods; do
  echo "Logs for pod: $pod" >> pods.log
  kubectl logs -n "$namespace" "$pod" >> pods.log
  echo "-----------------------------------" >> pods.log
done