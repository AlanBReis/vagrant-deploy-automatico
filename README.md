# Projeto Vagrant - Servidor Web com Nginx

## Descrição
Este projeto utiliza Vagrant para criar uma máquina virtual (VM) e configurar um servidor web com Nginx. O objetivo é clonar um repositório e servir seu conteúdo usando o Nginx.

## Tecnologias Utilizadas
- Vagrant
- VirtualBox
- Nginx
- Shell Scripting

## Estrutura do Projeto
- **Vagrantfile**: Configura a VM usando Vagrant.
- **scripts/**: Contém scripts para configuração e deploy.
- **README.md**: Este arquivo.
- **LICENSE**: Licença do projeto.

## Funcionalidades
- Provisionamento automatizado da VM
- Clonagem de repositório
- Configuração de servidor web

## Instruções de Configuração e Deploy

### Configuração Local com Vagrant

1. **Clone o Repositório**

    ```bash
    git clone <link-do-repositório>
    cd <nome-do-repositório>
    ```

2. **Configure o Vagrantfile**

    O `Vagrantfile` deve estar configurado para provisionar a VM e executar o script `setup.sh`. Aqui está um exemplo básico:

    ```ruby
    Vagrant.configure("2") do |config|
      config.vm.box = "ubuntu/bionic64"
      config.vm.network "forwarded_port", guest: 80, host: 8080
      config.vm.provision "shell", path: "scripts/setup.sh"
    end
    ```

3. **Suba a VM com Vagrant**

    ```bash
    vagrant up
    ```

4. **Acesse a VM**

    ```bash
    vagrant ssh
    ```

### Scripts Adicionais

#### `scripts/setup.sh`

Este script configura o servidor local para desenvolvimento.

```bash
#!/bin/bash

echo "Atualizando o servidor"
sudo apt-get update
sudo apt-get upgrade -y

echo "Instalando Nginx"
sudo apt-get install nginx -y

echo "Clonando Repositório"
sudo git clone https://github.com/AlanBReis/JogoDaMemoriaJS.git
cd JogoDaMemoriaJS
sudo cp -R * /var/www/html

echo "Exibindo IP Atual do Servidor"
ip a
