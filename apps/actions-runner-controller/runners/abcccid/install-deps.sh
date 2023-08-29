sudo add-apt-repository ppa:mozillateam/ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo apt update
sudo apt install -y jq firefox

json=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest)
url=$(printf "%s" "$json" | jq -r '.assets[].browser_download_url | select(contains("linux64") and endswith("gz"))')
curl -s -L "$url" | sudo tar -xz
sudo chmod +x geckodriver
sudo mv geckodriver /usr/bin/

ls -la /usr/bin/geckodriver
