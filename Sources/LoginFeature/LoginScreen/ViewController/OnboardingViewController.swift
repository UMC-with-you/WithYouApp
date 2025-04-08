import UIKit
import SnapKit


public class OnBoardingViewController: BaseViewController {
 
    var pages = [
        OnBoarding1(),
        OnBoarding2(),
        OnBoarding3(),
        OnBoarding4()
    ]
    
    let loginView = LoginView()
    
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var pageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for:.valueChanged)
        return pageControl
    }()
    
    public var coordinator : LoginDelegate?
    
    var viewModel : LoginViewModel
    
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageViewController()
    }
    
    public override func setFunc() {
        loginView.appleLoginButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe{ (owner,_)in
                owner.viewModel.appleLogin()
            }
            .disposed(by: disposeBag)
        
        loginView.kakaoLoginButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe{ (owner,_) in
                //owner.viewModel.kakaoLogin()
//                owner.coordinator?.moveToTabbar()
                owner.coordinator?.moveToProfileSetting()
            }
            .disposed(by: disposeBag)
        
        viewModel.loginService
            .loginResultSubject
            .withUnretained(self)
            .subscribe(onNext: { (owner,result) in
                print(result)
                if result {
//                    owner.coordinator?.moveToTabbar()
                    owner.coordinator?.moveToProfileSetting()
                }
            })
            .disposed(by: disposeBag)
    }
    
    public override func setUpViewProperty() {
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        
        let profileView = ProfileView(size: .small)
        profileView.bindTraveler(traveler: Traveler(id: 3, name: "테스트"))
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: profileView)]
    }
    
    public override func setUp() {
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        
        self.pages.append(self.loginView)
        pages.forEach{
            scrollView.addSubview($0)
        }
        
        scrollView.delegate = self
    }
    
    public override func setLayout() {
        scrollView.snp.makeConstraints{
            $0.width.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
        pageControl.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setUpPageViewController() {
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(pages.count), height: view.bounds.height)
        
        for i in 0..<pages.count {
            pages[i].frame = CGRect(x: view.bounds.width * CGFloat(i) , y: 0, width: view.bounds.width, height: view.bounds.height)
        }
    }
}

extension OnBoardingViewController : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.bounds.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let offset = CGPoint(x: view.frame.width * CGFloat(page), y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
}
