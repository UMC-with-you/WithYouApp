//
//  LogManager.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

class LogManager {
    static let shared = LogManager()
    private init(){}
    
   var logs = [Log]()
    
    func getLogs() -> [Log]{
        return self.logs
    }
    
    func setLogs(logs : [Log]){
        self.logs = logs
    }
    
    func updateLogsFromServer(_ completion : @escaping ([Log])-> ()){
        LogService.shared.getAllLogs(){ logs in
            self.logs = logs
            completion(self.logs)
        }
    }
    
    func addLog(with log : Log,image : UIImage){
        LogService.shared.addLog(log: log,image: image){ response in
            print(response)
        }
    }
    
}
