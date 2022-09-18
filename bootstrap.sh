#!/usr/bin/env bash

kubectl create namespace flux-system

export SOPS_PGP_FP=$(cat .sops.yaml | yq -r '.creation_rules[0].pgp')

gpg --export-secret-keys --armor "${SOPS_PGP_FP}" |
	kubectl create secret generic sops-gpg \
	--namespace=flux-system \
	--from-file=sops.asc=/dev/stdin

flux bootstrap github \
  --owner=invakid404 \
  --repository=home-cluster \
  --path=clusters/titan \
  --personal
