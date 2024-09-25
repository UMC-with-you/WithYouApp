
import Kingfisher
import UIKit
import RxSwift

public class MemberCell: UICollectionViewCell {

    public static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    var traveler : Traveler?
    
    var disposeBag = DisposeBag()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14.0)
        label.textColor = UIColor(named: "MainColorDark")
        label.textAlignment = .center
        return label
    }()

    lazy var profileImageView = ProfileView(size: .big)
    
    let darkOverlay = {
        let darkOverlay = UIView()
        darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        darkOverlay.isHidden = true // Initially hidden
        return darkOverlay
    }()
    
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
        addSubview(darkOverlay)
    }

    private func configure() {
        profileImageView.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        // Use SnapKit for layout
        darkOverlay.snp.makeConstraints { make in
            make.edges.equalTo(profileImageView)
        }
        
        self.darkOverlay.layer.cornerRadius = 35
    }

    public func bind(traveler : Traveler) {
        titleLabel.text = traveler.name
        profileImageView.bindTraveler(traveler: traveler)
        self.traveler = traveler
    }
    
    public override var isSelected: Bool {
        didSet {
            darkOverlay.isHidden = !isSelected
        }
    }
}
