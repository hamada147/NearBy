//
//  ReasonsItem.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class ReasonsItem: CodableEquatable {
    public let summary, type, reasonName: String

    public init(summary: String, type: String, reasonName: String) {
        self.summary = summary
        self.type = type
        self.reasonName = reasonName
    }
    
    public static func == (lhs: ReasonsItem, rhs: ReasonsItem) -> Bool {
        return lhs.summary == rhs.summary && lhs.type == rhs.type && lhs.reasonName == rhs.reasonName
    }
}
