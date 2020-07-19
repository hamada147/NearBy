//
//  UserDefaultManager.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

fileprivate extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}

fileprivate extension Bool {
    func not() -> Bool {
        return !self
    }
}

class UserDefaultManager: NSObject {
    
    static let shared = UserDefaultManager()
    private let userDefaults: UserDefaults?
    
    private init(suiteName: String? = nil) {
        if let suiteName = suiteName {
            self.userDefaults = UserDefaults(suiteName: suiteName)
        } else {
            let defaultName = Bundle.main.displayName
            self.userDefaults = UserDefaults(suiteName: defaultName)
        }
    }
    
    func remove(for key: UserDefaultsKey) {
        self.userDefaults?.removeObject(forKey: key.value)
        self.userDefaults?.synchronize()
    }
    
    func set<T>(_ obj: T, for key: UserDefaultsKey) {
        self.userDefaults?.set(obj, forKey: key.value)
        self.userDefaults?.synchronize()
    }
    
    func set(_ obj: [String], key: String) {
        self.userDefaults?.set(obj, forKey: key)
        self.userDefaults?.synchronize()
    }
    
    func get<T>(for key: UserDefaultsKey) -> T? {
        let result = self.userDefaults?.object(forKey: key.value) as? T
        return result
    }
    
    func get<T>(for key: UserDefaultsKey, defaultValue: T) -> T {
        let result = self.userDefaults?.object(forKey: key.value) as? T
        if result == nil {
            self.set(defaultValue, for: key)
            return defaultValue
        } else {
            return result!
        }
    }
    
    func object(for key: UserDefaultsKey) -> Any? {
        let result = self.userDefaults?.object(forKey: key.value)
        return result
    }
    
    static func purge() {
        let keys = UserDefaultsKey.allCases
        keys.forEach {
            let excluded = UserDefaultsKey.excludedCases.contains($0)
            if excluded.not() {
                UserDefaultManager.shared.remove(for: $0)
            }
        }
    }
}

enum UserDefaultsKey: String, CaseIterable {
    
    case isRealtime
    case dbInit
    
    static var excludedCases: [UserDefaultsKey] = []
    
    var value: String {
        return self.rawValue
    }
}
