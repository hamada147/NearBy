//
//  Obfuscator.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Obfuscator {
    
    // MARK: - Variables
    private var salt: String
    
    // MARK: - Initialization
    public init() {
        self.salt = "\(String(describing: Obfuscator.self))\(String(describing: NSObject.self))"
    }
    
    public init(with salt: String) {
        self.salt = salt
    }
    
    // MARK: - Instance Methods
    public func bytesByObfuscatingString(string: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        var encrypted = [UInt8]()
        for t in text.enumerated() {
            encrypted.append(t.element ^ cipher[t.offset % length])
        }
        #if DEBUG
        print("Salt used: \(self.salt)\n")
        print("Swift Code:\n************")
        print("// Original \"\(string)\"")
        print("let key: [UInt8] = \(encrypted)\n")
        #endif
        return encrypted
    }
    
    public func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        var decrypted = [UInt8]()
        for k in key.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }
        return String(bytes: decrypted, encoding: .utf8)!
    }
}
