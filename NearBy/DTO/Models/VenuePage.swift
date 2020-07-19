//
//  VenuePage.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class VenuePage: CodableEquatable {
    public let id: String

    public init(id: String) {
        self.id = id
    }
    
    public static func == (lhs: VenuePage, rhs: VenuePage) -> Bool {
        return lhs.id == rhs.id
    }
}
