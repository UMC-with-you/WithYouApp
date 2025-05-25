//
//  SettingsViewController.swift
//  WithYou
//
//  Created by 배수호 on 5/23/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import SnapKit
import UIKit

public class SettingsViewController: BaseViewController {
    lazy var settingsView = SettingsView()
    
    let sectionTitles = ["앱 정보", "이용 정보", "계정"]
    let sectionItems = [
        ["앱 버전 정보", "서비스 이용 약관", "개인정보 처리 방침"],
        ["공지사항", "문의하기", "문의 내역 보기"],
        ["로그아웃하기", "탈퇴하기"]
    ]
    
    public override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setupBackButton()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.tableView.delegate = self
        settingsView.tableView.dataSource = self
    }
    
    public override func setUp() {
        view.addSubview(settingsView)
        navigationItem.title = "설정"
    }
    
    public override func setLayout() {
        settingsView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource 관련
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItems[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sectionItems[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //MARK: - UITableViewDelegate 관련
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
}
