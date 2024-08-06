#!/bin/bash

echo "Atualizando o servidor"
sudo apt-get update
sudo apt-get upgrade -y

echo "instalando apache"
sudo apt-get install apache2 -y

echo "clonando repositorio"
sudo git clone https://github.com/AlanBReis/JogoDaMemoriaJS.git
cd JogoDaMemoriaJS
sudo cp -R * /var/www/html

echo "exibindo ip atual do servidor"
ip a 