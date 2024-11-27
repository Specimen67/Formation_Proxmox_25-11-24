apt update && apt upgrade -y
apt install nfs-kernel-server -y
apt install lvm2 -y
pvcreate /dev/sdb #disque à partager
vgcreate vg_nas /dev/sdb
lvcreate -l 100%FREE -n data vg_nas
mkfs.ext4 /dev/vg_nas/data
blkid # récupérer l'UUID: "UUID="3e4d1a91-5c1b-4438-92ec-68f5ec248e67""
# ajouter une ligne à fstab pour le montage automatique au boot
# UUID=3e4d1a91-5c1b-4438-92ec-68f5ec248e67 /data/share ext4 defaults 0 0

echo "/data/share 172.16.254.0/24(rw,sync,no_subtree_check)" >> /etc/exports
exportfs -arv

systemctl restart nfs-kernel-server
chmod 777 /data/share