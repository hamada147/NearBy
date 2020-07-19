//
//  Meta.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Meta: CodableEquatable {
    public let code: Int
    public let errorType, errorDetail: String?
    public let requestID: String

    enum CodingKeys: String, CodingKey {
        case code, errorType, errorDetail
        case requestID = "requestId"
    }

    public init(code: Int, errorType: String, errorDetail: String, requestID: String) {
        self.code = code
        self.errorType = errorType
        self.errorDetail = errorDetail
        self.requestID = requestID
    }
    
    public init(code: Int, errorType: String? = nil, errorDetail: String? = nil, requestID: String) {
        self.code = code
        self.errorType = errorType
        self.errorDetail = errorDetail
        self.requestID = requestID
    }
    
    public static func == (lhs: Meta, rhs: Meta) -> Bool {
        return lhs.code == rhs.code && lhs.errorType == rhs.errorType && lhs.errorDetail == rhs.errorDetail && lhs.requestID == rhs.requestID
    }
}
