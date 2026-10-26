# Windows에서 자동차 MCU 지식창고 연결

이 저장소의 `automotive-mcu`가 Obsidian 보관함입니다. 기존 생성기 소스와 별도로 관리합니다.

## 최초 연결

Git과 Obsidian을 설치합니다. PowerShell에서 아래를 실행합니다. 기존 폴더가 있다면 새로 clone하지 말고 해당 저장소의 origin부터 확인하세요.

```powershell
git --version
git clone https://github.com/dy-nts/AI_Storage.git "$env:USERPROFILE\AI_Storage"
```

Obsidian의 '폴더를 보관함으로 열기'에서 사용자 폴더 아래 `AI_Storage\automotive-mcu`를 선택하고 HOME.md를 엽니다. 기존 ZIP 폴더가 아니라 새 Git 폴더를 열어야 합니다. Python이나 API 키는 문서 열람·동기화에 필요하지 않습니다.

## 자동 수신 활성화

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\AI_Storage\windows\Enable-AutoSync.ps1"
```

현재 Windows 사용자로 작업 스케줄러 `AI-Storage-KB-Sync`를 등록합니다. 로그인한 상태에서 5분마다 GitHub main 변경을 수신합니다. PC가 꺼져 있거나 절전·네트워크 단절 상태면 수신할 수 없습니다. 회사 정책이 작업 등록이나 스크립트를 차단하면 정책을 우회하지 말고 수동 명령을 사용하세요. 실행 정책 옵션은 이 프로세스에만 적용됩니다.

로컬 변경, 새 파일, 별도 브랜치, 로컬 커밋이 있으면 자동 갱신을 중단합니다. 자동 commit/push/reset/stash는 하지 않습니다. Obsidian 설정과 `local-notes/` 폴더는 Git에서 제외합니다. 개인 메모는 local-notes에 보관할 수 있지만 별도 백업이 필요합니다. ignore 규칙은 보안 경계가 아니며 강제로 Git에 추가하면 공개됩니다.

자동 수신은 자료 수집 자동화가 아닙니다. GitHub에 새 문서가 반영된 후 PC가 가져옵니다. 채팅의 모든 답변이 자동으로 저장되지는 않습니다.

## 상태 확인

```powershell
Get-ScheduledTaskInfo -TaskName AI-Storage-KB-Sync
Get-Content "$env:LOCALAPPDATA\AI-Storage-Sync\sync.log" -Tail 10
```

로그의 OK와 마지막 실행 결과 0을 확인합니다. STOP이면 로컬 파일을 보존한 채 중단한 것이므로 로그를 확인하세요. 스크립트는 로컬 AppData에 복사되어 실행되며 GitHub에서 스크립트가 바뀌어도 자동 교체되지 않습니다. 필요한 경우 변경 사항을 검토한 후 활성화 명령을 다시 실행합니다.

## 수동 수신

```powershell
git -C "$env:USERPROFILE\AI_Storage" status
git -C "$env:USERPROFILE\AI_Storage" pull --ff-only origin main
```

## 해제

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\AI_Storage\windows\Disable-AutoSync.ps1"
```

## 공개 범위

공식 자료 링크와 요약을 제공합니다. 원문 PDF, 비공개 개발 폴더, 개인 업무 기록은 게시하지 않습니다. 비공개 개발 저장소는 아직 연결하지 않았습니다. 공급사 문서의 권리는 각 권리자에게 있습니다.

## 검증 범위

지식창고의 문서 링크·메타데이터 검증을 수행했습니다. Windows 작업 스케줄러 실행은 사용자 PC에서 확인해야 합니다.

참고: https://learn.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger
참고: https://git-scm.com/docs/git-merge
