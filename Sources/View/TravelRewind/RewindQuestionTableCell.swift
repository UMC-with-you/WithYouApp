import UIKit

class RewindQuestionTableCell: UITableViewCell {
    
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    var image: UIImage? { didSet { bind() } }
    
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testProfile")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "답변을 입력해주세요"
        textField.font = WithYouFontFamily.Pretendard.regular.font(size: 13)
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(textField)
    }

    private func configure() {
        profileImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(profileImageView.snp.height)
        }
        textField.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(5)
            make.centerY.equalTo(profileImageView)
            make.width.equalToSuperview().offset(profileImageView.frame.width)
        }
        
        backgroundColor = WithYouAsset.backgroundColor.color
    }

    private func bind() {
        profileImageView.image = image
    }
}
