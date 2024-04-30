//
//  MyTabView.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/02.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

final class MyTabView: UIView {
    // MARK: UI
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 16
        sv.axis = .horizontal
        return sv
    }()
    
    private let tabScrollView: UIScrollView = {
        let ts = UIScrollView()
        ts.showsVerticalScrollIndicator = false
        return ts
    }()
    
    let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    private var contentLabels = [UILabel]()
    
    // MARK: Property
    var dataSource: [String]? {
        didSet { setItems() }
    }
    var didTap: ((Int) -> Void)?
    
    // MARK: Initializer
    required init() {
        super.init(frame: .zero)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Method
    private func configure() {
        addSubview(tabScrollView)
        tabScrollView.addSubview(stackView)
        tabScrollView.addSubview(highlightView)
        
        tabScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.height.equalToSuperview()
        }
        highlightView.snp.remakeConstraints {
            $0.width.equalTo(0)
            $0.height.equalTo(4)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setItems() {
        guard let items = dataSource else { return }
        items
            .enumerated()
            .forEach { offset, item in
                let label: UILabel = {
                    let label = UILabel()
                    label.text = item
                    label.numberOfLines = 0
                    label.font = .systemFont(ofSize: 16, weight: .regular)
                    label.textColor = .black
                    label.textAlignment = .center
                    label.isUserInteractionEnabled = true
                    label.tag = offset
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapItem))
                    label.addGestureRecognizer(tapGesture)
                    return label
                }()
                self.stackView.addArrangedSubview(label)
                self.contentLabels.append(label)
                
            }
    }
    
    @objc private func tapItem(sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        didTap?(tag)
    }
}

//extension MyTabView: ScrollFitable {
//    var tabContentViews: [UIView] {
//        contentLabels
//    }
//
//    var scrollView: UIScrollView {
//        tabScrollView
//    }
//    var countOfItems: Int {
//        dataSource?.count ?? 0
//    }
//}
