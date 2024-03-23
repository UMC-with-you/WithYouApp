//
//  BaseViewController.swift
//  WithYou
//
//  Created by 김도경 on 3/21/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import RxSwift


public protocol BaseViewProtocol{
    /// View property 설정 - ex) view.backgroundColor = .black
    func setUpViewProperty()
    /// view 계층 설정 - ex) view.addSubview()
    func setUp()
    /// Layout 설정 - ex) snapkit
    func setLayout()
    /// Delegate 설정 - ex) collectionview.delegate = self
    func setDelegate()
}

public class BaseViewController: UIViewController, BaseViewProtocol {
    
    public var disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewProperty()
        setUp()
        setLayout()
        setDelegate()
    }
    
    public func setUpViewProperty(){}
    
    public func setUp() {}
    
    public func setLayout(){}
    
    public func setDelegate(){}
}
