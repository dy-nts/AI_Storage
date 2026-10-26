---
id: NOTE-IFX-006
title: "TLE986x TLE987x Errata"
type: reference
status: active
evidence_level: Confirmed
source_ids: [IFX-006]
last_verified: 2026-10-26
tags: [infineon, mcu]
related: []
---

# TLE986x TLE987x Errata

- 공식 출처: [TLE986x TLE987x Errata](https://www.infineon.com/assets/row/public/documents/10/52/infineon-tle986x-tle987x-err-erratasheet-en.pdf)
- 확인 범위: PDF 본문 일부 확인
- 버전: 1.6
- 날짜: 2025-09-15
- 확인일: 2026-10-26
- 원문 파일: 미보관. 링크와 확인한 내용의 요약만 수집했습니다.

## 확인 내용

4쪽 1.1절: UH step의 USER_ERASE_SECTOR, USER_ERASEPG, USER_PROG는 RAM 0x18000014를 덮어쓴다. 사용자 코드는 해당 위치를 사용하지 않아야 하며 UI step에서 수정되었다.

[[Infineon Collection]]
