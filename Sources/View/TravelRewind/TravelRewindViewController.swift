import UIKit
import SnapKit

class TravelRewindViewController: UIViewController{
    
    var dataSource: [String] = []
    var sourceImage: [UIImage?] = []
    private func setupDataSource() {
        for i in 0...8 {
            dataSource += ["test\(i)"]
            sourceImage += [UIImage(named: "testProfile")]
        }
    }
    
    lazy var moodPopup: MoodPopupViewController = {
        let popup = MoodPopupViewController()
        popup.modalPresentationStyle = .overFullScreen
        return popup
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "DAY 2"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 32.0)
        label.textAlignment = .left
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오징어들의 오사카 여행"
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
        flowLayout.minimumLineSpacing = 0 // cell사이의 간격 설정
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = WithYouAsset.backgroundColor.color
        
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var tableView:UITableView = {
        let view = UITableView()
        view.backgroundColor = .brown
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
        textField.backgroundColor = UIColor(named: "BackgroundColor")
        textField.placeholder = "내용을 입력해주세요"
        return textField
    }()
    
    
    let question3Label: UILabel = {
        let label = UILabel()
        label.text = "#3. 오늘 여행에서, 조금 아쉬웠던 점이 있을까?"
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
        textField.backgroundColor = UIColor(named: "BackgroundColor")
        textField.placeholder = "내용을 입력해주세요"
        return textField
    }()
    
    let question4Tag: UILabel = {
        let label = UILabel()
        label.text = "#4. "
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        return label
    }()
    
    let question4Label: UILabel = {
        let label = UILabel()
        label.text = "오늘 나와 특별한 여행을 함께한 나의 YOU에게 전하고 싶은 말을 적어줘!"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "LogoColor")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let mainView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupUI()
        registerCell()
        setupDelegate()
    }
    
    func setupUI() {
        
        view.addSubview(mainView)
        
        mainView.backgroundColor = UIColor(named: "BackgroundColor")
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
        mainView.addSubview(question4Tag)
        mainView.addSubview(question4Label)
        mainView.addSubview(tableView)
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.top.equalToSuperview().offset(100)
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
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(collectionView.snp.width).multipliedBy(0.3)
        }
        
        question2Label.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
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
        }
        
        question3TextField.snp.makeConstraints {make in
            make.top.equalTo(question3Label.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.width.equalTo(dayLabel)
            make.height.equalTo(49)
        }
        
        question4Tag.snp.makeConstraints { make in
            make.top.equalTo(question3TextField.snp.bottom).offset(20)
            make.leading.equalTo(dayLabel)
        }
        question4Label.snp.makeConstraints { make in
            make.top.equalTo(question3TextField.snp.bottom).offset(20)
            make.leading.equalTo(question4Tag.snp.trailing)
            make.width.equalTo(dayLabel)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(question4Label.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(dayLabel)
            make.height.equalTo(dataSource.count*50)
        }
        
        
    }
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCell() {
        collectionView.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.id)
        tableView.register(MyTableCell.self, forCellReuseIdentifier: MyTableCell.id)
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
        print("tapped button")
        moodPopup.delegate = self
        present(moodPopup, animated: true, completion: nil)
        
    }
    
}

extension TravelRewindViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCell.id, for: indexPath)
        if let cell = cell as? MemberCell {
            cell.model = dataSource[indexPath.item]
            cell.image = sourceImage[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle item selection
        
        // Example: Log the selected item's index path
        print("Selected item at indexPath: \(indexPath)")
        
    }
    
    
}

extension TravelRewindViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = round(collectionView.bounds.width / 4)
        let cellHeight = collectionView.bounds.height
        return CGSize(width: cellWidth, height: collectionView.frame.height) // point
    }
    
}

extension TravelRewindViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableCell.id, for: indexPath)
        if let cell = cell as? MyTableCell {
            cell.image = sourceImage[indexPath.item]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 여기에서 원하는 높이를 반환하세요.
        return 50.0 // 예시로 44포인트를 반환하고 있습니다.
    }
}



extension TravelRewindViewController: MoodPopupDelegate {
    func didSelectMood(data: UIImage) {
        
        selectImageButton.setImage(data, for: .normal)
        selectImageButton.snp.remakeConstraints { make in
            // Set the desired size (e.g., width: 50, height: 50)
            make.width.height.equalTo(40)
            make.center.equalTo(moodImageView)
        }
    }
    
    
}
