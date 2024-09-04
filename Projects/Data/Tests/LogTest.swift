//
//  LogTest.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도경 on 5/17/24.
//

import Data
import XCTest

final class LogTest : XCTestCase {
    func test_LogService(){
        let repo = DefaultLogRepository(service: BaseService())
    }
}
