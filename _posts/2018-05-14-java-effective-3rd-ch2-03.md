---
layout: post
title: "Item03"
comment: true
date: 2018-05-13
categories:
  - programming-page
  
tags:
  - Effective JAVA 3rd
  - Effective JAVA 3rd ch2
  - JAVA
---

### 3. private 생성자나 enum에 싱글톤 property 강제하기 
싱글톤 - 객체를 하나만 만들 수 있는 클래스   
클래스를 싱글톤으로 만드는건 타입으로 인터페이스를 implement 받지 않는한 목객체로 만들수 없기 때문에 테스트하기 힘어 질 수 있다.

####implement singleton하는 방법

  1. singleton with public final field  
     ```
     public class Evis {
         public static final Evis INSTANCE = new EVis();
         private Evis() { ... }
        
         public void leaveTheBuilding() { ... }
     }
     ```  
  2. singleton with static factory  
     ```
     public class Elvis {
         private static final Elvis INSTANCDE = new Elvis();
         private Elvis() { ... }
         public static Elvis getInstance() { return INSTANCE; }
        
         public void leaveTheBuilding() { ... }
     }
     ```

