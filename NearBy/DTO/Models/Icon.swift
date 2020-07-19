//
//  Icon.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Icon: CodableEquatable {
    public let iconPrefix: String
    public let suffix: String

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }

    public init(iconPrefix: String, suffix: String) {
        self.iconPrefix = iconPrefix
        self.suffix = suffix
    }
    
    public static func == (lhs: Icon, rhs: Icon) -> Bool {
        return lhs.iconPrefix == rhs.iconPrefix && lhs.suffix == rhs.suffix
    }
}
