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
    
    func getMockLogs() -> [Log]{
        return [
            Log(id: 0, title: "테스트1", startDate: "2024.03.05", endDate: "2024.04.30", status: "ONGOING", imageUrl: ""),
            Log(id: 1, title: "테스트2", startDate: "2024.04.05", endDate: "2024.04.07", status: "BEFORE", imageUrl: ""),
            Log(id: 2, title: "테스트3", startDate: "2024.04.05", endDate: "2024.04.13", status: "BEFORE", imageUrl: ""),
            Log(id: 3, title: "테스트4", startDate: "2024.03.05", endDate: "2024.03.06", status: "BYGONE", imageUrl: ""),
            Log(id: 4, title: "테스트5", startDate: "2024.03.07", endDate: "2024.03.09", status: "BYGONE", imageUrl: ""),
            Log(id: 5, title: "테스트6", startDate: "2024.03.25", endDate: "2024.03.27", status: "BYGONE", imageUrl: "")
            
        ]
    }
    
    func getLogs() -> [Log]{
        return self.logs
    }
    
    func setLogs(logs : [Log]){
        self.logs = logs
    }
    
    func updateLogsFromServer(_ completion : @escaping ([Log])-> ()){
//        LogService.shared.getAllLogs(){ logs in
//            self.logs = logs
//            completion(self.logs)
//        }
        completion(LogService.shared.mockLog())
    }
    
    func addLog(with log : Log,image : UIImage){
        LogService.shared.addLog(log: log,image: image){ response in
            print(response)
        }
    }
    
    public func getFinishedLogs() -> [Log]{
        return LogService.shared.mockLog().filter{ $0.status == "BYGONE" }
    }
    
}
