FROM ubuntu:22.04

RUN apt install "linux-headers-$(uname -r)" "linux-modules-extra-$(uname -r)"
sudo usermod -a -G render,video $LOGNAME
wget https://repo.radeon.com/amdgpu-install/6.1.2/ubuntu/jammy/amdgpu-install_6.1.60102-1_all.deb
sudo apt install ./amdgpu-install_6.1.60102-1_all.deb

# If an error occurs, you must run:
sudo chown -Rv _apt:root /var/cache/apt/archives/partial/
sudo chmod -Rv 700 /var/cache/apt/archives/partial/

sudo apt update
sudo apt install amdgpu-dkms
sudo apt install rocm-hip-libraries

# Copy SD Web Rocm docker
git clone https://github.com/HardAndHeavy/stable-diffusion-webui-rocm-docker
cd stable-diffusion-webui-rocm-docker
make run