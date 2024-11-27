apt update && apt upgrade -y
apt install tgt -y
#modifier le fichier /etc/tgt/conf.d/iscsi.conf
# Et y ajouter un équivalent de ce que vous pouvez trouver
# Dans le fichier joint à ce script
systemctl enable tgt
systemctl restart tgt
tgtadm --mode target --op show