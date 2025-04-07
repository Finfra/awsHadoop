# 7. 빅데이터 솔루션 프로비저닝
## 7.1. 콘솔 인스턴스 프로비저닝
* https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#LaunchInstances:
* Region        : ap-northeast-2(서울) 인지 확인만.
* Name          : i1
* AMI           :  ami-0a463f27534bdf246 Amazon Linux 2023 
* Ssecurity groups : Create security group ( Allow security group)
* Instance Type : t2-micro
* Key Pair      : key1 생성, pem확장자로 다운로드
* Storage(EBS)  : 40G

* 접속 : linux에서는 아래와 같고 windows에서는 putty로 접속 단, user는 ec2-user임.(ubuntu아님에 주의)
```
ssh ssh -i key1.pem ec2-user@{아이피}
```
* 접속 후 기본 셋팅
```
sudo -i
hostname i1 
echo i1 > /etc/hostname
exit
```

## 
* Ansible, Terraform설치
```
# cd
# git clone  https://github.com/Finfra/awsHadoop
cd ~/awsHadoop/7.HadoopEco 
bash installOnEc2_awsLinux.sh
```


## 7.2. 테라폼 셋팅
* 아래와 같은 내용을 ~/.bashrc에 추가하고 실행해 줍니다.
```
echo '
export TF_VAR_AWS_ACCESS_KEY="xxxxxxx"
export TF_VAR_AWS_SECRET_KEY="xxxxxxxxxxxxxxx"
export TF_VAR_AWS_REGION="ap-northeast-2"
'>> ~/.bashrc
. ~/.bashrc
```

## 7.2. OS key 생성 [있으면 생략]
```
ssh-keygen -f ~/.ssh/id_rsa -N ''
```
* cf) 설치 대상 host에 Public-key 배포
    ssh-copy-id root@10.0.2.10

## 7.3. Terrform 으로 host 셋팅
* Terraform으로 i1에서 s1,s2 s3 인스턴트 생성 : os는  Amazon Linux 2023 임.
```
# pwd
# → /home/ec2-user/awsHadoop/7.HadoopEco

terraform init
terraform apply --auto-approve
```


## 7.4. Hosts파일 셋팅
```
aws configure
  # security setting
    AWS Access Key ID [None]: xxxxxxxxxx
    AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxx
    Default region name [None]: ap-northeast-2
    Default output format [None]: text
# rm -rf ~/.ssh/known_hosts
# aws ec2 describe-instances
sudo ./noStrictCheck.sh

sudo ./doSetHosts.sh

ssh s1 hostname
ssh s2 hostname
ssh s3 hostname
```

* cf) 실패시 아래와 같이 /etc/hosts파일을 직접 셋팅
```
52.213.183.141 s1
54.75.118.15   s2
54.75.118.154  s3
```



## 7.5. Hadoop Cluster Install
* 주의 : 하둡파일(https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz)이 ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/에 있어야 작동함.
```
[ ! -f ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/hadoop-3.3.6.tar.gz ] &&      \
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz \
-O ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/hadoop-3.3.6.tar.gz

ansible-playbook --flush-cache                                                      \
  -u ec2-user -b --become --become-user=root                                        \
  -i ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/ansible-hadoop/hosts               \
     ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/ansible-hadoop/hadoop_install.yml  \
  -e  ansible_python_interpreter=/usr/bin/python3.9
```

## 7.4. Spark Cluster Install
* 주의1 : 하둡파일(https://dlcdn.apache.org/spark/spark-3.4.4/spark-3.4.4-bin-hadoop3.tgz)이 ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/에 있어야 작동함.

```
# docker exec -it i1  bash
[ ! -f ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/spark-3.4.4-bin-hadoop3.tgz ] && \
wget https://dlcdn.apache.org/spark/spark-3.4.4/spark-3.4.4-bin-hadoop3.tgz      \
-O ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/spark-3.4.4-bin-hadoop3.tgz
ansible-playbook --flush-cache                                                   \
  -u ec2-user -b --become --become-user=root                                     \
  -i ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/ansible-hadoop/hosts            \
     ~/awsHadoop/7.HadoopEco/hadoopInstall/df/i1/ansible-spark/spark_install.yml \
  -e  ansible_python_interpreter=/usr/bin/python3.9
```



# Admin
## Shutdown All Instance
```
for i in $(seq 3); do ssh ubuntu@s$i sudo sh -c 'shutdown -h now'; done
```
## Startup all Instance
```
ids=$(aws ec2 describe-instances  --filters "Name=tag-value,Values=s*" --query "Reservations[].Instances[].InstanceId" --output text)
for i in $ids; do     aws ec2 start-instances --instance-ids $i ;done
```

## vm destroy
```
terraform destroy --auto-approve
```