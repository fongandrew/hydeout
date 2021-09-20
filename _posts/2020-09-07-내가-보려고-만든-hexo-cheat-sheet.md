---
title: 내가 보려고 만든 hexo cheat sheet
comments: true
categories:
  - ETC
description: 간단하면서도 블로그 운영 중 알고 있어야 할 명령어 모음
top_img: null
cover: null
published: false
---
[두번 참고해야 하는 사이트](https://ciweigg2.github.io/2019/07/04/hexo-theme-butterfly-zhu-ti-an-zhuang-ya/#toc-heading-22)  
위 게시글은 중국어로 작성 되어있지만 butterfly theme 사용법을 사진까지 넣어가며 자세히 적어 놓았다. 특히나 butterfly의 설정 파일 yml 파일의 내용과 그 설정 방법에 대해 잘 설명되어 있다.  

[세번 참고해야 하는 사이트](https://molunerfinn.com/hexo-theme-melody-doc/quick-start.html#installation)  
butterfly 테마의 base인 melody 테마의 공식 문서이다. 영어로 잘 나와 있다.

## 배포
hexo 블로그의 배포는 세가지 명령어를 통해 실행된다.
### hexo generate
파일들을 빌드하여, 배포하기 쉬운 형태로 변환
### hexo deploy
변환된 파일을 실제 레포지토리에 푸시하고 실제 서버에 알아서 배포
### hexo server
변환된 파일을 로컬로 배포. 즉, 미리보기 기능

## 게시글
### 작성
#### 레이아웃 3가지
- draft : 말 그대로 초안 파일, 하지만 거의 사용하지 않을 듯 하다.
- page : 페이지 파일로 about, categories 페이지 작성에 쓰임
- post : 실질적으로 가장 많이 사용하게 될 게시글

위 레이아웃을 이용하여  
`hexo new [layout] [title]`  
위 명령어를 사용하면 새로운 글 파일이 생성된다. 이후 배포를 하게 되면 게시글이 올라가게 된다.

### 삭제
그냥 파일을 삭제하고 다시 재 배포 하면 된다.

## 카테고리 및 태그 추가
글을 생성하게 되면 맨 처음 마크다운 파일엔 front-matter만 존재한다. ---과 ---로 둘러싸여진 것들인데, 이 내용을 보면 'tags:', 'categories:'가 있다. 여기에 원하는 태그와 카테고리를 입력하고 generate, deploy하게 되면 자동으로 카테고리 및 태그가 추가된다.
