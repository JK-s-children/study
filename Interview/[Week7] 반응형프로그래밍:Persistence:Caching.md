# 7주차 모의 면접 - 반응형프로그래밍 Persistence Caching

<details>
<summary>[지혜] 반응형 프로그래밍</summary>

  #### 반응형 프로그래밍에 대해서 설명
  앱의 데이터가 변화되었을 때 자동으로 그것에 반응해서 뷰가 바뀌는 프로그래밍을 말합니다.
 
  #### 반응형 프로그래밍에서 선언적 프로그래밍에 대해서 설명
  선언적 프로그래밍은 명령을 내리는 게 아닌, 데이터가 바뀌었을 때, 데이터의 변화에 반응해서 자동으로 처리

  #### 선언형 프로그래밍에서 구조체를 자주 활용하는 이유? 
  값 타입으로 불변성을 가지기 때문에, 선언적 프로그래밍에서 사용된다.

  #### Pub-Sub vs. Observer
  중계자의 유무
  
  #### 중계자의 유무에 대한 차이점 
  중계자가 있게 되면 결합도가 낮아지게 된다. 
  
  #### 비동기 vs. 반응형 
  - 비동기: 어떤 이벤트를 실행했을 때 그 결과로 콜백을 받아서 이 콜백을 실행하는 게 비동기 형태
  - 반응형: 관찰하는 대상이 바뀌었을 때 자동으로 이제 바뀐 부분을 적용
  
  #### Rx vs. Combine 
  - Rx: Third Party
  - Combine: First Party, 성능 이점
  
  #### 연속적인 버튼(ex 좋아요 버튼)의 경우 이벤트 처리
  - 버튼 눌릴시, API 요청까지 버튼을 disabled시킴.
  - 이전에 발행한 이벤트를 취소
  
  #### MVC에서 반응형 사용하면 장점? 
  View & Model간의 의존도가 낮아짐.
  
  #### HTTP 요청시 async vs. stream
  HTTP요청은 일회성이기에 Swift Concurreny를 사용할 꺼 같음. <br>
  UI바인딩을 위해서는 Stream을 사용할꺼 같음.

</details>

<details>
<summary>[병조] Persistence</summary>

  #### UserDefaults vs. Keychain
  - UserDefaults: 암호화 X, 심플한 데이터 저장
  - Keychain: 암호화, 민감한 비밀번호 / 토큰등을 저장

  #### UserDefaults에서 큰 데이터의 경우
  용도가 맞지 않는다 <br>
  -> UserDefaults에서 메모리 캐싱도 이루어지기에, 용량부족으로 이어질 수 있음.
  
  #### KeyChain은 SandBox화 될까
  앱 샌드박스 개념에 따르면 따로 관리하는 게 아마 서로 다른 앱들에 영향을 주지 않아서 편리할 수 있을 것 같음.
 
  #### CoreData vs. SQLite
  - SQLite: DB
  - CoreData: DB위에 있는 Framework로, 객체랑 엔트키랑 매핑을 DB에 저자
  
  #### CoreData에서 여러곳에서 Context Save할 경우 
  Context마다 작업을 관리하는 Queue와 Container마다 메인으로 관리하는 Queue가 있음. <br>
  이를 통해 데이터의 무결성을 유지
</details>

<details>
<summary>[석영] Cache</summary>

  #### 디스크 캐시 vs. 메모리 캐시
  - 디스크 캐시: 파일 시스템에 저장, 비휘발성, 용량이 큼. 
  - 메모리 캐시: RAM에 저장, 휘발성, 디스크 캐시에 비해 빠름.

  #### 디스크 캐싱의 경우, SandBox에 어떤 디렉토리에 저장할 것인지.
  Cache 디렉토리
  - Doc: iCloud에 같이 동기화됨. 
  - Temp: 임시적인 데이터
  - Cache: 캐시 데이터

  #### 캐시 자료구조 
  - Dictionary: hash를 통해 O(1)에 데이터를 접근할 수 있음.
  - 자가 밸런싱 트리: O(logN)에 데이터를 접근할 수 있으며, 우선순위 기반 정렬가능 
  
  #### 캐시 구현시 NSCache vs. Dictionary
  - NSCache: Class타입만 가능, Replace를 자동으로 해줌. 
  - Dictionary: Value타입도 가능, Replace직접 구현해야 함.
</details>
