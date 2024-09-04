import Domain
import Kingfisher
import UIKit


public class MemberCell: UICollectionViewCell {

    public static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    var traveler : Traveler?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "MainColorDark")
        label.textAlignment = .center
        return label
    }()

    lazy var profileImageView = ProfileView(size: .big)
    
    public override init(frame: CGRect) {
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
        profileImageView.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }

    public func bind(traveler : Traveler) {
        titleLabel.text = traveler.name
        profileImageView.bindTraveler(traveler: traveler)
        self.traveler = traveler
    }
}
