//
//  Category.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Category: CodableEquatable {
    public let id, name, pluralName, shortName: String
    public let icon: Icon
    public let primary: Bool

    public init(id: String, name: String, pluralName: String, shortName: String, icon: Icon, primary: Bool) {
        self.id = id
        self.name = name
        self.pluralName = pluralName
        self.shortName = shortName
        self.icon = icon
        self.primary = primary
    }
    
    public static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.pluralName == rhs.pluralName && lhs.shortName == rhs.shortName && lhs.icon == rhs.icon && lhs.primary == rhs.primary
    }
}
