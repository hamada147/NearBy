//
//  URLParameterEncoder.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class URLParameterEncoder: ParameterEncoder {
    
    public enum Destination {
        case queryString, httpBody
    }
    
    var destination: Destination = .queryString
    
    public init() {}
    
    public init(destination: Destination ) {
        self.destination = destination
    }
    
    public func encode(urlRequest: URLRequest, with parameters: Parameters) -> URLRequest {
        var urlRequestAfterEncoding = urlRequest
        let url = urlRequest.url!
        
        if var urlCompnents = URLComponents(url: url, resolvingAgainstBaseURL: true), !parameters.isEmpty {
            urlCompnents.queryItems = [URLQueryItem]()
            
            switch self.destination {
            case .queryString:
                for (key,value) in parameters {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    urlCompnents.queryItems?.append(queryItem)
                }
                urlRequestAfterEncoding.url = urlCompnents.url
            case .httpBody:
                var postString = ""
                var i = 0
                for (key, value) in parameters {
                    let queryItem = "\(key)=\(value)"
                    postString.append(queryItem)
                    i += 1
                    if (i < parameters.count) {
                        postString.append("&")
                    }
                }
                let postData = NSMutableData(data: postString.data(using: .utf8)!)
                urlRequestAfterEncoding.httpBody = postData as Data
            }
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequestAfterEncoding.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequestAfterEncoding
    }
}
