//
//  VenuesExploreRequest.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class VenuesExploreRequest: BaseRequest {
    public let ll: String
    public let radius: Int
    public var limit: Int
    public var offset: Int
    
    init(ll: String, radius: Int = 1000, limit: Int = 10, offset: Int = 10) {
        self.ll = ll
        self.radius = radius
        self.limit = limit
        self.offset = offset
        super.init(clientID: APIManagerConfig.clientID, clientSecret: APIManagerConfig.clientSecret, v: APIManagerConfig.v)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    public static func == (lhs: VenuesExploreRequest, rhs: VenuesExploreRequest) -> Bool {
        return lhs.ll == rhs.ll && lhs.radius == rhs.radius && lhs.clientID == rhs.clientID && lhs.clientSecret == rhs.clientSecret && lhs.v == rhs.v
    }
}
