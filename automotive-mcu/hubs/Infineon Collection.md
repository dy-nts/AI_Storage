---
id: IFX-COLLECTION
title: Infineon Collection
type: hub
status: active
evidence_level: Confirmed
source_ids: [IFX-001]
last_verified: 2026-10-26
tags: [infineon, collection]
related: []
---

# Infineon 1차 기술자료 수집

2026-10-26 기준. 지정한 공식 문서 포털을 시작점으로 Infineon 공식 제품·문서 페이지에서 수집했습니다. 전체 사이트 수집이 아닌 TLE9877/TLE9879 우선 수집입니다. 아래 9건 중 포털 1건, 제품 페이지 2건, 공개 PDF 3건, 로그인 문서 소개 3건입니다. PDF는 확인 가능한 본문을 검토했으며 파일 다운로드·전문 보관은 하지 않았습니다. 최신판 여부는 별도 보증하지 않습니다.

| 문서 | 확인 상태 | 버전 | 활용 |
|---|---|---|---|
| [[Infineon Digital Documentation]] | 웹 본문 확인 | 미확인/해당 없음 | portal |
| [[TLE9877QXA40 Product]] | 웹 본문 확인 | 미확인/해당 없음 | product |
| [[TLE9879QXA40 Product]] | 웹 본문 확인 | 미확인/해당 없음 | product |
| [[TLE9877QXA40 Datasheet]] | PDF 본문 일부 확인 | 2.2 | datasheet |
| [[TLE9879-2QXA40 Datasheet]] | PDF 본문 일부 확인 | 2.11 | datasheet |
| [[TLE986x TLE987x Errata]] | PDF 본문 일부 확인 | 1.6 | errata |
| [[TLE987x User Manual]] | 로그인 필요 · 소개 페이지만 확인 | 미확인/해당 없음 | user-manual |
| [[TLE986x TLE987x FAQ]] | 로그인 필요 · 소개 페이지만 확인 | 미확인/해당 없음 | application-note |
| [[TLE987x FOC Getting Started]] | 로그인 필요 · 소개 페이지만 확인 | 미확인/해당 없음 | application-note |

## 권장 검토 순서

1. 정확한 MCU 품번과 silicon step 확인
2. 해당 품번 데이터시트에서 메모리·주변장치·핀 확인
3. Errata에서 해당 step의 영향과 우회 방법 확인
4. User Manual 원문 확보 후 레지스터 설정 검토
5. FAQ 및 FOC 가이드 원문 확보 후 코드·시험에 반영

## 개발 적용 메모

아래는 수집 자료를 바탕으로 제안하는 검토 항목이며, 구현·보드 시험 결과가 아닙니다.

- Flash 저장·부트로더: UH step Errata와 링커 RAM 배치의 충돌 여부를 확인합니다.
- 제어 루프: PWM/ADC/타이머 설정은 해당 품번 User Manual과 대조 후 결정합니다.
- 품번 관리: TLE9879와 TLE9879-2의 ADC 사양을 같은 것으로 취급하지 않습니다.
- 기능 안전·AUTOSAR 지원 범위: 이번 자료만으로 지원·인증 여부를 결론 내리지 않습니다.

## 남은 자료

- TLE9879QXA40 정확한 품번의 데이터시트 본문 확보
- User Manual, FAQ, FOC 가이드의 로그인 후 PDF 확보 및 리비전 확인
- BootROM 매뉴얼, DFP/SDK 문서, 제조사 개별 Q&A 추가 수집

[[Topic Hub]] · [[Overview]]
