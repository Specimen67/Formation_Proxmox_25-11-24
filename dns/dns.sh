#!/bin/bash
read -p "Entrez votre prénom pour l'inclure dans le nom de domaine : " prenom
if [[ -z "$prenom" ]]; then
    echo "Le prénom ne peut pas être vide. Veuillez réessayer."
    exit 1
fi

# Demander le domaine à configurer
echo "Quel domaine voulez-vous configurer ?"
echo "[1] ocean"
echo "[2] mountain"
echo "[3] nassan"
read -p "Entrez le numéro correspondant au domaine : " choix

# Associer le choix au nom du domaine
case "$choix" in
    1) domaine="ocean" ;;
    2) domaine="mountain" ;;
    3) domaine="nassan" ;;
    *) 
        echo "Choix invalide. Veuillez entrer 1, 2 ou 3."
        exit 1
        ;;
esac

named_file="named.conf.local.$domaine"
db_file="db.$domaine.stagiaire.lan"
bind_directory="/etc/bind/"
db_renamed="db.$domaine.$prenom.lan"



sed -i "s/stagiaire/$prenom/g" "$named_file"
sed -i "s/stagiaire/$prenom/g" "$db_file"

apt update && apt install -y bind9

cp "$named_file" "$bind_directory"
cp "$db_file" "$bind_directory$db_renamed"
echo "include \"/etc/bind/named.conf.local.$domaine\";" | sudo tee -a /etc/bind/named.conf

systemctl restart bind9