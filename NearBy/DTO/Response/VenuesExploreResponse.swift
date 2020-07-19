//
//  VenuesExploreResponse.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Filter: CodableEquatable {
    public let name, key: String

    public init(name: String, key: String) {
        self.name = name
        self.key = key
    }
    
    public static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name && lhs.key == lhs.key
    }
}

public class SuggestedFilters: CodableEquatable {
    public let header: String
    public let filters: [Filter]

    public init(header: String, filters: [Filter]) {
        self.header = header
        self.filters = filters
    }
    
    public static func == (lhs: SuggestedFilters, rhs: SuggestedFilters) -> Bool {
        if lhs.header == rhs.header {
            if lhs.filters.count == rhs.filters.count {
                for item in lhs.filters {
                    if !rhs.filters.contains(item) {
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

public class VenuesExploreResponse: CodableEquatable {
    public let suggestedFilters: SuggestedFilters?
    public let warning: Warning?
    public let suggestedRadius: Int?
    public let headerLocation, headerFullLocation, headerLocationGranularity: String
    public let totalResults: Int
    public let suggestedBounds: SuggestedBounds
    public let groups: [Group]

    public init(suggestedFilters: SuggestedFilters?, warning: Warning?, suggestedRadius: Int?, headerLocation: String, headerFullLocation: String, headerLocationGranularity: String, totalResults: Int, suggestedBounds: SuggestedBounds, groups: [Group]) {
        self.suggestedFilters = suggestedFilters
        self.warning = warning
        self.suggestedRadius = suggestedRadius
        self.headerLocation = headerLocation
        self.headerFullLocation = headerFullLocation
        self.headerLocationGranularity = headerLocationGranularity
        self.totalResults = totalResults
        self.suggestedBounds = suggestedBounds
        self.groups = groups
    }
    
    public static func == (lhs: VenuesExploreResponse, rhs: VenuesExploreResponse) -> Bool {
        if lhs.warning == rhs.warning && lhs.suggestedRadius == rhs.suggestedRadius && lhs.headerLocation == rhs.headerLocation && lhs.headerFullLocation == rhs.headerFullLocation && lhs.headerLocationGranularity == rhs.headerLocationGranularity && lhs.totalResults == rhs.totalResults && lhs.suggestedBounds == rhs.suggestedBounds {
            
            if lhs.groups.count == rhs.groups.count {
                for item in lhs.groups {
                    if !rhs.groups.contains(item) {
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
