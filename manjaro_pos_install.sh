#!/bin/bash
echo "######################################################"
echo "### $0 by sposigor@gmail.com ###"
echo "######################################################"


echo "====================================================================="
echo "======================== Atualizar Pacotes =========================="
echo "====================================================================="
echo "1. Atualizando o Manjaro"
sudo pacman -Syyu --noconfirm &&


echo "====================================================================="
echo "========= Instalar programas usados no AUR =========="
echo "====================================================================="
pacman -S --noconfirm --needed \
 discord flameshot visual-studio-code-bin processing4 rclone docker docker-compose minikube obs-studio &&


echo "====================================================================="
echo "========= Instalar programas usados no Snap e Habilitando =========="
echo "====================================================================="
sudo pacman -S --noconfirm  snapd &&
yes | sudo systemctl enable --now snapd.socket &&
yes | sudo snap install \
 google-cloud-cli postman chromium beekeeper-studio kubectl &&


echo "====================================================================="
echo "========= Instalar programas usados no Flatpak e Habilitando =========="
echo "====================================================================="
yes | sudo pacman -S flatpak &&
yes | sudo flatpak install gitkraken &&


echo "====================================================================="
echo "========= Habilitando o SSH =========="
echo "====================================================================="
sudo systemctl enable sshd.service; sudo systemctl start sshd.service &&


echo "====================================================================="
echo "========= Criando a chave SSH =========="
echo "====================================================================="
mkdir ~/.ssh &&
HOSTNAME=`hostname` ssh-keygen -t rsa -b 4096 -C "$HOSTNAME" -f "$HOME/.ssh/id_rsa" -P "" && cat ~/.ssh/id_rsa.pub &&
touch ~/.ssh/authorized_keys &&
chmod 700 ~/.ssh && chmod 600 ~/.ssh/* &&
cp -r /root/.ssh /home/$u/ &&
chown $u:$u /home/$u/.ssh -R &&


echo "====================================================================="
echo "========= Configurando o Docker =========="
echo "====================================================================="
sudo groupadd docker &&
sudo usermod -aG docker $(cat user.log) &&
sudo sed -i 's/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"cgroup_enable=memory swapaccount=1\"/g' /etc/default/grub &&
sudo update-grub --noconfirm &&


echo "====================================================================="
echo "=============== Removendo pacontes inuteis =================="
echo "====================================================================="
pacman -Qdtq | pacman --noconfirm -Rns - &&
pacman -Sc --noconfirm &&


echo "====================================================================="
echo "========= Configurando o Git =========="
echo "====================================================================="
git config --global user.name "Igor Esposito"
git config --global user.email sposigor@gmail.com
