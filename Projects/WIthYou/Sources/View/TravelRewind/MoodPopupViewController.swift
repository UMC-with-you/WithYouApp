import UIKit
import SnapKit

protocol MoodPopupDelegate: AnyObject {
    func didSelectMood(data: UIImage)
}

class MoodPopupViewController: UIViewController {
    
    weak var delegate: MoodPopupDelegate?
    
    let images: [UIImage?] = [
        UIImage(named: "heart"),
        UIImage(named: "lucky"),
        UIImage(named: "surprised"),
        UIImage(named: "angry"),
        UIImage(named: "touched"),
        UIImage(named: "sunny"),
        UIImage(named: "sad"),
        UIImage(named: "soso"),
        UIImage(named: "soso")
    ]
    
    var moodButtons: [UIButton] = []
    
    // MARK: - collectionView
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0 // cell사이의 간격 설정
        flowLayout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(MoodCell.self, forCellWithReuseIdentifier: MoodCell.reuseIdentifier)
        return view
    }()
    
    // 닫기 버튼 생성
    let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "xmark")
        button.setImage(image , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 기분"
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 17)
        label.textColor = UIColor(named: "LogoColor")
        return label
    }()
    
    let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = WithYouAsset.backgroundColor.color
        view.layer.cornerRadius = 10.0 // 원하는 라운드 값으로 설정
        view.layer.masksToBounds = true // 라운드 적용을 위해 마스크 사용
        return view
    }()
    
    func setButton() {
        for i in 0..<8 {
            let button = UIButton()
            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(images[i], for: .normal)
            moodButtons.append(button)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
        
        // 팝업 배경 설정
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        
        view.addSubview(popupView)
        popupView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        popupView.addSubview(titleLabel)
        
        popupView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.92)
            make.height.equalTo(popupView.snp.width)
            make.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(closeButton)
        }
        
        popupView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.7)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MoodPopupViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moodButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodCell.reuseIdentifier, for: indexPath) as! MoodCell
        cell.configure(image: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemWidth:CGFloat
        var itemHeight:CGFloat
        if indexPath.item == 3 || indexPath.item == 4 {
            itemWidth = floor(collectionView.bounds.width / 2)
            itemHeight = floor(collectionView.bounds.height / 3)
        } else {
            itemWidth = floor(collectionView.bounds.width / 3)
            itemHeight = floor(collectionView.bounds.height / 3)
        }
        return CGSize(width: itemWidth, height: itemHeight)
        //        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle item selection
        
        // Example: Log the selected item's index path
        print("Selected item at indexPath: \(indexPath)")
        
        // Notify the delegate about the selected mood
        delegate?.didSelectMood(data: images[indexPath.item]!)
        
        dismiss(animated: true, completion: nil)
    }
    
}

