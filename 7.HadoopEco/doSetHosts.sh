#!/bin/bash

# 기존 hosts에서 vm0 포함된 라인 제거
cat /etc/hosts |grep -v \ s>~/.tmp
sudo cp ~/.tmp /etc/hosts

# EC2 인스턴스 ID와 Name 태그 추출
ec2IdsAndName=$(aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running \
  --query 'Reservations[*].Instances[].[InstanceId, Tags[?Key==`Name`]]' \
  --output text | sed -z "s/\\nName[[:blank:]]/,/g")

# 루프 처리
for i in $ec2IdsAndName; do
  ec2id=$(echo $i | awk 'BEGIN{FS=","}{printf $1}')
  ec2Name=$(echo $i | awk 'BEGIN{FS=","}{printf $2}')

  # ec2Name이 s로 시작하면 Private IP, 아니면 Public IP 사용
  if [[ $ec2Name == s* ]]; then
    ip=$(aws ec2 describe-instances --instance-ids $ec2id \
      --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)
  else
    ip=$(aws ec2 describe-instances --instance-ids $ec2id \
      --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)
  fi

  echo "$ip  $ec2Name"
  sudo bash -c "echo $ip  $ec2Name >> /etc/hosts"
done

# 결과 확인
echo "/etc/hosts------------"
cat /etc/hosts
echo "----------------------"
