#!/usr/bin/env bash

flux bootstrap github \
  --owner=invakid404 \
  --repository=home-cluster \
  --path=clusters/titan \
  --personal
