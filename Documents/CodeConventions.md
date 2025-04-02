# WithYou 앱 코드 컨벤션

## 프로젝트 구조

프로젝트는 Clean Architecture와 MVVM 패턴을 기반으로 구성되어 있으며, 기능별 모듈화를 통해 관리되고 있습니다.

### 디렉토리 구조

- **Sources/**: 앱의 모든 소스 코드가 포함된 루트 디렉토리
  - **Feature 모듈**: `HomeFeature`, `LoginFeature`, `MyPageFeature`, `TravelLogFeature`, `CreateLogFeature` 등
  - **Core/**: 앱의 핵심 구성요소
  - **Domain/**: 비즈니스 로직 및 모델
  - **Data/**: 데이터 처리 로직
  - **CommonUI/**: 공통 UI 컴포넌트
  - **Coordinators/**: 화면 전환 및 내비게이션 관리

## 아키텍처 패턴

### Clean Architecture

- **Domain Layer**: 비즈니스 로직을 포함하며, 다른 레이어에 대한 의존성이 없습니다.
  - `Model/`: 비즈니스 엔티티
  - `RepositoryProtocol/`: 데이터 접근을 위한 인터페이스
  - `UseCase/`: 비즈니스 로직 집합

- **Data Layer**: 데이터 관리 및 저장소 구현
  - `RepositoryImpl/`: Repository 프로토콜 구현체
  - `DTO/`: 데이터 전송 객체
  - `Network/`: 네트워크 통신 관련 클래스
  - `InternalData/`: 내부 데이터 관리 클래스

- **Presentation Layer**: UI 관련 구현
  - 각 Feature 디렉토리 내부에 MVVM 패턴으로 구성:
    - `View/`: UI 컴포넌트
    - `ViewController/`: 화면 컨트롤러
    - `ViewModel/`: 뷰 로직 및 상태 관리

### Coordinator 패턴

앱의 화면 전환 및 내비게이션 흐름을 관리하기 위해 Coordinator 패턴을 사용합니다:
- `Coordinator` 프로토콜: 모든 코디네이터 구현의 기본
- 계층적 구조: `AppCoordinator` → 기능별 코디네이터(`TabbarCoordinator`, `LoginCoordinator` 등)

### 의존성 주입

`DIContainer` 클래스를 사용하여 의존성 주입을 관리:
- 싱글톤 패턴으로 구현
- `register()`: 서비스 등록
- `resolve()`: 서비스 인스턴스 획득

# 코딩 스타일 가이드

### 네이밍 컨벤션

- **클래스/구조체**: UpperCamelCase (`HomeViewController`, `UserModel`)
- **변수/상수/함수**: lowerCamelCase (`userName`, `fetchData()`)
- **프로토콜**: 명사/형용사 + Protocol 또는 -able, -ing 접미사 (`RepositoryProtocol`, `Coordinator`)
- **확장**: 기능을 명확히 표현 (`UIView+Layout`, `String+Validation`)

### 기능 모듈화

각 기능은 독립적인 모듈로 구성:
- `xxxFeature/`: 해당 기능의 루트 디렉토리
  - `xxxScreen/`: 특정 화면
    - `View/`: UI 컴포넌트
    - `ViewController/`: 화면 컨트롤러
    - `ViewModel/`: 뷰모델

## 반응형 프로그래밍

RxSwift를 사용한 반응형 프로그래밍을 적용:
- 모든 ViewController는 `disposeBag`을 포함
- ViewModel과 View 간의 데이터 바인딩에 사용

```swift
// ViewModel의 데이터를 View에 바인딩하는 예시
viewModel.items
    .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { ... }
    .disposed(by: disposeBag)
```

## 주석 스타일

- 주요 기능과 복잡한 로직에 주석 추가
- 공개 API에는 문서화 주석 사용
- `MARK:`, `TODO:`, `FIXME:` 등의 표준화된 표시 사용

```swift
// MARK: - 라이프사이클 메서드

// TODO: 나중에 이 부분을 최적화할 필요가 있음

/// 사용자 데이터를 가져오는 함수
/// - Parameter id: 사용자 식별자
/// - Returns: 사용자 모델 객체
```

# 뷰 컴포넌트 설정 가이드

## 베이스 뷰 클래스 구조

### BaseUIView
모든 커스텀 뷰는 `BaseUIView`를 상속받으며 다음 라이프사이클을 따릅니다:
1. `initUI()`: 뷰 계층 구조 설정 (addSubview)
2. `initLayout()`: 레이아웃 제약조건 설정 (SnapKit)

```swift
class CustomView: BaseUIView {
    // UI 요소 선언
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        label.textColor = .black
        return label
    }()
    
    // initUI 메서드 오버라이드
    override func initUI() {
        self.addSubview(titleLabel)
        // 또는 여러 뷰 요소를 한번에 추가
        [titleLabel, imageView, button].forEach {
            self.addSubview($0)
        }
    }
    
    // initLayout 메서드 오버라이드
    override func initLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(16)
        }
    }
}
```

### BaseViewController
모든 ViewController는 `BaseViewController`를 상속받으며 다음 구조를 따릅니다:
1. `setUpViewProperty()`: 뷰 속성 설정
2. `setUp()`: 뷰 계층 설정
3. `setLayout()`: 레이아웃 설정
4. `setDelegate()`: 델리게이트 설정
5. `setFunc()`: 기능 설정

```swift
class SomeViewController: BaseViewController {
    // 커스텀 뷰 선언
    private let customView = CustomView()
    
    override func setUpViewProperty() {
        view.backgroundColor = .white
    }
    
    override func setUp() {
        view.addSubview(customView)
    }
    
    override func setLayout() {
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
```

## 뷰 요소 초기화 패턴

### 속성 초기화자 패턴
클로저를 사용한 UI 요소 초기화 패턴:

```swift
let button: UIButton = {
    let button = UIButton()
    button.setTitle("확인", for: .normal)
    button.backgroundColor = WithYouAsset.mainColorDark.color
    button.layer.cornerRadius = 8
    return button
}()
```

### 다양한 커스텀 이니셜라이저
목적에 맞는 초기화 메서드를 제공:

```swift
// 기본 초기화
public init() {
    super.init(frame: .zero)
    setUp()
}

// 이미지 이름으로 초기화
public init(_ label: String, imageName: String) {
    super.init(frame: .zero)
    self.label.text = label
    self.imageView = UIImageView(image: UIImage(named: imageName))
    setUp()
}
```

## 하위 뷰 추가 방법

### 개별 추가
각 뷰를 개별적으로 추가:

```swift
override func initUI() {
    self.addSubview(titleLabel)
    self.addSubview(descriptionLabel)
    self.addSubview(imageView)
}
```

### 배열 사용 (forEach)
여러 뷰를 배열로 묶어 한번에 추가:
뷰를 나눠서 연관된 애들을 배열로 묶어서 추가하면 좋음

```swift
override func initUI() {
    [titleLabel, descriptionLabel, imageView, button].forEach {
        self.addSubview($0)
    }
}
```

## 레이아웃 설정

### SnapKit 사용
모든 레이아웃 제약조건은 SnapKit을 사용해 설정:

```swift
override func initLayout() {
    titleLabel.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(16)
        make.leading.trailing.equalToSuperview().inset(20)
    }
    
    imageView.snp.makeConstraints { make in
        make.top.equalTo(titleLabel.snp.bottom).offset(12)
        make.centerX.equalToSuperview()
        make.size.equalTo(CGSize(width: 120, height: 120))
    }
}
```

### 커스텀 레이아웃 헬퍼
자주 사용하는 레이아웃 패턴은 확장으로 구현:

```swift
// BaseUIView 확장
extension BaseUIView {
    public func addUnderline(to label: UILabel, thickness: CGFloat, color: UIColor) {
        let underline = UILabel()
        underline.backgroundColor = color
        self.addSubview(underline)
        underline.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(label)
            make.height.equalTo(thickness)
        }
        self.bringSubviewToFront(label)
    }
}
```

## 재사용 가능한 컴포넌트

### 재사용 가능한 뷰 컴포넌트
자주 사용되는 UI 패턴은 재사용 가능한 컴포넌트로 구현:

```swift
// 2개의 요소를 포함하는 라인 뷰
public class TwoComponentLineView: UIView {
    // 이니셜라이저 및 설정 메서드 구현
    public init(_ label: String, imageView: UIView) {
        super.init(frame: .zero)
        self.label.text = label
        self.imageView = imageView
        setUp()
    }
}

// 사용 예시
let settingsRow = TwoComponentLineView("설정", imageName: "settings_icon")
```

### 공통 스타일 적용
여러 UI 요소에 동일한 스타일 적용:

```swift
[question1Label, question2Label, question3Label].forEach {
    $0.font = WithYouFontFamily.Pretendard.medium.font(size: 14)
    $0.textColor = UIColor(named: "MainColorDark")
}
```

## ViewController에서 커스텀 뷰 사용

### View Controller에 커스텀 뷰 추가
```swift
public class MyPageViewController: BaseViewController {
    // 커스텀 뷰 인스턴스 생성
    private let myPageView = MyPageView()
    
    // ViewModel 선언
    private let viewModel: MyPageViewModel
    
    // 초기화 
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // 뷰 계층 설정
    public override func setUp() {
        view.addSubview(myPageView)
    }
    
    // 레이아웃 설정
    public override func setLayout() {
        myPageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
```
```
