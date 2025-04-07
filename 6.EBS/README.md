# 6. EBS (Elastic Block Store)
## 6.1: 수동으로 볼륨 연결 및 생성
* "https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#Volumes:" Volume 생성 및 i1 인스턴스에 연결 
  - Device name : /dev/xvdbb
* "lsblk" 명령으로 볼륨 인식 확인 

## 6.2: 수동으로 EBS 볼륨 연결 및 포맷
```
df
ls /dev|grep xvdbb
sudo -i
fdisk /dev/xvdbb
    # < 설정 > : n → p → <enter> → <enter>  → <enter> → p → w

mkfs.ext4  /dev/xvdbb1
mkdir /data1
mount /dev/xvdbb1 /data1
df -h
echo "/dev/xvdbb1 /data1 ext4 defaults 0 1" >> /etc/fstab
reboot
  # Exit 됨

ssh -i ~/mykey ubuntu@<eip 혹은 다시 설정된 Public ip>
df -h
exit
```

## 6.3: Terraform으로 EBS 볼륨 생성
* VPC와 Subnet생성후 Volume 생성 후 Instance 생성까지만 구현함.
* 수동으로 fdisk·format,·mount 해볼 것.어려움(!). fdisk·format,·mount등의 과정을 이해하는 것이 목적임.
  - 시연 위주임(꼭 따라하지 못해도 과정만 이해하면 다음 과정을 진행하는데는 문제 없음)
* 다음번 예제에서 자동으로 fdisk·format,·mount 하는 것을 다룸

### 실행 절차
1. 폴더로 이동
```
cd awsHadoop/6.EBS
```

2. init 및 apply
```
terraform init
terraform apply -auto-approve
```


3. Instance 생성 확인 및 추가로 생성된 Volume확인
```
ip=$(cat terraform.tfstate |grep public_ip\"|awk 'BEGIN{FS="\""}{printf $4}')
  # =:= cat terraform.tfstate|grep public_ip
ssh ubuntu@$ip
```
* 추가로 생성된 Volume확인
* AWS Console → EC2 → Volumes

4. 수동으로 fdisk·format,·mount
* ssh로 생성된 instance에 접속해서 아래 과정 실행
```
df
ls /dev|grep xvd
sudo -i
fdisk /dev/xvdh
    # < 설정 > : n → p → <enter> → <enter>  → <enter> → p → w

mkfs.ext4  /dev/xvdh1
mkdir /data1
mount /dev/xvdh1 /data1
df -h
echo "/dev/xvdh1 /data1 ext4 defaults 0 1" >> /etc/fstab
reboot
  # Exit 됨

ssh  ubuntu@$ip
df -h
exit
```

5. destroy
* AWS Console→EC2에서 해당 instnace 삭제후 실행
  - Volume을 수동으로 연동해서 Volume삭제 안되서 instance도 삭제 안되고, 해당 인스턴스를 사용하고 있는 VPC도 삭제 안됨.
```
terraform destroy -auto-approve
aws ec2 delete-key-pair --key-name mykey2
```

## 6.4: Terraform으로 EBS 볼륨 연결 및 포맷
* Cloudinit을 통해 fdisk·format·mount등을 실행하는 예제
* Manual : https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config

### 실행 절차
1. 폴더로 이동
```
cd ~/awsHadoop/6.EBS/cloudinit
```

2. init 및 apply
```
terraform init
terraform apply -auto-approve
```


3. Instance 생성 확인
```
ip=$(cat terraform.tfstate |grep public_ip\"|awk 'BEGIN{FS="\""}{printf $4}')
ssh -i ~/mykey ubuntu@$ip
  df -h|grep data
  cat /etc/fstab
  cat /var/log/cloud-init-output.log
  exit
```

4. destroy
```
terraform destroy -auto-approve
# Destroy 실패하면 Instance 및 Volume 수동으로 제거 후 다시 destroy[수동 생성 부분 때문에 제거 않되는 경우]
  terraform destroy -auto-approve

```
