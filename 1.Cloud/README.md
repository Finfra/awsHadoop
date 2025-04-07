# 1. Cloud 이해
  (이론 쳅터)
  - 수강자 요청시 혹은 시간 남을 것 같으면 : VirtualBox + Vagrant관련 Quick WorkShop 진행

# VirtualBox & Vagrant 

## VirtualBox
* https://www.virtualbox.org  
 - Oracle에서 제공하는 오픈소스 가상화 소프트웨어  
 - Windows, macOS, Linux 등 다양한 OS에서 다른 OS를 가상머신으로 실행 가능

## Vagrant
* https://www.vagrantup.com  
 - HashiCorp에서 제공하는 개발 환경 자동화 도구  
 - VirtualBox, Docker 등 다양한 백엔드를 이용하여 VM 환경을 코드로 정의하고 관리함  
 - `Vagrantfile`을 통해 가상환경 설정 가능  
 - 인프라 구성을 코드화하여 재현 가능한 개발 환경 제공
 - 예제 : https://github.com/Finfra/vagrant-examples

## Vagrant Box 검색 포털
* https://portal.cloud.hashicorp.com/vagrant/discover  
 - Vagrant에서 사용할 수 있는 다양한 OS 이미지(box) 검색 가능  
 - Ubuntu, CentOS, Debian 등 다양한 배포판 및 버전 제공  
 - ex) `vagrant init ubuntu/jammy64` 후 `vagrant up`으로 손쉽게 VM 생성 가능