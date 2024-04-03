import Kingfisher
import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    var model: UIImage? { didSet { bind() } }

    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Adjust content mode as needed
        return imageView
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
        addSubview(postImageView)
    }

    private func configure() {
        print("PostCollectionViewCell::configure() 호출")
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // Fill the cell with the image
        }
    }

    private func bind() {
        if let image = model {
            postImageView.image = image
        } else {
            // Handle case when model is nil, for example, display a placeholder image or clear the image view
            postImageView.image = nil // Or set a placeholder image
        }
    }
}


