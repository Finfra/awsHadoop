# Info
* Cloudinit을 통해 fdisk·format·mount등을 실행하는 예제
* Destroy 안되면 Instance 제거 후 destroy
* Manual : https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config

# 실행 절차
1. 폴더로 이동
```
cd ~/aws/1.5.4.UserdataAndCloudinit
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
```
