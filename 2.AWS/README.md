# 2. AWS 소개
## 2.1: AWS 계정 생성
* AWS 계정을 생성합니다.(GKN 제공 계정 사용할 경우 바로 로그인)
* 개인 개정 사용 희망자만 "https://aws.amazon.com/"에 접속하여 계정 생성(해외 결제 가능 신용카드 필요)
* 자세한 절차 : Google Drive 강의 자료 폴더의 '/_docs/AWS가입및로그인절차.key.pdf' 참고

## 2.2: 서비스 탐색
* https://aws.amazon.com/console/
* Search에서 검색(Option+s) : EC2, S3, RDS, vpc

## 주의 : vpc 없는 경우
* 공용 계정의 경우 Default vpc 없는 경우 자주 발생
* vpc란? ... , 가정에서는 공유기 같은 것.
  - Default vpc 없으면, ec2인스턴스가 만들어지지 않음. (집에 공유기 없으면, 인터넷 않됨)
* https://ap-northeast-2.console.aws.amazon.com/vpcconsole
  - Default vpcn생성 : Actions → Create default VPC

## 2.3: 리전 확인과 이동
* 회면 오른쪽의 버튼을 통해 이동하거나 아래 두 링크 접속을 통해 리전 확인
  - https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#Home:
  - https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=eu-west-1#Home:
