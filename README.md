# SimpleBKP
Script simple de sauvegarde vers le cloud


Necessite de configurer une destination dans rclone avec
`rclone config`

Nécessite la création d'un mot de passe d'archive avec 

`echo 'PASSWORD' | openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:'Encryption Key' > .secret.txt`

Il faut changer `'PASSWORD'` par votre mot de passe et `'Encryption Key'` par votre clé
Puis mettre votre clé d'encryption dans le script
