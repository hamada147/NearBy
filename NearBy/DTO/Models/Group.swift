//
//  Group.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Group: CodableEquatable {
    public let type, name: String
    public let items: [GroupItem]

    public init(type: String, name: String, items: [GroupItem]) {
        self.type = type
        self.name = name
        self.items = items
    }
    
    public static func == (lhs: Group, rhs: Group) -> Bool {
        if lhs.type == rhs.type && lhs.name == rhs.name {
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
