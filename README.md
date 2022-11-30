# Docker_JDSS_Project

#### JDSS Project 는 Docker Stack 기반의 사용자 맞춤 WEB & Blog 배포 프로젝트 입니다

---

## 1. 프로젝트 개요

### 1.1 프로젝트 주제

> - JDSS 는 사용자 요구 사항에 맞는 Docker Stack 을 배포하여 Web & Blog 서비스를 제공해주는 프로젝트 입니다. 사용하기 어려운 CLI 환경이 아닌, 그래픽 환경인 Dialog 로 제공하여 사용자가 더 쉽게 배포 & 조회 & 삭제 할 수 있는 프로그램을 구현하고자 합니다

### 1.2 프로젝트 동기

> - Docker Swarm Mode 환경에서 사용자 요청에 맞게 이미지를 생성하고, 컨테이너를 묶어 Stack 으로 배포해주는 서비스를 제공하고자 주제를 선정하였습니다. 또한, 해당 서비스를 관리자 입장에서 모니터링 해보는 경험을 쌓기 위해 모니터링 환경도 구축하여 적용해보고자 합니다. 이를 통해 기존의 학습 내용에 대한 이해도 강화와 프로젝트 진행을 통한 경험을 쌓는 것을 목표로 삼고자 선정했습니다

### 1.3 프로젝트 배경

> 1. Docker Stack Mode 환경에서 사용자 요구 사항에 맞는 서비스 배포
> 2. Grafana & Prometheus 를 통한 모니터링 환경 구축
> 3. Harbor 를 통한 Private Regisry 구축
> 4. Dialog 를 통한 Gui 환경의 프로그램 구축
> 5. 쉽고 간편한 배포 & 조회 & 삭제 프로세스

---

## 2. 프로젝트 구조 및 기술

### 2.1 기술 스택

