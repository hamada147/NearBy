//
//  GroupItem.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class GroupItem: CodableEquatable {
    public let reasons: Reasons
    public let venue: Venue

    public init(reasons: Reasons, venue: Venue) {
        self.reasons = reasons
        self.venue = venue
    }
    
    public static func == (lhs: GroupItem, rhs: GroupItem) -> Bool {
        return lhs.reasons == rhs.reasons && lhs.venue == rhs.venue
    }
}
