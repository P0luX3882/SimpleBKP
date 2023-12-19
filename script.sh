##  Script de sauvegarde simple
##  By P0luX
##  
##  

#Creation du repertoire de sauvegarde
echo "Supression de /backup"
rm -rf /backup
echo "Création de /backup, /backup/opt et /backup/home"
mkdir /backup
mkdir /backup/opt

#Backup Vaultwarden
echo "Copie de /opt/vaultwarden"
cp /opt/vaultwarden/ /backup/opt/vaultwarden -R

#Backup /home et /root
echo "Backup /home et /root"
cp /home /backup/home -R
cp /root /backup/root -R

#Compression des fichiers
echo "Création de l'archive de sauvegarde"
tar -czf /backup/backup.tar.gz /backup 

#Envoie vers le cloud
echo "Copie dans le cloud"
rclone copyto /backup/backup.tar.gz mega:/Backup/backup-$(date +%Y-%m-%d-%H-%M).tar.gz

#delete old backups
echo "Suppression des sauvegardes de plus de 7 jours"
sudo rclone delete mega:/Backup/ --min-age 7d

#delete the temporary directory
echo "Suppression des fichiers temporaires"
rm -rf /backup
