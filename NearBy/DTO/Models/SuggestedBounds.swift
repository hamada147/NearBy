//
//  SuggestedBounds.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class SuggestedBounds: CodableEquatable {
    public let ne, sw: Ne

    public init(ne: Ne, sw: Ne) {
        self.ne = ne
        self.sw = sw
    }
    
    public static func == (lhs: SuggestedBounds, rhs: SuggestedBounds) -> Bool {
        return lhs.ne == rhs.ne && lhs.sw == rhs.sw
    }
}
