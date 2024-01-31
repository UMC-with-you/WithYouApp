import UIKit

class MemberCell: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    var model: String? { didSet { bind() } }
    var image: UIImage? {didSet {bind()}}
    
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
            make.top.equalTo(profileImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        backgroundColor = WithYouAsset.backgroundColor.color
    }

    private func bind() {
        titleLabel.text = model
        profileImageView.image = image
    }

}
