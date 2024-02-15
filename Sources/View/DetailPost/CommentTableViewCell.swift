import UIKit
class CommentTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.bold.font(size: 14)
        label.text = "경주"
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 14)
        label.text = "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋzzzzzzzzzzaazazazazazzazazavbnbxcvbvxvxvbxvxbcxcxcxxbbdbdfdfdfgf"
        label.numberOfLines = 0
        return label
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = WithYouAsset.myIcon.image
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add profileImage to contentView
        contentView.addSubview(profileImage)
        profileImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(32) // 프로필 이미지 뷰의 크기 설정
        }
        
        // Add nameLabel to contentView
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(5)
            make.top.equalTo(profileImage.snp.top)
            
        }
        
        // Add commentLabel to contentView
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5) // 댓글 레이블의 top을 프로필 이미지 아래로 설정
            make.leading.equalTo(nameLabel.snp.leading) // 댓글 레이블의 leading을 이름 레이블과 같도록 설정
            make.trailing.equalToSuperview().offset(-15) // 댓글 레이블의 trailing을 contentView의 trailing에 맞추고 오른쪽 여백 추가
            make.bottom.lessThanOrEqualToSuperview().offset(-15) // 댓글 레이블의 bottom을 contentView의 bottom에 맞추고 아래 여백 추가
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
