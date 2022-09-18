#!/usr/bin/env sh

IP=$(ifconfig wlan0 | awk '/inet / {print $2}')

curl -sfL https://get.k3s.io | \
	INSTALL_K3S_EXEC="--disable helm-controller \
		--disable traefik \
		--bind-address ${IP} \
		--node-ip ${IP} \
		--advertise-address ${IP} \
		--node-external-ip ${IP}" \
	sh -  >/dev/null

until [ -f /etc/rancher/k3s/k3s.yaml ]
do
	sleep 1
done

cat /etc/rancher/k3s/k3s.yaml
