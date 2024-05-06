//
//  NoticeView.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import SnapKit
import RxSwift
import RxGesture
import UIKit


final class NoticeView: UIView {
    var log : Log?
    var delegate : NoticeViewDelegate?
    
    var notices = BehaviorSubject<[Notice]>(value: [])
    
    var members = [Traveler]()
    
    private let checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkbox")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
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
    
    var bag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //View 속성
        backgroundColor = .white
        self.layer.masksToBounds = true
        layer.cornerRadius = 10
        setConstraints()
        setupTableView()
        setRx()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bindLog(log:Log){
        self.log = log
        //NOtice 불러오기
        NoticeService.shared.getAllNoticByLog(travelId: log.id){ response in
            self.notices.onNext(NoticeDataManager.shared.responseToNotice(response: response, day: dateController.daysAsInt(from: log.startDate)))
        }
    }
    
    private func setRx(){
        //버튼 매핑 (도경)
        addButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { event in
                self.addButtonTapped()
            })
            .disposed(by: bag)
        
        notices
            .bind(to: tableView.rx.items(cellIdentifier: "NoticeViewCell", cellType: NoticeTableViewCell.self)){ index,item,cell in
                cell.bind(notice: item, logId: self.log!.id)
            }
            .disposed(by: bag)
        
    }
    
    private func setupTableView() {
        // 셀의 높이 설정
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.delegate = self
        // 셀의 등록
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: "NoticeViewCell")
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
            make.bottom.equalToSuperview()
        }
    }
    
    func addButtonTapped() {
        delegate?.addNotice()
    }
}

extension NoticeView : UITableViewDelegate {
    // Row Editable true
    private func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // Swipe Right-to-left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
           let list = try? notices.value()
            if var noticeList = list {
            }
        }
    }
}


protocol NoticeViewDelegate {
    func addNotice()
}
