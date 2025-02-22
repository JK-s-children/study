# 6주차 모의 면접 - UI 편

<details>
<summary>[지혜] 앱 사이클</summary>

  #### 앱 사이클에 대해서 설명
  - Not Running: 앱이 실행되지 않은 상태 (앱이 종료되었거나 아직 실행되지 않음)
  - Inactive: 앱이 실행 중이지만, 사용자 입력을 받지 않는 상태 (전화 수신, 알림 등)
  - Active: 앱이 실행 중이며, 사용자 입력을 받을 수 있는 상태 (화면에 표시됨)
  - Background: 앱이 화면에서 보이지 않지만, 백그라운드 작업을 수행 중인 상태
  - Suspended: 앱이 백그라운드에 있지만 실행 중이 아니며, 메모리에 남아 있는 상태

  #### Scene
  iOS 13부터 도입된 개념으로, 앱의 개별 UI 및 상태를 관리하는 단위<br>
  멀티 윈도우 지원(iPad 및 macOS Catalyst) 및 멀티태스킹 기능을 제공하기 위해 등장<br>

  #### Inactive와 Active
  - Inactive: 앱이 실행 중이지만, 사용자 입력을 받을 수 없는 상태
  - Active: 앱이 실행 중이며, UI와 상호작용 가능

  #### 백그라운드로 넘어갈 때 해야 하는 작업
  데이터 저장, 네트워크 요청 종료, 타이머 정리, 리소스 해제 등<br>

  #### 실행 시점에 호출되는 delegate
  application:didFinishLaunchingWithOptions:

  #### @main과 @UIApplicationMain의 차이
  Swift에서는 앱의 진입점(Entry Point) 을 정의할 때 @main과 @UIApplicationMain을 사용할 수 있다. 그러나 iOS 14부터는 @main이 기본 방식으로 권장된다.

  #### 터치 이벤트
  iOS에서는 사용자의 터치 이벤트를 터치 이벤트 객체(UIEvent) 를 통해 전달한다. UIKit의 Responder Chain(응답자 체인)을 따라 터치 이벤트가 전파되며, 터치 이벤트는 UIApplication → UIWindow → UIView 순서로 전달된다.<br>

  1️⃣ 사용자가 화면을 터치하면, iOS 시스템이 이벤트를 감지하고 UIApplication에 전달<br>
  2️⃣ UIApplication은 이벤트를 UIWindow로 전달<br>
  3️⃣ UIWindow는 적절한 UIView로 이벤트를 전달 (hitTest를 이용해 최상위 뷰 찾기)<br>
  4️⃣ 이벤트를 받은 UIView가 touchesBegan, touchesMoved, touchesEnded 등의 메서드 호출<br>
  5️⃣ 뷰가 이벤트를 처리하지 않으면, Responder Chain(응답자 체인)을 따라 부모 뷰로 이벤트 전달<br>

</details>

<details>
<summary>[석영] 뷰 사이클, 뷰 컨트롤러 사이클</summary>

  #### 뷰 컨트롤러 및 뷰의 역할 차이
  - 뷰 컨트롤러: 화면 전체의 흐름 및 뷰 관리
  - 뷰: 화면에 보이는 UI 요소 및 그리기

  #### 뷰 컨트롤러 생명주기 메서드
  - viewDidLoad()
  - viewWillAppear()
  - viewDidAppear()
  - viewWillDisappear()
  - viewDidDisappear()
  - deinit

  #### layoutSubview가 불리는 시점
  - 뷰의 크기 변경
  - 뷰가 추가될 때
  - 디바이스 회전
  - setNeedsLayout() 호출
  - 오토레이아웃 변경

  #### loadView란?
  UIViewController의 뷰를 직접 생성하고 설정하는 메서드<br>
  기본적으로 UIViewController는 loadView()를 호출하여 view 프로퍼티를 초기화한다.<br>
  스토리보드를 사용하지 않을 경우 loadView()를 오버라이드하여 직접 UIView를 생성해야 한다.<br>

</details>

<details>
<summary>[병조] 디자인 아키텍처</summary>

  #### MVC에 대해서
  iOS 개발에서 가장 기본적인 디자인 패턴<br>
  앱의 구조를 Model, View, Controller 3가지 역할로 분리하여 유지보수를 쉽게 만듦<br>
  각 요소가 분리되어 있어 코드 재사용성과 확장성이 높아짐<br>
  Controller가 비대해지는 문제<br>

  #### KVO
  객체의 속성(Property) 변화를 감지하고 자동으로 반응할 수 있는 기능<br>
  Swift 및 Objective-C에서 제공하는 관찰(Observation) 패턴<br>
  Observer 패턴을 기반으로 하며, 특정 값이 변경될 때 자동으로 알림을 받을 수 있음<br>

  #### MVVM
  MVC의 문제점(비대해지는 ViewController, Massive View Controller 문제)을 해결하기 위한 패턴<br>
  View와 Model을 직접 연결하지 않고, 중간에 ViewModel을 추가하여 데이터와 UI를 분리<br>
  Swift에서는 Combine 또는 RxSwift와 함께 사용하면 더욱 강력한 패턴이 됨<br>

  #### 아키텍처 패턴과 디자인 패턴
  아키텍처 패턴은 앱 전체의 구조를 설계하는 방식<br>
  디자인 패턴은 코드 내에서 특정 문제를 해결하는 일반적인 방법<br>

</details>

<details>
<summary>[효준] 오토레이아웃</summary>

  #### frame과 bounds의 차이
  - frame: 뷰의 “부모 뷰(Superview)” 기준 위치 및 크기
  - bounds: 뷰 자신의 내부 좌표 기준 위치 및 크기

  #### intrinsicContentSize
  UIView의 기본 크기를 시스템에 알려주는 속성<br>
  UILabel, UIButton, UIImageView 등의 크기를 명시적으로 설정하지 않아도 자동으로 크기가 결정됨<br>
  Auto Layout에서 사용되며, 뷰의 크기를 컨텐츠 크기에 맞게 조정 가능

  #### Hugging Priority
  뷰가 가능한 한 자신의 intrinsicContentSize에 맞게 작아지려는 성질<br>
  값이 높을수록 자기 크기를 유지하려고 함 (늘어나지 않음)<br>
  텍스트가 길어도 뷰가 늘어나지 않고 원래 크기를 유지하려고 함

  #### Compression Resistance Priority
  뷰가 줄어드는 것을 방지하는 성질<br>
  값이 높을수록 뷰가 줄어들지 않으려고 함<br>
  텍스트가 길어질 경우, 다른 뷰가 줄어들고 Label은 줄어들지 않음<br>

  #### AutoLayout과 FrameLayout의 비교
  - AutoLayout: 다양한 화면 크기에 대응 가능, 화면 회전에 용이, 제약 조건 처리로 오버헤드 존재
  - FrameLayout: 직관적, 좌표 설정이므로 빠름, 고정된 크기

</details>
