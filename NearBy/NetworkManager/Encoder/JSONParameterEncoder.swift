//
//  JSONParameterEncoder.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class JSONParameterEncoder: ParameterEncoder {
    
    public init() {}
    
    public func encode(urlRequest: URLRequest, with parameters: Parameters) -> URLRequest {
        var urlRequestAfterEncoding = urlRequest
        if parameters.count > 0 {
            if JSONSerialization.isValidJSONObject(parameters) {
                urlRequestAfterEncoding.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            }
        }
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequestAfterEncoding.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return urlRequestAfterEncoding
    }
}
