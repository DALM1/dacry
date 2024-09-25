#!/bin/bash

echo "┓ ┏┏┓┓ ┏┓┏┓┳┳┓┏┓  ┳┓┏┓┓ ┳┳┓┓"
echo "┃┃┃┣ ┃ ┃ ┃┃┃┃┃┣   ┃┃┣┫┃ ┃┃┃┃"
echo "┗┻┛┗┛┗┛┗┛┗┛┛ ┗┗┛  ┻┛┛┗┗┛┛ ┗┻"
echo ""

if ! command -v openssl &> /dev/null
then
    echo "Erreur : OpenSSL n'est pas installé. Veuillez l'installer pour continuer."
    exit 1
fi

read -p "Veuillez entrer le chemin du dossier à chiffrer : " folder

if [ ! -d "$folder" ]; then
    echo "Erreur : Le dossier spécifié n'existe pas."
    exit 1
fi

while true; do
    read -sp "Entrez la clé de chiffrement : " key1
    echo
    read -sp "Confirmez la clé de chiffrement : " key2
    echo
    if [ "$key1" == "$key2" ]; then
        key="$key1"
        break
    else
        echo "Les clés ne correspondent pas. Veuillez réessayer."
    fi
done

echo "Chiffrement des fichiers dans le dossier $folder ..."
find "$folder" -type f -not -name "*.enc" -exec sh -c 'openssl enc -aes-256-cbc -salt -in "$1" -out "$1.enc" -k "$2" && rm "$1"' _ {} "$key" \;

if [ $? -eq 0 ]; then
    echo "Tous les fichiers ont été chiffrés avec succès."
else
    echo "Erreur lors du chiffrement des fichiers."
    exit 1
fi

echo "Opération terminée."

alias crypt='bash /Users/dalm1/Desktop/Reroll/Progra/dacry/main.sh'
