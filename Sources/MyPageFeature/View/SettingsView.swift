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
    

    lazy var tableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func initUI() {
        self.addSubview(tableView)
    }
    
    override func initLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
