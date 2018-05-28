---
layout: post
title: "Item02"
comment: true
date: 2018-05-12
categories:
  - programming-page

tags:
  - Effective JAVA 3rd
  - Effective JAVA 3rd ch2
  - JAVA
---

### 2. 생성시 파라미터가 많은 경우 builder 사용 고려하기 
static method factory와 생성자를 사용해서 객체를 생성하는 경우에 많은 optional 파라미터들에대한 확장성이 안좋다.

  * 대안 1. Telescoping constructor pattern (점층적 생성자 패턴)  
    아래 코드와 같은 방법이다 
    * 단점 : member variable 이 많아지게 되면 필요없는 필드를 저장하게 되고, 생성자가 길어짐
    
```
public class Employee01 {
    private long seq;
    private String id;
    private String name;
    private String position;
    private String department;
    private LocalDate birthDay;
    private String sex;

   public Employee01(long seq, String id, String name) {
           this.seq = seq;
           this.id = id;
           this.name = name;
       }
   
       public Employee01(long seq, String id, String name, String position) {
           this(seq, id, name);
           this.position = position;
       }
   
       public Employee01(long seq, String id, String name, String position, String department) {
           this(seq, id, name, position);
           this.department = department;
       }
   
       public Employee01(long seq, String id, String name, String position, String department, LocalDate birthDay) {
           this(seq, id, name, position, department);
           this.birthDay = birthDay;
       }
   
       public Employee01(long seq, String id, String name, String position, String department, LocalDate birthDay, String sex) {
           this(seq, id, name, position, department, birthDay);
           this.sex = sex;
       }
}
```
  * 대안 2. JavaBean pattern  
  파라미터가 없는 생성자를 호출하여 객체를 생성한 후 필요한 파라미터를 setter 메소드를 이용하여 값을 채운다.
    * 장점 : telescoping constructor pattern의 단점이 없고, 사용하기 편하며 가독성이 좋다 
    * 단점 : 
      * 여러번 호출하여 생성하기 때문에 객체의 일관성이 일시적으로 깨질 수 있어 아래와 같은 문제가 발생한다. 
        1. immutable class를 만들 수 없다.
        2. thread safety를 보장하기 위해 개발자에게 노력을 요구한다.  
        예를들어 Rects클래스의 객체 생성 시 width, height의 필수값이 세팅이 되어야 하지만
        ```
        Rects rect = new Rects(); rect.setWidth(200);
        ```
        위와 같이 width값만 생성 후 사용가능하다. 즉 동결시키는 메소드를 객체 사용 전에 호출했는지 컴파일러는 확인할 수 없기 때문이다.
        
  * **BUILDER PATTERN**  
  객체는 필수 매개변수를 갖는 생성자로 얻어낸 후 나머지 선택필드는 setter 메소드로 값을 세팅한다. 그리고 마지막에 build 메소드를 호출하여 불변 객체를 생성한다. 아래 코드를 보면 이해가 될거다
    * 불필요한 생성자를 만들지 않고 객체를 만든다.
    * 데이터의 순서에 상관 없이 객체를 만든다.
    * Client 가 봤을 때 명시적이고 이해할 수 있다.
    * 주의점 : MyBatis 를 사용 중 이라면, Default constructor 는 필요할 테니 만들어 줄 것.
```
  public class Rects {
      private final int width;
      private final int height;
      private final int margin;
      private final int padding;
      
      public static class Builder {
          private final int width;
          private final int height;
          private int margin;
          private int padding;
          
          //필수값
          public Builder(int width, int height) {
             this.width = width;
             this.height = height;
          }
  
          //optional 
          public Builder margin(int margin) {
             this.margin = margin;
             return this;
          }
  
          public Builder padding(int padding) {
             this.padding = padding;
             return this;
          }
  
          public Rects build() {
            return new Rects(this);
          }
  
      }
  
      public Rects(Builder builder) {
          width = builder.width;
          height = builder.height;
          margin = builder.margin;
          padding = builder.padding;
      }
  }
  ```  
  호출시 
  ```
  Rects rect = new Rects.Builder(200,100).margin(5).padding(10).build();
  ``` 
  
  * hierarchical model의 경우에 더 좋다! 
  ```
  public abstract class Pizza {
      public enum Topping { HAM, ONION ... }
      final set<Topping> toppings;
      
      abstract static class Builder<T extends Builder<T>> {
          EnumSet<Topping> toppings = EnumSet.noneOf(Topping.class);
          public T addTopping(Topping topping) { 
              toppings.add(Objects.requireNonNull(topping));
              return self();
          }
          
          abstract Pizza build();
      }
      
      Pizza(Builder<?> builder) {
          toppings = builder.toppings.clone();
      }
  ```
  
  ```
   NyPizza pizza = new NyPizza.Builder(SMALL).addTopping(SAUSGE).addTopping(ONION).build();
   Calzone calzone = new Calzone.Builder().addTopping(HAM).sauceInside().build();
  ```
  * 단점 : 객체를 생성하기 위해 빌더를 먼저 만들어야 한다 
    