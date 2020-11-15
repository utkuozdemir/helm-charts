#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ $# -eq 0 ]; then
  echo "No arguments supplied. Pass the helm chart directory as the first parameter."
  exit 1
fi

repo_url=https://utkuozdemir.org/helm-charts
package_dir=$1

mkdir -p temp
helm package -d temp "$package_dir"
helm repo index temp/ --url $repo_url --merge docs/index.yaml
mv temp/* docs/

git add "$package_dir"
git add docs
