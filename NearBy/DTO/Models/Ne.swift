//
//  Ne.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Ne: CodableEquatable {
    public let lat, lng: Double

    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    public static func == (lhs: Ne, rhs: Ne) -> Bool {
        return lhs.lat == rhs.lat && lhs.lng == rhs.lng
    }
}
