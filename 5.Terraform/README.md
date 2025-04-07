
# 5. Terraform
## Terraform과 Ansible 설치
* python3.12가 설치되어 있을때는 아래 스크립트를 실행합니다.
```
sudo -i
cd
git clone https://github.com/Finfra/awsHadoop
sudo -i bash -c 'curl https://raw.githubusercontent.com/Finfra/awsHadoop/refs/heads/main/5.Terraform/installOnEc2_p3.12.sh | bash'
```



# 설치 확인
```
terraform -version
ansible --version
```



## 5.2.: Terraform으로 EC2 인스턴스 생성
### 5.2.0. 변수 셋팅 파일 생성 후 실행
* 아래와 같은 내용을 ~/.bashrc에 추가하고 실행해 줍니다.
```
su - ubuntu

echo '
export TF_VAR_AWS_ACCESS_KEY="xxxxxxx"
export TF_VAR_AWS_SECRET_KEY="xxxxxxxxxxxxxxx"
export TF_VAR_AWS_REGION="ap-northeast-2"
'>> ~/.bashrc
. ~/.bashrc
```

### 5.2.1. OS key 생성 [있으면 생략]
```
ssh-keygen -f ~/.ssh/id_rsa -N ''
```
* cf) 설치 대상 host에 Public-key 배포
    ssh-copy-id root@10.0.2.10

### 5.2.2. Terrform 으로 host 셋팅
```
cd
git clone https://github.com/Finfra/aws
cd ~/aws/1.4.2.HostProvisioning/
terraform init
terraform apply --auto-approve
```


### 5.2.3. Hosts파일 셋팅
```
aws configure
  # security setting
    AWS Access Key ID [None]: xxxxxxxxxx
    AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxx
    Default region name [None]: ap-northeast-2
    Default output format [None]: text
cd ~/aws/1.4.2.HostProvisioning
# rm -rf ~/.ssh/known_hosts
bash doSetHosts.sh
```

* cf) 아래와 같이 /etc/hosts파일을 직접 셋팅 해도 됨
```
52.213.183.141 vm01
54.75.118.15   vm02
54.75.118.154  vm03
```

### 5.2.5.3: Terraform 상태 파일 관리 및 백업
```
terraform state 
ls 명령으로 terraform.tfstate 생성 확인 
```

