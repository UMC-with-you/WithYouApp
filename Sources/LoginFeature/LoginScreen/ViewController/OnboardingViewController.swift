import UIKit
import SnapKit


public class OnBoardingViewController: BaseViewController {
 
    var pages = [
        OnBoarding1(),
        OnBoarding2(),
        OnBoarding3(),
        OnBoarding4()
    ]
    
    weak var coordinator: LoginCoordinator?
    
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var goToLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = WithYouFontFamily.Pretendard.medium.font(size: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "MainColorDark")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 17
        button.layer.cornerCurve = .continuous
        button.isHidden = true
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var pageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(named: "PointColor")
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for:.valueChanged)
        return pageControl
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageViewController()
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
        view.addSubview(goToLoginButton)
        
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
        goToLoginButton.snp.makeConstraints {
            $0.centerY.equalTo(pageControl)
            $0.trailing.equalToSuperview().offset(CGFloat(-15).adjusted)
            $0.width.equalTo(64)
            $0.height.equalTo(34)
        }
        pageControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
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

// MARK: - Scroll, pageControl delegate

extension OnBoardingViewController : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.bounds.width)
        pageControl.currentPage = Int(pageIndex)
        goToLoginButton.isHidden = pageControl.currentPage != 3
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let offset = CGPoint(x: view.frame.width * CGFloat(page), y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
}

// MARK: - 확인버튼 클릭 함수

extension OnBoardingViewController {
    @objc func confirmButtonTapped() {
        coordinator?.showLogin()
    }
}
