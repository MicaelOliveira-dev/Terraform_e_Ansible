# Projeto Com Terraform e Ansible
> Status do Projeto: Concluido :heavy_check_mark:

### Problema
- <p align="justify">Temos o seguinte problema: vamos criar uma EC2 na AWS com Terraform e precisamos subir um arquivo index.html. Para esses requisitos, podemos utilizar o Terraform. Assim que a máquina virtual for criada com Terraform e o arquivo index.html for criado, ocorreu um erro no conteúdo do arquivo e tivemos que alterá-lo. Quando fizermos essa alteração no Terraform, ele irá destruir a máquina e criar uma nova com as alterações no arquivo, mas não queremos destruir a máquina. E agora? Vamos utilizar o Ansible para fazer essa alteração no arquivo sem interferir na máquina.</p>

### Ferramentas
<img src="https://img.shields.io/static/v1?label=terraform&message=ferramenta &color=grenn&style=for-the-badge&logo=TERRAFORM"/>
<img src="https://img.shields.io/static/v1?label=ansible&message=ferramenta &color=grenn&style=for-the-badge&logo=ANSIBLE"/>


### Como Rodar a Aplicação :arrow_forward:

<p align="justify">Instale o aws CLI:</p>

```
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle-1.16.312.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
```
<p align="justify">Configuração da AWS</p>

```
aws configure 
Será exibido no terminal:
AWS Access Key ID [None]: Insira sua chave de acesso da AWS
AWS Secret Access Key [None]: Insira sua chave de acesso secreta da AWS
Default region name [None]: Insira o código da região padrão da AWS (por exemplo, us-west-2)
Default output format [None]: Pode deixar em branco ou escolher um formato de saída padrão (por exemplo, json)
```

<p align="justify">Baixe o Terraform</p>

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

<p align="justify">Na Aws</p>

```
Entre em security groups e Defina as regras de acesso
Entre em pares de chaves e crie a chave de conexão SSH
Baixe o arquivo .pem e coloque no projeto
```

<p align="justify">Crie um arquivo main.tf</p>

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2" // Região escolhida
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3" // Sua AMI
  instance_type = "t2.micro" // Tipo de instância

  tags = {
    Name = "ExampleAppServerInstance" // NOme da instância
  }
}
```

<p align="justify">Com arquivo Criado.</p>

```
No Terminal Digite
Terraform init 
Terraform Apply
```

<p align="justify">Instalando Ansible</p>

```
Sudo apt install ansible
```

<p align="justify">Criando arquivos</p>

```
hosts.yml -> O arquivo "hosts" é usado pelo Ansible para definir os hosts nos quais você deseja executar tarefas
playbook.yml -> O playbook é um arquivo YAML (ou, em versões anteriores do Ansible, também pode ser um arquivo no formato INI) que define as tarefas que você deseja executar nos hosts especificados
```
<p align="justify">Dentro do arquivo host</p>

```
[nome do grupo]
ip da sua instância
```
<p align="justify">Dentro do arquivo playbook</p>

```
- name: Exemplo de playbook
  hosts: grupo1
  tasks:
    - name: Criar arquivo index
      copy:
        dest: /home/ubuntu/index.html
        content: Conteudo do arquivo index
    - name: Criando servidor
      shell: "nohup busybox httpd -f -p 8080 &"
```
<p align="justify">execute o seguinte comando</p>

```
ansible-playbook playbook.yml -u nomeDoUsuario --private-key nomeDoArquivo.pem -i hosts.yml
depois de rodar esse comando coloque o ip da maquina :8080
e sua aplicação ja estará rodando na maquina virtual
e qualquer alteração que você fizer só rodar o comando do ansible novamente
```
