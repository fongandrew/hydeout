---
published: false
layout: post
categories:
  - 번역
---
작가 허락을 받고 번역한 글입니다.([원문](https://dev.to/thenerdydev/the-only-git-cheat-sheet-that-you-ll-ever-need-trust-me-22b4))

안녕하세요👋🏻

이번 포스팅에서는 모든 개발자가 반드시 알아야할 필수 Git 명령어에 대해 정리해보겠습니다.

## 소개

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/l9zvmro1az01tpwm9a71.png)

Git은 무료 분산 버전 컨트롤 시스템으로 오픈소스입니다. 아주 작은 프로젝트부터 엄청 큰 프로젝트까지 크기에 상관 없이 처리할 수 있고, 빠른 속도와 높은 효율성을 가지고 있습니다.

Git은 배우기 쉽습니다. 그런데도 매우 작은 용량으로 엄청난 성능을 보유하고 있습니다. Git은 로컬 브랜치, 편리한 staging 기능, 많은 워크플로우 등을 지원하는 다른 SCM 툴을 압도하고 있습니다.

### 저장소 초기화
|||
| --- | --- |
| git init | 저장소 초기화하기 |

### 파일 Staging: 커밋할 준비 된 상태로 만들기
|||
| --- | --- |
| git add filename | 파일 한개 staging 하기 |
| git add . |현재 위치한 디렉토리의 모든 내용을 staging 하기|

### 상태 확인
|||
| --- | --- |
| git status| 현재 위치한 디렉토리와 staging 영역의 상태 보기|

### staged 파일 커밋: 커밋할 준비 된 상태의 파일 커밋
|||
| --- | --- |
| git commit -m "your message"| 한줄 설명과 함께 커밋하기 |

### 파일 삭제
|||
| --- | --- |
| git rm filename| staging 영역과 현재 작업 중인 디렉토리에서 해당 파일 삭제하기 |
| git rm --cached filename| staging 영역에서 해당 파일 삭제 하기 |

### 파일 이름 옮기거나 이름 변경
|||
| --- | --- |
| git mv filename_one filename_two | 파일 옮기거나 이름 변경하기 |

### staged 되거나 unstaged 된 변화 확인
|||
| --- | --- |
| git diff| unstaged된 파일들의 변화 확인하기 |
| git diff --staged| staged된 파일들의 변화 확인하기 |
| git diff --cached| staged된 것과 이전 커밋 사이의 차이 확인하기 |

### Unstaging된 변화 
|||
| --- | --- |
| git restore --staged filename| 저장소에서 staging 영역으로 지정한 파일 최신 버전 복원하기 |

### 이전 기록 확인
|||
| --- | --- |
| git log --stat| 변경된 파일들의 목록 확인하기 |
| git log --patch| 발생했던 실제 변화를 확인하기 |

### 커밋 확인
|||
| --- | --- |
| git checkout <commit_id>| 주어진 커밋을 확인하기 위해 해당 시점으로 이동하기 |
| git checkout master| 마스터 브랜치 확인하기 위해 해당 시점으로 이동하기 |

### 커밋들 비교
|||
| --- | --- |
| git diff HEAD~2 HEAD| 두 커밋 간의 변화 확인하기 |

### 버그 발생 커밋 조사
|||
| --- | --- |
| git bisect start | 버그 발생한 커밋 찾아내기 |
| git bisect bad | 현재 커밋을 버그 있음(bad)으로 마킹하기 |
| git bisect good <commti_id> | 해당 커밋을 버그 없음(good)으로 마킹하기 |
| git bisect reset | 버그 발생한 커밋 조사 종료 |

### 브랜치 관리
|||
| --- | --- |
| git branch payment | payment라 불리는 새로운 브랜치 생성하기 |
| git checkout payment | payment 브랜치로 변경하기 |
| git branch -d payment | payment 브랜치 삭제하기 |

### Stashing: 다른 작업을 하기 위해서 현재 상태 저장하기
|||
| --- | --- |
| git stash push -m "new stash" | "new stash"라는 새로운 stash 만들기 |
| git stash list | 모든 stash 확인하기 |
| git show stash@{1} | 주어진 stash 확인하기 |

### 병합
|||
| --- | --- |
| git merge a | 현재 브랜치를 a 브랜치에 병합하기 |
| git merge --squash a | 병합되어 없어지는 브랜치의 커밋 내용을 하나로 합치고 병합하기 |
| git merge ---abort | 병합 취소하기 |

### Rebasing: 커밋 로그 정리하기 & Cherry Picking: 커밋 하나만 테스트로 적용해보기
|||
| --- | --- |
| git rebase master | 현재 브랜치의 베이스를 마스터로 바꾸기 |
| git cherry-pick <commit_id> | 주어진 커밋을 현재 브랜치에 적용한다. |

준비된 건 여기까지입니다. 읽어주셔서 감사합니다.
** 내용이 좋았다면 좋아요 버튼을 잊지 마시고 친구와 동료에게 공유해보시기 바랍니다..**

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/3qpl01uwp1qlmbqkhfpm.gif)

**추신** - 웹 개발을 배우고 싶다면, 제가 엄선한 **무료** 코스가 제 유튜브 채널에 있습니다. 아래 포스팅을 확인해보시기 바랍니다. :

[(2021) - Web Developer Full Course : HTML, CSS, JavaScript, Node.js and MongoDB](https://dev.to/thenerdydev/2021-web-developer-full-course-html-css-javascript-node-js-and-mongodb-27pb)

React.js를 **프로젝트**로 배우고 싶다면 , 아래 링크를 확인해보시기 바랍니다. :

[Learn React with one BIG Project [NOTES included] - Demo and Video Link](https://dev.to/thenerdydev/learn-react-with-one-big-project-notes-included-demo-and-video-link-4fe5)


👉🏻 트위터 팔로우 : https://twitter.com/The_Nerdy_Dev
👉🏻 디스코드 서버 : https://discord.gg/fgbtN2a

