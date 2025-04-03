# WithYou 앱의 DIContainer 사용 가이드

## DIContainer란?
DIContainer는 WithYou 앱에서 의존성 주입(Dependency Injection)을 관리하기 위한 핵심 컴포넌트입니다. 이를 통해 객체 간의 결합도를 낮추고, 테스트 용이성과 코드 유지보수성을 높일 수 있습니다.

## DIContainer 사용 방법

### 1. 의존성 등록하기 (AppCoordinator에서)
앱 시작 시 `AppCoordinator`의 `prepareForDI()` 메서드에서 모든 의존성을 등록합니다:

```swift
// AppCoordinator.swift 내부
private func prepareForDI() {
    let container = DIContainer.shared
    
    // 리포지토리 등록
    // 이때 Repository를 먼저 등록해야 아래 UseCase에서 의존성 주입이 가능합니다.
    container.register(MyNewRepository.self) {
        DefaultMyNewRepository() // 또는 MockMyNewRepository()
    }
    
    // 유스케이스 등록 (의존성이 있는 경우)
    container.register(MyNewUseCase.self) {
        let repository = container.resolve(MyNewRepository.self)!s
        return DefaultMyNewUseCase(repository: repository)
    }
}
```

### 2. ViewModel에서 의존성 주입받기
각 화면의 ViewModel은 생성자를 통해 의존성을 주입받습니다. 
Coordinator에서 ViewModel을 생성할 때 DIContainer에서 해결한 의존성을 주입합니다:

```swift
// Coordinator에서
public func start() {
    // DIContainer에서 필요한 유스케이스 가져오기
    let myNewUseCase = DIContainer.shared.resolve(MyNewUseCase.self)!
    
    // ViewModel 생성 및 의존성 주입
    let viewModel = MyNewViewModel(useCase: myNewUseCase)
    
    // ViewController 생성 및 설정
    let viewController = MyNewViewController(viewModel: viewModel)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
}
```

### 3. Repository 구현체 만들기
새로운 기능에 대한 Repository를 구현할 때는 다음과 같은 순서로 진행합니다:

1. 먼저 Domain 계층에 Repository 인터페이스 정의:
```swift
// Domain/RepositoryProtocol/MyNewRepository.swift
protocol MyNewRepository {
    func fetchData() -> Single<[MyData]>
}
```

2. Data 계층에 실제 Repository 구현체 작성:
```swift
// Data/RepositoryImpl/DefaultMyNewRepository.swift
class DefaultMyNewRepository: MyNewRepository {
    func fetchData() -> Single<[MyData]> {
        // 실제 API 호출 또는 데이터 처리 로직
    }
}
```

3. 테스트용 Mock Repository 작성: (서버와 직접 연결하지 않고 테스트를 해야할 때 사용)
```swift
// Data/RepositoryImpl/MockMyNewRepository.swift
class MockMyNewRepository: MyNewRepository {
    func fetchData() -> Single<[MyData]> {
        // 테스트용 데이터 반환
        return .just([/* 테스트 데이터 */])
    }
}
```

### 4. UseCase 구현하기
비즈니스 로직을 담당하는 UseCase 구현:

1. Domain 계층에 UseCase 인터페이스 정의:
```swift
// Domain/UseCase/MyNewUseCase.swift
protocol MyNewUseCase {
    func processData() -> Single<[ProcessedData]>
}
```

2. UseCase 구현체 작성:
```swift
// Domain/UseCase/DefaultMyNewUseCase.swift
class DefaultMyNewUseCase: MyNewUseCase {
    private let repository: MyNewRepository
    
    init(repository: MyNewRepository) {
        self.repository = repository
    }
    
    func processData() -> Single<[ProcessedData]> {
        return repository.fetchData().map { dataArray in
            // 비즈니스 로직 처리
            return dataArray.map { ProcessedData(from: $0) }
        }
    }
}
```

### 5. ViewModel에서 UseCase 사용하기
```swift
class MyNewViewModel {
    private let useCase: MyNewUseCase
    private let disposeBag = DisposeBag()
    
    // 뷰에 데이터를 전달할 Subject/Relay
    let processedData = PublishSubject<[ProcessedData]>()
    
    init(useCase: MyNewUseCase) {
        self.useCase = useCase
    }
    
    func loadData() {
        useCase.processData()
            .subscribe(onSuccess: { [weak self] data in
                self?.processedData.onNext(data)
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
```

## DIContainer의 장점

1. **결합도 감소**: 객체 간의 의존성을 직접 생성하지 않고 외부에서 주입받아 결합도를 낮춥니다.
2. **테스트 용이성**: Mock 객체를 쉽게 주입할 수 있어 단위 테스트가 용이합니다.
3. **코드 유지보수성**: 의존성 변경 시 사용처를 일일이 수정할 필요 없이 DIContainer만 수정하면 됩니다.
4. **코드 가독성**: 객체 생성 로직이 한 곳에 집중되어 코드 가독성이 향상됩니다.

## 주의사항

1. DIContainer에 등록하는 모든 타입은 프로토콜로 정의하여 구현체와 인터페이스를 분리하는 것이 좋습니다.
2. 실제 개발 환경에서는 `Mock` 구현체 대신 `Default` 구현체를 사용해야 합니다.