![](https://velog.velcdn.com/images/lijahong/post/6b19c364-a697-438d-8f4a-cf8b136efe18/image.png)
> - 개발 환경: LINUX
> - Container 배포 : Docker, Docker Swarm Mode
> - 모니터링 : Cadvisor, Prometheus, Grafana
> - 사설 저장소 : HARBOR

### 2.2 Node 구조

![](https://velog.velcdn.com/images/lijahong/post/a93737ce-1950-47c9-ab5a-f2cf3e6f5671/image.png)
> - Manger Node : Dialog, Image 생성, Worker Node 에 명령 전달과 같은 주 기능
> - Worker Node : 서비스의 주 컨테이너들이 위치, Image Pull 을 통한 컨테이너 배포
> - Repo Node : Harbor 를 이용한 사설 저장소가 위치하며, 각 Node 들에게 Image PUSH & PULL 을 제공합니다

### 2.3 Monitoring 구조

![](https://velog.velcdn.com/images/lijahong/post/52f0a337-b795-4fbf-9869-e923edc139fd/image.png)
> - cAdvisor 와 Node Exporter 가 위치하며, cAdvisor 는 Container 환경을, Node Exporter 는 Node 의 환경에 대한 자원 사용량과 같은 Data 를 모니터링 합니다
> - Grafana 와 Prometheus 가 위치하며, Prometheus 는 Service Discovery 를 참조하여, Target 의 Data 를 Metrics Api 방식으로 수집하는 Pull 방식을 사용합니다. 이를 통해 cAdvisor 와 Node Exporter 의 Metric 을 수집하고 분석하여 Grafana 를 통해 시각화합니다

### 2.4 Network 구조

![](https://velog.velcdn.com/images/lijahong/post/fd88d11c-af90-4a8f-8959-125df5de4085/image.png)
> - Node 의 Network 는 VMware 의 NAT Network 로 211.183.3.0 대역을 사용하며, Manager Node 와 Worker Node 는 Cluster 환경을 구성하여 Ingress Network 를 사용합니다
> - Stack 배포시 사설 Overlay Network 를 생성하여 Haproxy 를 통해 다른 Container 에게 접근하게 구성합니다

---

### 3. 프로젝트 개발

### 3.1 프로젝트 개발 과정

1. 프로젝트 준비
> - 프로젝트 주제 선정
> - 프로젝트 사용 기술 조사
> - 프로젝트 구조 설계
> - 개발 환경 구성

2. 프로젝트 구현
> - Dialog 구현
> - 주요 기능 구현
> - Harbor 저장소 구축
> - 모니터링 환경 구축

3. 유지 보수
> - 주요 기능 오류 수정
> - Dialog 오류 방지 기능 구현
> - 기능 Test

### 3.2 개발 내용

#### [ 세부 개발 내용 ](https://velog.io/@lijahong/Docker-%EA%B0%9C%EC%9D%B8-Project-JDSS-%EA%B0%9C%EB%B0%9C-%EB%82%B4%EC%9A%A9)

---

### 4 프로젝트 결과

#### [시연 영상 링크](https://www.youtube.com/watch?v=mbWD0htjHxU&t=24s&ab_channel=TheHong)

### 4.1 메인 화면

![](https://velog.velcdn.com/images/lijahong/post/efbfc711-5f41-4942-94fc-a576e60999a3/image.png)

### 4.2 Stack 배포

![](https://velog.velcdn.com/images/lijahong/post/b1c84248-1ecf-45b7-8a50-03435aa785f0/image.png)
> - 사용자로부터 STACK 이름, 배포할 Service 종류, Replicas 수, Clone 할 Github 주소 순으로  입력 받습니다
> - 만약, Data 를 입력하지 않고 OK 를 누르거나, Cancel 을 누르면, 배포 프로세스를 종료 후 Main Menu 로 돌아갑니다

![](https://velog.velcdn.com/images/lijahong/post/565343f5-81c5-4447-9b3a-0f06175bca65/image.png)
> - Web 서비스의 종류에는 Nginx & Haproxy 서비스, Httpd & Haproxy 서비스 가 있으며, Haproxy 는 manager, nginx 및 httpd 는 worker 에 배포하여 서비스를 제공해줍니다

![](https://velog.velcdn.com/images/lijahong/post/d5a43319-4412-470d-a559-525f6e87df2f/image.png)
> - Blog 서비스는 Wordpress & Mysql & Haproxy 이며, Mysql 과 Haproxy 는 manager, wordpress 는 worker 에 배포되며, manager 에서 mysql 를 위한 볼륨을 제공해줍니다

![](https://velog.velcdn.com/images/lijahong/post/08de44cd-9753-4838-b2c0-eac3eda27e11/image.png)
> - 배포 완료 후, 해당 Stack 의 Network 정보를 출력해줍니다. Stack 배포시, Image 생성 & Image Push & 컨테이너 배포 & Overlay Network 생성이 이루어집니다

### 4.3 Stack 조회

![](https://velog.velcdn.com/images/lijahong/post/b9da6762-9983-42b9-a91c-7e307043b69d/image.png)
> - 배포된 Stack list 를 확인할 수 있으며, 선택시 Stack 의 Container 정보 및 Network 정보를 확인할 수 있습니다

### 4.4 Stack 삭제

![](https://velog.velcdn.com/images/lijahong/post/9c2ca3bf-59a0-4db4-bc50-ab5a0aa9333d/image.png)
> - 삭제할 Stack 을 선택하고, 최종 확인을 누르면, 배포된 Stack 과 배포된 Overlay Network 를 삭제해줍니다

![](https://velog.velcdn.com/images/lijahong/post/684e87ee-1a0b-436b-ace4-b2c3b8c06c17/image.png)
> - Wordpress STACK 삭제시, 생성된 Volume 역시 삭제됩니다

### 4.5 Monitoring

![](https://velog.velcdn.com/images/lijahong/post/38e3d005-66f0-4cae-8965-cc856c5e7193/image.png)
> - cAdvisor 를 통해 각 Node 의 컨테이너 환경을 모니터링 합니다. CPU 사용률, 메모리 사용량, 동작중인 컨테이너 수를 실시간으로 모니터링 가능합니다

### 4.6 Image 저장

![](https://velog.velcdn.com/images/lijahong/post/a218207d-e66f-4efc-9910-4a7b19b46efc/image.png)
> - Stack 배포시 Image 를 생성하여 Harbor 에 Push 합니다. 이는 Web 서비스 배포시에만 해당합니다

---

## 5. 프로젝트 소감

> - 이번 프로젝트를 진행하며 모든 순간이 순탄하지는 않았습니다. 대표적으로 오류 수정에서 가장 큰 어려움을 느꼈던 것 같습니다. 발생한 문제에는 wordpress 연결 문제, Dialog 절차 문제, Stack 배포시 Image 를 못 찾는 문제가 있었습니다. 문제가 발생한 순간마다 해당 문제를 해결할 때까지 자리에서 벗어날 수가 없었습니다. 허나, 이 해결 과정은 결코 고통스럽지 않았습니다. 오히려 고민과 생각, 그리고 수많은 시도를 할 때마다 즐거웠고, 문제를 해결하면 생기는 기쁨의 도파민 덕분에 문제 해결에 즐거움을 느꼈습니다

![](https://velog.velcdn.com/images/lijahong/post/1052508f-b585-46e4-bdff-73c752a439f8/image.png)
