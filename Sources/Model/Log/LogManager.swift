//
//  LogManager.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

class LogManager {
    static let shared = LogManager()
    private init(){}
    
    var logs = [Log]()
    
    func getLogs() -> [Log]{
        return self.logs
    }
    
    func updateLogsFromServer(){
        LogService.shared.getAllLogs(){ logs in
            self.logs = logs as! [Log]
        }
    }
    
    func addLog(with log : Log){
        LogService.shared.addLog(log: log){ response in
            print(response)
        }
    }
    
}
