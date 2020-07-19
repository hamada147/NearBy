//
//  LabeledLatLng.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class LabeledLatLng: CodableEquatable {
    public let label: String
    public let lat, lng: Double

    public init(label: String, lat: Double, lng: Double) {
        self.label = label
        self.lat = lat
        self.lng = lng
    }
    
    public static func == (lhs: LabeledLatLng, rhs: LabeledLatLng) -> Bool {
        return lhs.label == rhs.label && lhs.lat == rhs.lat && lhs.lng == rhs.lng
    }
}
