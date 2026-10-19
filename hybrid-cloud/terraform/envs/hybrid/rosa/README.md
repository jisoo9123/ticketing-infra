# Ticket Rail - ROSA HCP Terraform Stack

## 1. 목적

Ticket Rail 2차 프로젝트의 Cloud Bursting 및 Full Cloud 검증을 위한
ROSA HCP(OpenShift) 환경을 Terraform으로 구성한다.

현재 Stack은 기존 AWS Network Stack을 재사용하며,
ROSA HCP Cluster를 Public / Multi-AZ 구조로 생성하도록 설계하였다.

현재 단계에서는 Terraform 코드 작성 및 Plan 검증까지만 수행하며,
온프레미스 비교시험과 결과 정리가 완료되기 전에는 Apply하지 않는다.

---

## 2. ROSA 구성

- Architecture: ROSA HCP
- Cluster Access: Public
- Region: ap-northeast-2
- Multi-AZ: true
- Availability Zones:
  - ap-northeast-2a
  - ap-northeast-2b
  - ap-northeast-2c

Public Cluster는 API와 Ingress가 외부 접근 가능한 구조를 의미하며,
Worker Node 자체는 Private Subnet에 배치한다.

---

## 3. Network

### ROSA Network CIDR

- Machine CIDR: 10.20.0.0/16
- Pod CIDR: 10.128.0.0/14
- Service CIDR: 172.30.0.0/16
- Host Prefix: 23

Machine CIDR은 기존 AWS VPC CIDR과 동일하게 사용한다.

### 기존 AWS Subnet

ROSA를 위해 VPC/Subnet을 새로 생성하지 않고
기존 Network Terraform State를 참조한다.

Public Subnet:

- Public-A: 10.20.0.0/24 / ap-northeast-2a
- Public-B: 10.20.1.0/24 / ap-northeast-2b
- Public-C: 10.20.2.0/24 / ap-northeast-2c

Private Subnet:

- Private-A: 10.20.16.0/20 / ap-northeast-2a
- Private-B: 10.20.32.0/20 / ap-northeast-2b
- Private-C: 10.20.48.0/20 / ap-northeast-2c

Subnet ID는 코드에 하드코딩하지 않고 다음 Remote State에서 참조한다.

- S3 Bucket: ticketrail-tfstate-20261026
- State Key: network/terraform.tfstate

사용하는 Network Output:

- vpc_id
- public_subnet_ids
- private_subnet_ids

---

## 4. Multi-AZ 구현 방식

프로젝트 설계 기준으로 다음 값을 유지한다.

```hcl
multi_az = true