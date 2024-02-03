//
//  WithUViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class WithUViewController: UIViewController {
    
    private let withUView = WithUView()
    
    override func loadView() {
        super.loadView()
        view = withUView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
