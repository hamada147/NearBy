//
//  Venue.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation
import SQLite

public class Venue: CodableEquatable {
    public let id, name: String
    public let location: Location
    public let categories: [Category]
    public let popularityByGeo: Double
    public let venuePage: VenuePage

    public init(id: String, name: String, location: Location, categories: [Category], popularityByGeo: Double, venuePage: VenuePage) {
        self.id = id
        self.name = name
        self.location = location
        self.categories = categories
        self.popularityByGeo = popularityByGeo
        self.venuePage = venuePage
    }
    
    public static func == (lhs: Venue, rhs: Venue) -> Bool {
        if lhs.id == rhs.id && lhs.name == rhs.name && lhs.popularityByGeo == rhs.popularityByGeo && lhs.venuePage == rhs.venuePage {
            if lhs.categories.count == rhs.categories.count {
                for item in lhs.categories {
                    if !rhs.categories.contains(item) {
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

public class VenueModel: CodableEquatable {
    public let id, name, desc: String
    
    init(id: String, name: String, desc: String) {
        self.id = id
        self.name = name
        self.desc = desc
    }
    
    public static func == (lhs: VenueModel, rhs: VenueModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.desc == rhs.desc
    }
}
