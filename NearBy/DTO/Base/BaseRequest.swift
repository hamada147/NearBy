//
//  BaseRequest.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class BaseRequest: CodableEquatable {
    public let clientID, clientSecret, v: String
    
    init(clientID: String, clientSecret: String, v: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.v = v
    }
    
    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case v
    }
    
    public static func == (lhs: BaseRequest, rhs: BaseRequest) -> Bool {
        return lhs.clientID == rhs.clientID && lhs.clientSecret == rhs.clientSecret && lhs.v == rhs.v
    }
}
