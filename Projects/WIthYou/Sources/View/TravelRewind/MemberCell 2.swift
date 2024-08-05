import Domain
import Kingfisher
import UIKit


class MemberCell: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    var traveler : Traveler?
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "MainColorDark")
        label.textAlignment = .center
        return label
    }()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "testProfile")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(titleLabel)
    }

    private func configure() {
        
        profileImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(profileImageView.snp.height)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }

    func bind(traveler : Traveler) {
        if traveler.name == DataManager.shared.getUserName() {
            profileImageView.image = UIImage(data: DataManager.shared.getUserImage())!
        }
        titleLabel.text = traveler.name
        if let url = traveler.profilePicture {
            profileImageView.kf.setImage(with: URL(string:url))
        } else {
            profileImageView.image = WithYouAsset.heart.image
        }
        self.traveler = traveler
    }

}
