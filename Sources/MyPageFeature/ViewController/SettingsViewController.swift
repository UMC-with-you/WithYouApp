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
    
    let appInfoItems = ["앱 버전 정보", "서비스 이용 약관", "개인정보 처리 방침"]
    let useInfoItems = ["공지사항", "문의하기", "문의 내역 보기"]
    let accountInfoItems = ["로그아웃하기", "탈퇴하기"]
    
    public override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setupBackButton()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewSetup()
        
    }
    private func settingsViewSetup() {
        settingsView.appInfoTableView.delegate = self
        settingsView.useInfoTableView.delegate = self
        settingsView.accountInfoTableView.delegate = self
        
        settingsView.appInfoTableView.dataSource = self
        settingsView.useInfoTableView.dataSource = self
        settingsView.accountInfoTableView.dataSource = self
        
        settingsView.appInfoTableView.tag = 0
        settingsView.useInfoTableView.tag = 1
        settingsView.accountInfoTableView.tag = 2
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
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int   {
        switch tableView.tag {
        case 0: return appInfoItems.count
        case 1: return useInfoItems.count
        case 2: return accountInfoItems.count
        default: return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch tableView.tag {
        case 0: cell.textLabel?.text = appInfoItems[indexPath.row]
        case 1: cell.textLabel?.text = useInfoItems[indexPath.row]
        case 2: cell.textLabel?.text = accountInfoItems[indexPath.row]
        default: break
        }
        return cell
    }
    
    //MARK: - UITableViewDelegate 관련
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == settingsView.appInfoTableView {
            print("tapped appInfo Table Cell")
        }
        else if tableView == settingsView.useInfoTableView {
            print("tapped useInfo Table Cell")
        }
        else if tableView == settingsView.accountInfoTableView {
            let selectedItem = accountInfoItems[indexPath.row]
            if selectedItem == "로그아웃하기" {
                let alertVC = LogoutAlertViewController()
                alertVC.modalPresentationStyle = .overFullScreen
                alertVC.modalTransitionStyle = .crossDissolve
                alertVC.onLogoutConfirm = {
                    // 로그아웃 로직 실행
                    print("✅ 로그아웃 완료")
                    // 예: UserManager.shared.logout()
                }
                present(alertVC, animated: true, completion: nil)
            }
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //
    //    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 58
    //    }
    
}
