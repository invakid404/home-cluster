#!/bin/sh

cat recyclarr-template.yaml | yq -y . | tee recyclarr.yaml