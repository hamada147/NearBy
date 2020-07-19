//
//  InAPPError.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public struct InAPPError: CodableEquatable {
    
    public static let NotFoundError = InAPPError(errorCode: 9999, subErrorCode: 404, errorMessage: "Not Found")
    public static let NotAuthorizedError = InAPPError(errorCode: 9999, subErrorCode: 401, errorMessage: "Unauthorized Request")
    public static let TooManyRequestsError = InAPPError(errorCode: 9999, subErrorCode: 429, errorMessage: "Too Many Requests")
    public static let UnkownError = InAPPError(errorCode: 9999, subErrorCode: -1, errorMessage: "Unkown Error")
    
    public let errorCode, subErrorCode: Int
    public let errorMessage: String
    
    init(errorCode: Int, subErrorCode: Int, errorMessage: String) {
        self.errorCode = errorCode
        self.subErrorCode = subErrorCode
        self.errorMessage = errorMessage
    }
    
    public static func == (lhs: InAPPError, rhs: InAPPError) -> Bool {
        if (lhs.errorCode == rhs.errorCode && lhs.subErrorCode == rhs.subErrorCode && lhs.errorMessage == rhs.errorMessage) {
            return true
        } else {
            return false
        }
    }
}
