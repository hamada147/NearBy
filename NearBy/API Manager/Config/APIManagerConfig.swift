//
//  APIManagerConfig.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class APIManagerConfig {
    public static var serverUrl: URL? {
        let key: [UInt8] = [39, 22, 18, 5, 0, 89, 78, 91, 14, 2, 39, 125, 41, 13, 31, 23, 16, 5, 58, 3, 20, 16, 93, 0, 14, 25, 64, 4, 124, 124]
        let obf = Obfuscator()
        return URL(string: obf.reveal(key: key))
    }
    
    public static var clientID: String {
        let key: [UInt8] = [6, 58, 53, 54, 38, 41, 50, 48, 63, 32, 124, 24, 21, 49, 62, 87, 54, 36, 1, 44, 53, 63, 41, 42, 34, 65, 90, 55, 23, 0, 21, 55, 47, 47, 48, 36, 0, 38, 42, 48, 49, 54, 57, 32, 36, 70, 124, 6]
        let obf = Obfuscator()
        return obf.reveal(key: key)
    }
    
    public static var clientSecret: String {
        let key: [UInt8] = [12, 40, 42, 32, 60, 57, 34, 59, 55, 51, 126, 25, 25, 53, 40, 81, 39, 69, 10, 42, 43, 68, 48, 87, 59, 65, 56, 58, 24, 30, 26, 40, 35, 61, 86, 32, 125, 46, 46, 58, 49, 53, 48, 65, 45, 65, 20, 10]
        let obf = Obfuscator()
        return obf.reveal(key: key)
    }
    
    public static var v: String {
        return "20200719"
    }
}
