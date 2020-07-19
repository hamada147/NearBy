//
//  Reasons.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Reasons: CodableEquatable {
    public let count: Int
    public let items: [ReasonsItem]

    public init(count: Int, items: [ReasonsItem]) {
        self.count = count
        self.items = items
    }
    
    public static func == (lhs: Reasons, rhs: Reasons) -> Bool {
        if lhs.count == rhs.count {
            if lhs.items.count == rhs.items.count {
                for item in lhs.items {
                    if !rhs.items.contains(item) {
                        return false
                    }
                }
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
