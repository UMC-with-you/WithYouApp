//
//  DIContainer.swift
//  WithYou
//
//  Created by bryan on 9/20/24.
//

import Foundation

class DIContainer {
    
    private var factories = [String: () -> Any]()
    
    static let shared = DIContainer()
    
    private init() {}
    
    // Register a factory closure for a specific type
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        factories[key] = factory
    }
    
    // Resolve the type by returning an instance
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        guard let factory = factories[key] else {
            print("No registered factory for \(key)")
            return nil
        }
        return factory() as? T
    }
}
