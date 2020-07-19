//
//  EmptyResponse.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class EmptyResponse: CodableEquatable {
    public init() {}
    
    public static func == (lhs: EmptyResponse, rhs: EmptyResponse) -> Bool {
        return true
    }
}
