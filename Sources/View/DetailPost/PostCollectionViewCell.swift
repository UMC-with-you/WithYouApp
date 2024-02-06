import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    var model: String? { didSet { bind() } }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white // Set text color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(titleLabel)
    }

    private func configure() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        backgroundColor = .brown
    }

    private func bind() {
        titleLabel.text = model
    }
}

