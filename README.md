# ✈️ WithYou

![image](https://github.com/user-attachments/assets/a4082a3b-3e2d-4eff-b8ef-cac2fea736b2)

## 프로젝트 개요
WithYou는 여행 관련 iOS 앱으로, 여행 로그를 기록하고 공유할 수 있는 기능을 제공합니다. 이 앱은 Clean Architecture와 Coordinator 패턴을 기반으로 구현되었으며, RxSwift를 활용한 반응형 프로그래밍 방식을 채택하고 있습니다.

## 기술 스택
- **언어**: Swift
- **아키텍처**: Clean Architecture (Domain, Data, Presentation 계층)
- **디자인 패턴**: Coordinator 패턴, MVVM
- **의존성 주입**: DIContainer를 사용한 커스텀 DI 구현
- **비동기 처리**: RxSwift, RxCocoa
- **네트워크**: Alamofire
- **UI 레이아웃**: SnapKit
- **외부 서비스**: 카카오 로그인 (KakaoSDK)
- **이미지 처리**: Kingfisher

## 프로젝트 구조

### 주요 디렉토리 구조
```
Sources/
├── Core/               # 앱의 기본 구성요소
│   ├── Base/           # 기본 클래스 (ViewController, ViewModel 등)
│   ├── Coordinator/    # Coordinator 프로토콜 및 구현체
│   ├── Extension/      # Swift 확장 기능
│   ├── DIContainer.swift  # 의존성 주입 컨테이너
│   └── DateController.swift  # 날짜 관련 유틸리티
│
├── Domain/             # 비즈니스 로직 계층
│   ├── Model/          # 도메인 모델
│   ├── RepositoryProtocol/  # 리포지토리 인터페이스
│   └── UseCase/        # 비즈니스 로직 유스케이스
│
├── Data/               # 데이터 계층
│   ├── RepositoryImpl/  # 리포지토리 구현체
│   ├── DTO/            # 데이터 전송 객체
│   ├── Network/        # 네트워크 관련 코드
│   └── InternalData/   # 내부 데이터 관리
│
├── Coordinators/       # 화면 전환 및 흐름 관리
│
├── CommonUI/           # 공통 UI 컴포넌트
│
├── Features/           # 기능별 모듈
│   ├── LoginFeature/   # 로그인 기능
│   ├── HomeFeature/    # 홈 화면 기능
│   ├── TravelLogFeature/  # 여행 로그 기능
│   ├── CreateLogFeature/  # 로그 생성 기능
│   └── MyPageFeature/  # 마이페이지 기능
│
├── AppDelegate.swift   # 앱 생명주기 관리
└── SceneDelegate.swift # 씬 생명주기 관리
```

## 아키텍처 설명

### Clean Architecture
앱은 다음 세 가지 주요 계층으로 구성됩니다:
1. **Domain Layer**: 핵심 비즈니스 로직, 모델, UseCase 및 Repository 인터페이스
2. **Data Layer**: API 통신, 로컬 데이터 저장 및 Repository 구현체
3. **Presentation Layer**: UI 컴포넌트, ViewController, ViewModel 등

### Coordinator 패턴
- 앱의 화면 흐름을 관리하는 Coordinator 패턴을 사용합니다.
- 각 기능별로 별도의 Coordinator가 있으며, 계층적으로 구성되어 있습니다.
- AppCoordinator가 최상위 Coordinator로서 전체 앱의 흐름을 관리합니다.

### 의존성 주입 (DI)
- DIContainer 클래스를 통해 의존성 주입을 관리합니다.
- AppCoordinator에서 앱 시작 시 필요한 모든 의존성을 등록합니다.
- 리포지토리와 유스케이스가 주요 DI 대상입니다.

## 주요 기능

### 인증 및 로그인
- 카카오 로그인 지원
- 사용자 프로필 설정

### 여행 관리
- 여행 전 계획 및 준비 기능 (BeforeTravel)
- 진행 중인 여행 관리 (OnGoingTravel)
- 여행 회상 (TravelRewind)

### 여행 로그
- 여행 로그 생성 및 관리
- 포스트 작성 및 공유

## 개발 가이드라인

### 신규 기능 추가 방법
1. Domain 계층에서 필요한 모델, 리포지토리 인터페이스, 유스케이스를 정의합니다.
2. Data 계층에서 리포지토리 구현체와 필요한 DTO를 구현합니다.
3. UI 컴포넌트를 구현하고 ViewModel을 작성합니다.
4. 필요한 경우 새로운 Coordinator를 만들어 화면 흐름을 관리합니다.
5. DIContainer에 새로운 의존성을 등록합니다.

### 코드 스타일 가이드
- 함수 및 변수 명은 카멜 케이스를 사용합니다.
- 클래스명은 파스칼 케이스를 사용합니다.
- 가능한 한 프로토콜 지향 프로그래밍 방식을 따릅니다.
- UI 관련 코드는 SnapKit을 사용하여 구현합니다.

## 테스트
- 현재 Mock 리포지토리를 통한 테스트 환경이 구성되어 있습니다.
- 실제 API 연동 시 MockRepository에서 DefaultRepository로 변경이 필요합니다.

## 주의사항
- 개발 중 Coordinator 간의 참조 관계에 주의해야 메모리 누수를 방지할 수 있습니다.
- DIContainer를 통해 의존성을 주입받는 방식으로 객체 간 결합도를 낮추세요.
- 새로운 외부 라이브러리 추가 시 Project.swift 파일에 의존성을 추가해야 합니다.

## Members 

| **김도경** | **배수호** | **이승진** |
|:---:|:---:|:---:|
<img src="https://avatars.githubusercontent.com/u/91521677?v=4" width="150" height="150" />|<img src="https://avatars.githubusercontent.com/u/115385697?v=4" width="150" height="150" />|<img src="https://avatars.githubusercontent.com/u/105618997?s=400&u=6faeaa2ee1748be2377c51ffcaef34fa1bdc5ede&v=4" width="150" height="150" />|
|[@Do Gyung Kim](https://github.com/dogyungkim)|[@bae-suho](https://github.com/bae-suho)|[@SeungEEE](https://github.com/SeungEEE)|
