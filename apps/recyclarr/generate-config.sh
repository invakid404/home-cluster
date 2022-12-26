#!/bin/sh

cat recyclarr-template.yml | yq -y . | tee recyclarr.yml