# Projeto Vagrant - Servidor Web com Nginx

Este projeto utiliza Vagrant para criar uma máquina virtual (VM) e configurar um servidor web. O objetivo é clonar um repositório e servir seu conteúdo usando o Nginx.

## Estrutura do Projeto

- **Vagrantfile**: Arquivo de configuração do Vagrant.
- **scripts/setup.sh**: Script de configuração a ser executado na VM.

## Requisitos

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/) ou outro provider compatível com o Vagrant.

## Configuração do Vagrant

1. **Clone este repositório**:

    ```bash
    git clone https://github.com/AlanBReis/JogoDaMemoriaJS.git
    cd seu-repositorio
    ```

2. **Inicie a VM com Vagrant**:

    ```bash
    vagrant up
    ```

3. **Acesse a VM**:

    ```bash
    vagrant ssh
    ```

## Scripts de Configuração

### `scripts/setup.sh`

Este script é executado na VM para atualizar o servidor, instalar o Apache, clonar o repositório e configurar o conteúdo no diretório do servidor web.

```bash
#!/bin/bash

echo "Atualizando o servidor"
sudo apt-get update
sudo apt-get upgrade -y

echo "Instalando Apache"
sudo apt-get install apache2 -y

echo "Clonando repositório"
sudo git clone https://github.com/AlanBReis/JogoDaMemoriaJS.git
cd JogoDaMemoriaJS
sudo cp -R * /var/www/html

echo "Exibindo IP atual do servidor"
ip a
```

`Vagrantfile`

O Vagrantfile deve estar configurado para provisionar a VM e executar o script setup.sh. Aqui está um exemplo básico:

```Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.provision "shell", path: "scripts/setup.sh"
end
