//
//  ParameterEncoder.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: URLRequest, with parameters: Parameters) -> URLRequest
}
