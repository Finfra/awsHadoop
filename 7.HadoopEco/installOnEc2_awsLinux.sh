#!/bin/bash

# install terraform
sudo dnf install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo sed -i 's|\$releasever|9|' /etc/yum.repos.d/hashicorp.repo
sudo yum -y install terraform

# install pip
sudo dnf install -y python3-pip
[[ -f /usr/bin/python ]]&& sudo rm /usr/bin/python

# install awscli
sudo python3 -m pip install awscli
#python3 -m pip install  awsebcli



# install ansible
sudo yum update -y
sudo amazon-linux-extras enable ansible2
sudo yum install -y ansible

# for Language Setting
sudo bash -c 'cat <<EOF >> /etc/bash.bashrc
set input-meta on
set output-meta on
set convert-meta off
export EDITOR=vi
EOF'



## Alias for Terraform Apply
cmd='
terraform destroy -auto-approve
terraform init
terraform apply -auto-approve
cat terraform.tfstate|grep public_ip|grep -v associate
'
echo "alias ta=\"echo '$cmd';$cmd\"">>~/.bashrc

## Alias for Terraform Destroy
cmd='terraform destroy -auto-approve
'
echo "alias td=\"echo '$cmd';$cmd\"">>~/.bashrc

## Alias for Delete aws Key pair
cmd='aws ec2 delete-key-pair --key-name mykey
'
echo "alias dk=\"echo '$cmd';$cmd\"">>~/.bashrc



cat <<EOF>> ~/.bashrc
    alias ss1="ssh -t 's1' 'sudo su -c  bash'"
    alias ss2="ssh -t 's2' 'sudo su -c  bash'"
    alias ss3="ssh -t 's3' 'sudo su -c  bash'"
EOF

source ~/.bashrc
sudo yum clean all





# Check 
echo "-------------------------------------------------------------------------------------"
terraform version
echo "-------------------------------------------------------------------------------------"
ansible --version
echo "-------------------------------------------------------------------------------------"




