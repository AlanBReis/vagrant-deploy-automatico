# Projeto Vagrant - Servidor Web com Nginx

## Descrição
Este projeto utiliza Vagrant para criar uma máquina virtual (VM) e configurar um servidor web com Nginx. O objetivo é clonar um repositório e servir seu conteúdo usando o Nginx.

## Tecnologias Utilizadas
- Vagrant
- VirtualBox
- Nginx
- Shell Scripting
- Terraform (para provisionamento na AWS)
- Ansible (para configuração da VM na AWS)

## Estrutura do Projeto
- **Vagrantfile**: Configura a VM usando Vagrant.
- **scripts/**: Contém scripts para configuração e deploy.
- **terraform/**: Contém arquivos de configuração do Terraform.
- **ansible/**: Contém playbooks e roles do Ansible.
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

### Configuração para AWS com Terraform e Ansible

#### Terraform

1. **Crie o Arquivo `terraform/main.tf`**

    ```hcl
    provider "aws" {
      region = "us-east-1"
    }

    resource "aws_instance" "web" {
      ami           = "ami-0c55b159cbfafe1f0" # Substitua com a AMI desejada
      instance_type = "t2.micro"
      key_name      = "projeto-provisionador"

      tags = {
        Name = "WebServer"
      }
    }
    ```

2. **Inicialize e Aplique o Terraform**

    ```bash
    cd terraform
    terraform init
    terraform apply -auto-approve
    ```

    O Terraform criará uma instância EC2 na AWS.

#### Ansible

1. **Crie o Arquivo `ansible/inventory.ini`**

    ```ini
    [web]
    <endereço-ip-da-instância> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/projeto-provisionador.pem
    ```

2. **Crie o Arquivo `ansible/playbook.yml`**

    ```yaml
    - name: Configurar Servidor Web
      hosts: web
      tasks:
        - name: Atualizar o servidor
          apt:
            update_cache: yes
            upgrade: dist

        - name: Instalar Nginx
          apt:
            name: nginx
            state: present

        - name: Clonar Repositório
          git:
            repo: 'https://github.com/AlanBReis/JogoDaMemoriaJS.git'
            dest: /var/www/html
            update: yes

        - name: Reiniciar Nginx
          service:
            name: nginx
            state: restarted
    ```

3. **Execute o Playbook do Ansible**

    ```bash
    cd ansible
    ansible-playbook -i inventory.ini playbook.yml
    ```

### Scripts Adicionais

#### `scripts/setup.sh`

Este script configura o servidor local para desenvolvimento.

```bash
#!/bin/bash

echo "Atualizando o servidor"
sudo apt-get update
sudo apt-get upgrade -y

echo "Instalando Apache"
sudo apt-get install apache2 -y

echo "Clonando Repositório"
sudo git clone https://github.com/AlanBReis/JogoDaMemoriaJS.git
cd JogoDaMemoriaJS
sudo cp -R * /var/www/html

echo "Exibindo IP Atual do Servidor"
ip a
