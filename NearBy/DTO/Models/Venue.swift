//
//  Venue.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Checkin: CodableEquatable {
    public let id: String
    public let createdAt: Int
    public let type: String
    public let timeZoneOffset: Int

    public init(id: String, createdAt: Int, type: String, timeZoneOffset: Int) {
        self.id = id
        self.createdAt = createdAt
        self.type = type
        self.timeZoneOffset = timeZoneOffset
    }
    
    public static func == (lhs: Checkin, rhs: Checkin) -> Bool {
        return true
    }
}

public class Source: CodableEquatable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    public static func == (lhs: Source, rhs: Source) -> Bool {
        return true
    }
}

public class User: CodableEquatable {
    public let id, firstName, lastName: String
    public let photo: Icon

    public init(id: String, firstName: String, lastName: String, photo: Icon) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return true
    }
}

public class PhotosItem: CodableEquatable {
    public let id: String
    public let createdAt: Int
    public let source: Source
    public let itemPrefix: String
    public let suffix: String
    public let width, height: Int
    public let user: User
    public let checkin: Checkin
    public let visibility: String

    public init(id: String, createdAt: Int, source: Source, itemPrefix: String, suffix: String, width: Int, height: Int, user: User, checkin: Checkin, visibility: String) {
        self.id = id
        self.createdAt = createdAt
        self.source = source
        self.itemPrefix = itemPrefix
        self.suffix = suffix
        self.width = width
        self.height = height
        self.user = user
        self.checkin = checkin
        self.visibility = visibility
    }
    
    public static func == (lhs: PhotosItem, rhs: PhotosItem) -> Bool {
        return true
    }
}

public class Photos: CodableEquatable {
    public let count: Int
    public let items: [PhotosItem]?
    public let dupesRemoved: Int?

    public init(count: Int, items: [PhotosItem]?, dupesRemoved: Int?) {
        self.count = count
        self.items = items
        self.dupesRemoved = dupesRemoved
    }
    
    public static func == (lhs: Photos, rhs: Photos) -> Bool {
        return true
    }
}

public class Venue: CodableEquatable {
    public let id, name: String
    public let location: Location
    public let categories: [Category]
    public let popularityByGeo: Double?
    public let photos: Photos
    public let venuePage: VenuePage?

    public init(id: String, name: String, location: Location, categories: [Category], popularityByGeo: Double?, photos: Photos, venuePage: VenuePage?) {
        self.id = id
        self.name = name
        self.location = location
        self.categories = categories
        self.popularityByGeo = popularityByGeo
        self.photos = photos
        self.venuePage = venuePage
    }
    
    public static func == (lhs: Venue, rhs: Venue) -> Bool {
        if lhs.id == rhs.id && lhs.name == rhs.name && lhs.popularityByGeo == rhs.popularityByGeo && lhs.venuePage == rhs.venuePage && lhs.photos == rhs.photos {
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
