//
//  SettingsView.swift
//  WithYou
//
//  Created by 배수호 on 5/23/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import SnapKit
import UIKit

class SettingsView: BaseUIView {
    
    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.preservesSuperviewLayoutMargins = false
        tableView.rowHeight = 38
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }
    
    func makeTableTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        label.textColor = .black
        
        return label
    }
    
    func makeHeaderTableStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.layer.cornerRadius = 8
        stackView.layer.masksToBounds = true
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 18, left: 0, bottom: 16, right: 0)

        return stackView
    }
    
    lazy var appInfoTitle = makeTableTitle("앱 정보")
    lazy var useInfoTitle = makeTableTitle("이용 정보")
    lazy var accountInfoTitle = makeTableTitle("계정")
    
    lazy var appInfoTableView = makeTableView()
    lazy var useInfoTableView = makeTableView()
    lazy var accountInfoTableView = makeTableView()
    
    lazy var appInfoStackView = makeHeaderTableStackView()
    lazy var useInfoStackView = makeHeaderTableStackView()
    lazy var accountInfoStackView = makeHeaderTableStackView()
    
    lazy var tableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appInfoStackView, useInfoStackView, accountInfoStackView])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    
    override func initUI() {
        
        self.backgroundColor = WithYouAsset.backgroundColor.color
        
        self.addSubview(tableStackView)
        
        appInfoStackView.addArrangedSubview(appInfoTitle)
        appInfoStackView.addArrangedSubview(appInfoTableView)
        useInfoStackView.addArrangedSubview(useInfoTitle)
        useInfoStackView.addArrangedSubview(useInfoTableView)
        accountInfoStackView.addArrangedSubview(accountInfoTitle)
        accountInfoStackView.addArrangedSubview(accountInfoTableView)
    }
    
    override func initLayout() {
        tableStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(22)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        appInfoTableView.snp.makeConstraints { make in            make.height.equalTo(3 * 38)
        }
        useInfoTableView.snp.makeConstraints { make in
            make.height.equalTo(3 * 38)
        }
        accountInfoTableView.snp.makeConstraints { make in
            make.height.equalTo(2 * 38)
        }
        
        appInfoTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(18)
        }
        
        useInfoTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(18)
        }
        
        accountInfoTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(18)
        }
        

    }
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
