---
layout: post
title: "CH2 Creating and Destroying Objects"
comment: true
categories:
  - programming
  - JAVA
tags:
  - Effective JAVA 3rd
---

object 만들고 없애는 것을 다룬다.

### 1. 생성자 대신 static factory method 고려하기.

Boolean으로 예시를 들어보자면 아래와 같다!  

```
public static Boolean valueOf(boolean b) {
	return b ? Boolean.TRUE : Boolean.FALSE;
}
```

클래스가 클라이언트에게 static factory method를 생성자 대신 또는 같이 제공 할 수 있다.   

<hr/>

#### 장점

###### 1. 이름이 있다!  메소드가 이해하기 쉬움
  * BigInteger(int, int, Random)    < BigInteger.probablePrime

###### 2. 새 오브젝트를 만들 필요 없다.
  * immutable 클래스의 경우 이미 생성된 인스턴스를 다시 사용할 수 있다
  * 불필요하게 중복된 인스턴스들이 생성되는 것을 방지하기 위해 이미 생성된 인스턴스를 저장했다가 반복 사용 가능.
  * Flyweight 패턴과 유사 : 객체 생성시 자원/시간이 많이 들면 프로그램 성능 크게 향상시킬 수 있다
  * 여러번 호출되어도 이미 생성된 동일 객체를 반환하기 때문에 클래스에서 언제든지 인스턴스 존재를 직접 제어할 수 있다 (instance-controlled class)
    * instance-controlled class 작성 이유.
      * 싱글톤(singleton) 또는 인스턴스 생성 불가(noninstantiable) 클래스로 만들 수 있음
      * 불변 클래스에서 두 개의 동일한 인스턴스가 생기지 않도록 해줌
      * 인스턴스의 동일 여부 확인할 때 equals(Object) 대신 == 연산자 사용 가능 

###### 3. subtype을 리턴타입으로 할 수 있다. 
  * public으로 선언하지 않은 클래스 객체를 반환하는 api를 만들 수 있다.
  * implementation을  숨김으로서 api를 작게만들 수 있다. ( Item 20. interface-based framework )  
  * public static factory method가 반환하는 클래스가 public일 필요가 없어 인자로 어떤 클래스의 객체를 만들지 동적으로 결정 가능.

  * java8 이전에는 interface가 static  method를 가지지 못했다.
    > 관습에 따라 Type이라는 인터페이스의 정적 팩토리 메소드는 Types라는 noninstantiable companion 클래스에 넣어졌습니다.  
Collections에는 45개의 utility 인터페이스 중 대부분은 noninstantiable companion 클래스(java.util.Collections)에 있는 static 팩토리 메소드를 통해서 객체를 생성하는데, 이 때 반환되는 객체의 클래스들은 모두 public이 아니다.   

  * 컬렉션 프레임워크 API는 규모가 매우 작은데, 이를 구현하는 클래스를 45개의 public 클래스로 따로 사용해야 했다면 규모가 커졌을 것 API 사용자 입장에서는 반환되는 객체가 해당 컬렉션 인터페이스에 지정된 API를 갖는다는 것만 알면 되는데 API를 구현하는 클래스를 상세히 알 필요가 없음  
  * static 팩토리 메소드를 사용해 객체를 생성하므로 반환 객체의 타입을 참조할 때 컬렉션의 구현 클래스 별로 따로 참조하지 않고 인터페이스 타입으로 참조 하도록 요구한다. 
    > static 팩토리 메소드를 갖는 클래스를 작성하는 시점에 메소드로부터 반환되는 객체의 클래스가 존재하지 않아도 됨   
    자바 데이터베이스 연결 API와 같은 서비스 제공자 프레임워크(service provider framework)의 근간

  * java8 변경사항 
    > java8에서 인터페이스에 정적 메소드를 포함할 수 있게 되어 인터페이스에 public static member들을 넣어야합니다.  
그러나 java8에서 모든  static method를 public으로 만들어야 하기 때문에 구현 코드들을 별도의 private class에 넣어줘야 할 수도 있습니다.   
java9에서는 private static method를 허용하지만 static fields 와 static member classes는 public으로 만들어야 합니다


###### 4. object를 반환하는 클래스 함수의 parameter로 불릴때의 다양성


###### 5. 메소드를 포함한 클래스 생성시에 반환된 객체가 존재할 필요 없다. 
  * service provider framework의 기본 마인드!
  * 구성 Compenent
    1. Service Interface : Service 사용자에게 제공하기 위해 표준?으로 정한 API가 정의된 Interface
    2. Service Registration API : Provider Interface의 구현체를 등록하는 API
    3. Service Access API : Service Interface의 구현체를 얻어오는 API (정적 팩토리 메소드1)
    4. Provider Interface : Service Interface의 하위 객체를 생성해주는 API가 정의된 Interface

```
// 1) Service Interface
public interface Service {
...
}

// 4) Provider Interface
public interface Provider {
	Service newService();
}

// 팩토리 클래스 & 객체생성불가능 클래스
public class Services {
	private static final Map<String, Provider> providersMap = new ConcurrentHasshMap<String, Provider>();
	
	private Services() {
	} // 객체생성방지

// 2) Service Registration API
	public static void registerProvider(String name, Provider provider) {
		providersMap.put(name, provider);
	}
	
// 3) Service Access API (정적 팩토리 메소드)
	public static Service getMyService(String name) {
		Provider provider = proidersMap.get(name);
		if (provider != null) {
			return provider.newService();
		} else {
			throw new IllegalArgumentException("No Provider");
		}
	}
}
```
<hr/>

#### 단점

###### 1. 인스턴스 생성을 위해 static 팩토리 메소드만 갖고 있는 경우, public이나 protected 생성자가 없는 클래스는 서브 클래스를 가질 수 없다.

###### 2. 프로그래머가 찾기 힘들다 ( 다른 static 메소드와 쉽게 구별할 수 가 없음 )
  * 해결책 : 주석을 통해 static factory method라는것을 알려야 한다 
  * common names 
    * from - 타입변경  
    * of  - 집합 
    * valueof - from과 of의 합
    * getInstance  - 파라미터를 적용한 instance를 반환
    * create or newInstance  - getInstance와 같지만 매번 새 객체 반환 
    * getType - getInstance와 같지만 다른 클래스에서 사용됨 
    * newType - newInstance와 같지만 다른 클래스에서 사용됨  
    * type  - getType과 newType의 합 
    
    
#### 요약
  > static factory method와 public constructor가 각 사용법이 있다. 무조건 static factory method를 쓰지말고 잘 생각해서 쓸 것 
  

-----
  
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
    



-----

### 3. private 생성자나 enum에 싱글톤 property 강제하기 


-----

### 4. 객체 생성을 막을때 private 생성자 사용하기

-----

### 5. hard writting작업시 의존선 주입 추천

-----

### 6. 필요없는 객체 생성 비추천

-----

### 7. 오래된 객체의 레퍼런스 삭제하기 

-----

### 8. finalizers와 cleaners 피하기 

-----

### 9. try-finally보단 try-with-resource 사용하기 

-----

##### 참고 
  * https://johngrib.github.io/wiki/static-factory-method-pattern/
  * http://hahaha333.egloos.com/3901991
  * http://casek.tistory.com/entry/Effective-Java-2%EC%9E%A5-%EA%B0%9D%EC%B2%B4%EC%9D%98-%EC%83%9D%EC%84%B1%EA%B3%BC-%EC%82%AD%EC%A0%9C?category=574307


