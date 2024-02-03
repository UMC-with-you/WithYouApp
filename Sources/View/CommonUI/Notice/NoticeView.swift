//
//  NoticeView.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

final class NoticeView: UIView {
    
    var noticeArray: [Notice] = []
    
    var noticeDataManager = NoticeDataManager()
    
    private let checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkbox")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 18)
        label.text = "NOTICE"
        label.textColor = UIColor(named: "MainColorDark")
        label.textAlignment = .center
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "MainColorDark")
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
//        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 1
        return sv
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        setupTableView()
        setupDatas()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        // 델리게이트 패턴 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        
        // 셀의 등록 과정(스토리보드 사용시에는 스토리보드에서 자동 등록)
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: "NoticeViewCell")
    }
    
    func setupDatas() {
        noticeDataManager.makeNoticeData() // 일반적으로는 서버에 요청
        noticeArray = noticeDataManager.getNoticeData() // 데이터 받아서 뷰컨의 배열에 저장
    }
    
    private func setConstraints() {
        addSubview(checkImage)
        addSubview(mainLabel)
        addSubview(addButton)
        addSubview(tableView)
        
        checkImage.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImage.snp.trailing).offset(10)
            make.centerY.equalTo(checkImage.snp.centerY)
        }
                
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.centerY.equalTo(checkImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
                
        tableView.snp.makeConstraints { make in
            make.top.equalTo(checkImage.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func addButtonTapped() {
        noticeDataManager.updateNoticeData()
        tableView.reloadData()
    }
}

extension NoticeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeDataManager.getNoticeData().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeViewCell", for: indexPath) as! NoticeTableViewCell
        
        let array = noticeDataManager.getNoticeData()
        let notice = array[indexPath.row]
        
        cell.profileImageView.image = notice.profileImage
        cell.userNameLabel.text = notice.userName
        cell.noticeLabel.text = notice.noticeString
        cell.selectionStyle = .none

        return cell
    }
    
    // 셀이 선택되었을 때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
