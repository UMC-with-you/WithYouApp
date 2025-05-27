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
    
    
    func makeTabelView () -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.isScrollEnabled = false
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        tableView.layer.cornerRadius = 8
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.rowHeight = 38
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }
    lazy var appInfoTableView = makeTabelView()
    lazy var useInfoTableView = makeTabelView()
    lazy var accountInfoTableView = makeTabelView()
    
    lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [appInfoTableView, useInfoTableView, accountInfoTableView])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override func initUI() {
        self.addSubview(stackView)
    }
    
    override func initLayout() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(22)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.lessThanOrEqualToSuperview()
        
        }
        appInfoTableView.snp.makeConstraints { make in
            make.height.equalTo(38 * 3 + 70)
        }
        useInfoTableView.snp.makeConstraints { make in
            make.height.equalTo(38 * 3 + 70)
        }
        
        accountInfoTableView.snp.makeConstraints { make in
            make.height.equalTo(38 * 2 + 70)
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
