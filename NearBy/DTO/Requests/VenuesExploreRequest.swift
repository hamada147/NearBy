//
//  VenuesExploreRequest.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class VenuesExploreRequest: CodableEquatable {
    public let ll: String
    public let radius: Int
    public var limit: Int
    public var offset: Int
    public let clientID, clientSecret, v: String
    
    init(ll: String, radius: Int = 1000, limit: Int = 200, offset: Int = 0) {
        self.ll = ll
        self.radius = radius
        self.limit = limit
        self.offset = offset
        self.clientID = APIManagerConfig.clientID
        self.clientSecret = APIManagerConfig.clientSecret
        self.v = APIManagerConfig.v
    }
    
    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case v, ll, radius, limit, offset
    }
    
    public static func == (lhs: VenuesExploreRequest, rhs: VenuesExploreRequest) -> Bool {
        return lhs.ll == rhs.ll && lhs.radius == rhs.radius && lhs.limit == rhs.limit && lhs.offset == rhs.offset && lhs.clientID == rhs.clientID && lhs.clientSecret == rhs.clientSecret && lhs.v == rhs.v
    }
}
