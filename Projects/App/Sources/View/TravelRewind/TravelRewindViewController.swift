
import RxCocoa
import RxGesture
import RxSwift
import UIKit
import SnapKit

class TravelRewindViewController: UIViewController{
    
    var logMembers = PublishSubject<[Traveler]>()
    
    var bag = DisposeBag()
    
    var log : Log?
    
    var rewindId : Int?
    
    lazy var moodPopup: MoodPopupViewController = {
        let popup = MoodPopupViewController()
        popup.modalPresentationStyle = .overFullScreen
        return popup
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 32.0)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 20.0)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let todaysMoodLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 기분"
        label.font = UIFont(name: "Pretendard-Semibold", size: 14.0)
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let moodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor(named: "SubColor")?.cgColor
        imageView.layer.cornerRadius = 9.0 // 원하는 라운드 값으로 수정
        return imageView
    }()
    
    let selectImageButton: UIButton = {
        let button = UIButton()
        
        if let originalImage = UIImage(systemName: "plus.circle.fill") {
            // 원하는 색상으로 이미지 채색
            let tintedColor = UIColor(named: "SubColor") ?? .blue
            let tintedImage = originalImage.withTintColor(tintedColor, renderingMode: .alwaysOriginal)
            
            // 크기 조절
            let newSize = CGSize(width: 26, height: 26)
            let resizedImage = UIGraphicsImageRenderer(size: newSize).image { _ in
                tintedImage.draw(in: CGRect(origin: .zero, size: newSize))
            }
            button.setImage(resizedImage, for: .normal)
            button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        }
        button.backgroundColor = .clear
        
        return button
    }()
    
    let question1Label: UILabel = {
        let label = UILabel()
        label.text = "#1. 오늘 여행의 MVP"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - collectionView
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20 // cell사이의 간격 설정
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: 70, height: 85)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .white
        return view
    }()
    
    let question2Label: UILabel = {
        let label = UILabel()
        label.text = "#2. 오늘 여행에서, 어떤 순간이 가장 기억에 남아?"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let question2TextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Pretendard-Regular", size: 13.0)
        textField.placeholder = "내용을 입력해주세요"
        return textField
    }()
    
    let question3Label: UILabel = {
        let label = UILabel()
        label.text = "#3. 오늘 여행에서, 조금 아쉬웠던 점이 있을까?"
        label.numberOfLines = 0
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let question3TextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Pretendard-Regular", size: 13.0)
        textField.placeholder = "내용을 입력해주세요"
        return textField
    }()
    
    let question4Label: UILabel = {
        let label = UILabel()
        label.text = "오늘 나와 특별한 여행을 함께한 나의 YOU에게 전하고 싶은 말을 적어줘!"
        label.numberOfLines = 0
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        return label
    }()
    
    let question4TextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Pretendard-Regular", size: 13.0)
        textField.placeholder = "내용을 입력해주세요"
        return textField
    }()
    
    
    let question5Label: UILabel = {
        let label = UILabel()
        label.text = "오늘 나와 특별한 여행을 함께한 나의 YOU에게 전하고 싶은 말을 적어줘!"
        label.numberOfLines = 0
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        return label
    }()
    
    let question5TextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Pretendard-Regular", size: 13.0)
        textField.placeholder = "내용을 입력해주세요"
        return textField
    }()
    
    let mainView = {
        let view = UIView()
        return view
    }()
    
    let scrollView = UIScrollView()
    
    let navigationTitle = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        label.text = "오늘의 여행 Rewind"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        return label
    }()

    let addButton = WYButton("저장하기")
    
    //Rewind 작성을 위한 변수들
    var mvpCandidate = 0
    var moodTag = ""
    
    var qnaList = [RewindQna]()
    
    let moodImageTags = [
        "heart","lucky","surprised","angry","touched","sunny","sad","soso"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupDataSource()
        
        setupUI()
        setQuestion()
        bindInfo()
        registerCell()
        setupDelegate()
    }
    
    private func setQuestion(){
        self.qnaList = []
        print(rewindId)
        if let id = rewindId {
            RewindService.shared.getOneRewind(travelId: self.log!.id, rewindId: id){ response in
                self.qnaList = response.rewindQnaList
                [self.question2Label,self.question3Label,self.question4Label,self.question5Label].enumerated().forEach { (index,label) in
                    label.text = "#\(index + 2) " + self.qnaList[index].content
                }
            }
        } else {
            RewindService.shared.getQnaList{ response in
                for _ in 0..<4{
                    let qna = response.randomElement()
                    self.qnaList.append(RewindQna(qnaId: 0, questionId: qna!.id, content: qna!.content, answer: ""))
                }
                [self.question2Label,self.question3Label,self.question4Label,self.question5Label].enumerated().forEach { (index,label) in
                    label.text = "#\(index + 2) " + self.qnaList[index].content
                }
            }
        }
       
    }
    
    private func bindInfo(){
        dayLabel.text = dateController.days(from: log!.startDate)
        titleLabel.text = log?.title
        
        logMembers
            .bind(to: collectionView.rx.items(cellIdentifier: MemberCell.id, cellType: MemberCell.self)){ index, item, cell in
                cell.bind(traveler: item)
            }
        .disposed(by: bag)
        
        collectionView.rx.modelSelected(Traveler.self)
            .map{ $0.id }
            .subscribe{ id in
                print("MVP  : \(id)")
                if self.mvpCandidate != 0 {
                    self.mvpCandidate = id
                } else {
                    self.mvpCandidate = 0
                }
                
            }
            .disposed(by: bag)
        
        //멤버 정보 가져오기
        LogService.shared.getAllMembers(logId: log!.id){ response in
            self.logMembers.onNext(response)
        }
        
        addButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe{ _ in
                var postQna = [RewindQnaPostRequest]()
                [self.question2TextField,self.question3TextField,self.question4TextField,self.question5TextField].enumerated().forEach{ index , field in
                    postQna.append(RewindQnaPostRequest(questionId: self.qnaList[index].questionId, answer: field.text!))
                }
                
                let rewind = RewindPostRequest(day: dateController.daysAsInt(from: self.log!.startDate),
                                               mvpCandidateId: self.mvpCandidate,
                                               mood: self.moodTag.uppercased(),
                                               qnaList: postQna,
                                               comment: "")
                
                RewindService.shared.postRewind(rewindPostRequest: rewind, travelId: self.log!.id){ response in
                    self.rewindId = response.rewindId
                    self.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: bag)
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        self.navigationItem.titleView = self.navigationTitle
        
        mainView.addSubview(dayLabel)
        mainView.addSubview(titleLabel)
        mainView.addSubview(todaysMoodLabel)
        mainView.addSubview(moodImageView)
        mainView.addSubview(selectImageButton)
        mainView.addSubview(question1Label)
        mainView.addSubview(collectionView)
        mainView.addSubview(question2Label)
        mainView.addSubview(question2TextField)
        mainView.addSubview(question3Label)
        mainView.addSubview(question3TextField)
        mainView.addSubview(question4Label)
        mainView.addSubview(question4TextField)
        mainView.addSubview(question5Label)
        mainView.addSubview(question5TextField)
        mainView.addSubview(addButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //ContentView
        mainView.snp.makeConstraints{
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel.snp.leading)
        }
        
        // Add underline to titleLabel text with a thickness of 7px and color named "PointColor"
        addUnderline(to: titleLabel, thickness: 7, color: UIColor(named: "UnderlineColor") ?? .black)
        
        todaysMoodLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.top).offset(5)
            make.trailing.equalTo(dayLabel.snp.trailing).offset(-10)
        }
        
        moodImageView.snp.makeConstraints { make in
            make.centerX.equalTo(todaysMoodLabel)
            make.top.equalTo(todaysMoodLabel.snp.bottom).offset(8)
            make.width.equalTo(todaysMoodLabel.snp.width).multipliedBy(0.75)
            make.height.equalTo(moodImageView.snp.width)
        }
        selectImageButton.snp.makeConstraints { make in
            make.center.equalTo(moodImageView.snp.center)
        }
        question1Label.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(question1Label.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.93)
            make.height.equalTo(collectionView.snp.width).multipliedBy(0.34)
        }
        
        question2Label.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(collectionView.snp.trailing)
        }
        
        question2TextField.snp.makeConstraints {make in
            make.top.equalTo(question2Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.width.equalTo(dayLabel)
            make.height.equalTo(49)
        }
        question3Label.snp.makeConstraints { make in
            make.top.equalTo(question2TextField.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(collectionView.snp.trailing)
        }
        
        question3TextField.snp.makeConstraints {make in
            make.top.equalTo(question3Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.width.equalTo(dayLabel)
            make.height.equalTo(49)
        }
        
        question4Label.snp.makeConstraints { make in
            make.top.equalTo(question3TextField.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
            make.trailing.equalToSuperview().offset(15)
            make.width.equalTo(dayLabel)
            make.trailing.equalTo(collectionView.snp.trailing)
        }
        
        question4TextField.snp.makeConstraints {make in
            make.top.equalTo(question4Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.width.equalTo(dayLabel)
            make.height.equalTo(49)
        }
        
        question5Label.snp.makeConstraints { make in
            make.top.equalTo(question4TextField.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(collectionView.snp.trailing)
            make.width.equalTo(dayLabel)
        }
        
        question5TextField.snp.makeConstraints {make in
            make.top.equalTo(question5Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.width.equalTo(dayLabel)
            make.height.equalTo(49)
        }
        addButton.snp.makeConstraints{
            $0.width.equalTo(question5TextField)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.top.equalTo(question5TextField.snp.bottom).offset(20)
        }
    }
    
    private func setupDelegate() {
        question2TextField.delegate = self
        question3TextField.delegate = self
        question4TextField.delegate = self
        question5TextField.delegate = self
    }
    
    private func registerCell() {
        collectionView.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.id)
    }
    
    func addUnderline(to label: UILabel, thickness: CGFloat, color: UIColor) {
        let underline = UILabel()
        underline.backgroundColor = color
        mainView.addSubview(underline)
        underline.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(label)
            make.height.equalTo(thickness)
        }
        mainView.bringSubviewToFront(label)
    }
    
    // 이미지 선택 버튼의 액션 메서드
    @objc func selectImage() {
        moodPopup.delegate = self
        present(moodPopup, animated: true, completion: nil)
    }
}

extension TravelRewindViewController: MoodPopupDelegate {
    func didSelectMood(data: UIImage) {
        selectImageButton.setImage(data, for: .normal)
        moodImageTags.forEach{ tag in
            if UIImage(named: tag) == data {
                self.moodTag = tag
                print(moodTag)
            }
        }
        selectImageButton.snp.remakeConstraints { make in
            // Set the desired size (e.g., width: 50, height: 50)
            make.width.height.equalTo(40)
            make.center.equalTo(moodImageView)
        }
    }
}


///MARK: UITextFieldDelegate
extension TravelRewindViewController : UITextFieldDelegate {
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.scrollsToTop = true
        if textField == question5TextField {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= 200
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == question5TextField{
            if view.frame.origin.y != 0 {
                view.frame.origin.y = 0
            }
        }
    }
    
    // return button 눌렀을 떄
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return true
    }
}
