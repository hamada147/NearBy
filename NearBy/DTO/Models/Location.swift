//
//  Location.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Location: CodableEquatable {
    public let address, crossStreet: String?
    public let lat, lng: Double
    public let labeledLatLngs: [LabeledLatLng]
    public let distance: Int
    public let postalCode, cc, city, state: String?
    public let country: String?
    public let formattedAddress: [String]

    public init(address: String?, crossStreet: String?, lat: Double, lng: Double, labeledLatLngs: [LabeledLatLng], distance: Int, postalCode: String?, cc: String?, city: String?, state: String?, country: String?, formattedAddress: [String]) {
        self.address = address
        self.crossStreet = crossStreet
        self.lat = lat
        self.lng = lng
        self.labeledLatLngs = labeledLatLngs
        self.distance = distance
        self.postalCode = postalCode
        self.cc = cc
        self.city = city
        self.state = state
        self.country = country
        self.formattedAddress = formattedAddress
    }
    
    public static func == (lhs: Location, rhs: Location) -> Bool {
        if lhs.address == rhs.address && lhs.crossStreet == rhs.crossStreet && lhs.lat == rhs.lat && lhs.lng == rhs.lng && lhs.distance == rhs.distance && lhs.postalCode == rhs.postalCode && lhs.cc == rhs.cc && lhs.city == rhs.city && lhs.state == rhs.state && lhs.country == rhs.country {
            
            if lhs.labeledLatLngs.count == rhs.labeledLatLngs.count {
                for item in lhs.labeledLatLngs {
                    if !rhs.labeledLatLngs.contains(item) {
                        return false
                    }
                }
            } else {
                return false
            }
            
            if lhs.formattedAddress.count == rhs.formattedAddress.count {
                for item in lhs.formattedAddress {
                    if !rhs.formattedAddress.contains(item) {
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
