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

ssh -i ~/mykey ubuntu@<다시 설정된 Public ip>
df -h
exit
```

## 6.3: Terraform으로 EBS 볼륨 생성
* README.md 참고 : https://github.com/Finfra/aws/blob/main/1.5.3.Ec2EBS/README.md
## 6.4: Terraform으로 EBS 볼륨 연결 및 포맷
* README.md 참고 : https://github.com/Finfra/aws/blob/main/1.5.4.UserdataAndCloudinit/README.md
  - 단, i1 서버에  "https://github.com/Finfra/aws"를 클론하고 시작합니다.
