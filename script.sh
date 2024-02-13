##  Script de sauvegarde simple
##  Sauvegarde Vaultwarden, nginx-pm, WikiJS, Homebridge et PiHole
##  Sauvegarde /home et /root
##  Vers mega.nz

#Mot de passe de l'archive
ZIP_PASSWD=$(cat /opt/Scripts/.secret.txt | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:'ENCRYPTION KEY')

#re-create a backup directory
echo "Supression de /backup"
rm -rf /backup
echo "Création de /backup, répertoire de travail"
mkdir /backup
mkdir /backup/opt
mkdir /backup/home
mkdir /backup/root

#Backup Vaultwarden
echo "Copie de /opt/vaultwarden"
rsync -a /opt/vaultwarden/ /backup/opt/vaultwarden 

#Backup Nginx-PM
echo "Copie de /opt/nginx-pm"
rsync -a /opt/nginx-pm/ /backup/opt/nginx-pm/ 

#Backup Heimdall
echo "Copie de /opt/Heimdall"
rsync -a /opt/heimdall/ /backup/opt/heimdall 

#Backup PiHole
echo "Copie de /opt/PiHole"
rsync -a /opt/pihole/ /backup/opt/pihole/ 

#Backup WikiJS
echo "Copie de /opt/wikijs"
rsync -a /opt/wikijs/ /backup/opt/wikijs/ 

#Backup Homebridge
echo "Copie de /opt/homebridge"
rsync -a /opt/homebridge/ /backup/opt/homebridge/ 

#Backup Gotify
echo "Copie de /opt/gotify"
rsync -a /opt/gotify /backup/opt/gotify/

#Backup /home et /root
echo "Backup /home et /root"
rsync -a --exclude=".*" /home/ /backup/home/
rsync -a --exclude=".*" /root/ /backup/root/

#Création de l'archive de sauvegarde
echo "Création de l'archive de sauvegarde protégée par mot de passe"
zip -r -P $ZIP_PASSWD /backup/backup.zip /backup/*

#send to the cloud --> mega.nz --> kevin.aveline6@gmail.com
echo "Copie dans le cloud"
rclone copyto /backup/backup.zip mega:/Backup-RPI4/backup-$(date +%Y-%m-%d-%H-%M).zip

#delete old backups
echo "Suppression des sauvegardes de plus de 7 jours"
sudo rclone delete mega:/Backup-RPI4/ --min-age 7d

#delete the temporary directory
echo "Suppression des fichiers temporaires"
rm -rf /backup

echo "Script BKP Terminé" | gotify push

