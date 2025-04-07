# 7. 빅데이터 솔루션 프로비저닝
## 7.1. 콘솔 인스턴스 프로비저닝
* https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#LaunchInstances:
* Region        : ap-northeast-2(서울) 인지 확인만.
* Name          : i1
* AMI           :  ami-0a463f27534bdf246 Amazon Linux 2023 )
* Ssecurity groups : Create security group ( Allow security group)
* Instance Type : t2-micro
* Key Pair      : key1 생성, pem확장자로 다운로드
* Storage(EBS)  : 40G

* 접속 : linux에서는 아래와 같고 windows에서는 putty로 접속 단, user는 ec2-user임.(ubuntu아님에 주의)
```
ssh ssh -i key1.pem ec2-user@아이피
```
* 접속 후 기본 셋팅
```
sudo -i
hostname i1 
echo i1 > /etc/hostname
exit
```


## 7.2. Terraform을 통한 인스턴스 프로비저닝
* Terraform으로 i1에서 s1,s2 s3 인스턴트 생성 : os는 Red Hat Enterprise Linux version 9 

## 7.3. Hadoop Cluster Install
* https://github.com/Finfra/hadoopInstall 
* 주의1 : 하둡파일(https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz)이 ~/hadoopInstall/df/i1에 있어야 작동함.
```
cd
git clone https://github.com/Finfra/hadoopInstall 
cd hadoopInstall 
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz -o ~/hadoopInstall/df/i1/hadoop-3.3.6.tar.gz
ansible-playbook --flush-cache -i /df/ansible-hadoop/hosts /df/ansible-hadoop/hadoop_install.yml
```

## 7.4. Spark Cluster Install
* Spark cluster install on Red Hat Enterprise Linux version 9  docker
* 주의1 : 하둡파일(https://dlcdn.apache.org/spark/spark-3.4.4/spark-3.4.4-bin-hadoop3.tgz)이 ~/hadoopInstall/df/i1에 있어야 작동함.

```
# docker exec -it i1  bash
wget https://dlcdn.apache.org/spark/spark-3.4.4/spark-3.4.4-bin-hadoop3.tgz -o ~/hadoopInstall/df/i1/spark-3.4.4-bin-hadoop3.tgz
ansible-playbook --flush-cache -i /df/ansible-spark/hosts /df/ansible-spark/spark_install.yml -e ansible_python_interpreter=/usr/bin/python3.12
```


