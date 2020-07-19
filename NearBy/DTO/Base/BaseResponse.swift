//
//  BaseResponse.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public protocol CodableEquatable: Codable, Equatable {}

public class BaseResponse<T: CodableEquatable>: CodableEquatable {
    public let meta: Meta
    public let response: T

    public init(meta: Meta, response: T) {
        self.meta = meta
        self.response = response
    }
    
    public static func == (lhs: BaseResponse, rhs: BaseResponse) -> Bool {
        return lhs.meta == rhs.meta && lhs.response == rhs.response
    }
}
