# 고가용성 검증 요약

## 1. Ingress Controller Pod 장애

### 목적
Ingress Controller 중 하나에 장애가 발생하더라도 외부 사용자 요청이 계속 처리되는지 확인했습니다.

### 확인 항목
- NGINX Ingress Controller Pod 2개가 서로 다른 Worker에서 실행되는지 확인
- 외부 접근 VIP `10.1.93.69` 확인
- 실제 Ingress Host 및 정상 응답 경로 확인
- Ingress Pod 1개 제거 후 요청 지속 여부 확인

### 결과
Ingress Controller Pod 1개가 제거된 상황에서도 남아 있는 Controller를 통해 외부 트래픽이 지속되는 것을 확인했습니다.

## 2. Worker Node 장애

### 목적
애플리케이션 및 Ingress 구성요소가 실행되는 Worker에 장애가 발생했을 때 외부 서비스 진입 경로가 유지되는지 확인했습니다.

### 확인 항목
- 장애 전 Worker/Pod 배치 상태 확인
- Worker 장애 발생 후 외부 요청 지속 여부 확인
- MetalLB VIP 위치 변화 확인
- 테스트 종료 후 환경 원복 및 정상 상태 확인

### 결과
Worker 장애 상황에서도 트래픽이 지속되었고 MetalLB VIP 이동을 확인했습니다. 이를 통해 구성한 외부 트래픽 경로가 단일 Worker 장애 상황에서도 동작하는 것을 검증했습니다.

## 측정 범위에 대한 주의
당시 테스트는 서비스 연속성과 VIP 이동을 중심으로 검증했습니다. 복구 시간, 실패 요청 수, p95/p99 응답시간과 같은 세부 정량 지표는 이 결과에 포함시키지 않았습니다.
