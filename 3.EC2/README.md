# 3. EC2 (Elastic Compute Cloud)
## 3.1: 수동으로 EC2 인스턴스 생성
* https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#LaunchInstances:
* Region        : ap-northeast-2(서울) 인지 확인만.
* Name          : u1
* AMI           : ami-0d5bb3742db8fc264 (Ubuntu Server 24.04 LTS)
* Ssecurity groups : Create security group ( Allow security group)
* Instance Type : t2-micro
* Key Pair      : key1 생성, pem확장자로 다운로드
* Storage(EBS)  : 8G

## 3.2: EC2 보안 그룹 설정 및 연결
* https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#SecurityGroups: 에서 보안 그룹 추가
* 인스턴스의 보안 그룹 변경

## 3.3: SSH Client 연결
* Putty 통한 서버 연결
* EIP 확인
* PPK(Private Key) 등록 

### cf. puttygen 
* pem은 리눅스용, pem은 pc용, puttygen으로 서로 변환 가능
```
apt install -y putty-tools
puttygen mykey.ppk -O private-openssh-new -o mykey.pem
puttygen mykey.ppk -O private-openssh     -o mykey.pem
puttygen mykey.pem -O private             -o mykey.ppk
```


## 3.4: EC2 인스턴스 상태 모니터링
* https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#Home:
* https://ap-northeast-2.console.aws.amazon.com/cloudwatch/home?region=ap-northeast-2#

## 3.5: EC2 인스턴스 중지 및 재시작 처리
* https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#Instances:instanceState=running
* Public IP확인 후 인스턴스 재부팅 

## 3.6: EIP 생성
* https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#Addresses:

## 3.7: EC2 인스턴스에 EIP 연결
* 생성된 EIP 선택 후 '작업' 클릭
* '인스턴스에 연결' 선택 후 대상 인스턴스 지정

## 3.8: EC2 인스턴스 종료 및 삭제
* DashBoard(https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#Home:)에서 최종 확인(키는 지우지 말것 향후 사용)
