# Ticket Rail — Hybrid Cloud Infrastructure

2차 프로젝트의 Terraform 인프라 코드 및 모니터링 설정 자료입니다.

- `terraform/bootstrap/`: Terraform 초기 설정
- `terraform/envs/hybrid/`: 하이브리드 네트워크, Tailscale Router, ROSA
- `terraform/envs/full_cloud/`: AWS 데이터 서비스 관련 구성
- `terraform/modules/`: 재사용 가능한 인프라 모듈
- `monitoring/`: Grafana 대시보드와 SLO 알림 구성

> 이 자료는 공개 전 검토용입니다. 실제 적용 여부 및 담당자별 기여 범위는 별도로 확인해야 합니다.
