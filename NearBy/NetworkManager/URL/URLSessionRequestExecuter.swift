//
//  URLSessionRequestExecuter.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class URLSessionRequestExecuter: URLRequestExecuter {
    
    public var url: URL
    public var requestConfig: RequestConfig
    public var onComplete: onComplete?
    public var onFailure: onFailure?
    public var parameterEncoders: [ParameterEncoder]
    public var parameters: [Parameters?]?
    public var queryItems: [String:String]?
    public var request: URLRequest!
    public var session: URLSession!
    public var interceptors: [Interceptor]?
    
    public required init(session: URLSession, url: URL, requestConfig: RequestConfig, parameters: [Parameters?]?, parameterEncoders: [ParameterEncoder], interceptors: [Interceptor]? = nil, onComplete: onComplete?, onFailure: onFailure?) {
        self.session = session
        self.url = url
        self.requestConfig = requestConfig
        self.parameters = parameters
        self.parameterEncoders = parameterEncoders
        self.onComplete = onComplete
        self.onFailure = onFailure
        self.interceptors = interceptors
        
        self.request = self.buildRequest(url: url, requestConfig: requestConfig, parameters: parameters)
        self.request = self.interceptRequest(request: self.request)
    }
    
    // MARK:- Interceptors
    private func interceptRequest(request: URLRequest) -> URLRequest {
        var _request = request
        if self.interceptors != nil {
            for interceptor in self.interceptors! {
                _request = interceptor.intercept(request: _request)
            }
        }
        return _request
    }
    
    private func interceptResponseData(data: Data?, response: URLResponse?) -> Data? {
        var _data = data
        if self.interceptors != nil && _data != nil && response != nil {
            for interceptor in self.interceptors! {
                _data = interceptor.intercept(data: _data!, response: response!)
            }
        }
        return _data
    }
    
    // MARK:- Execute
    public func execute() {
        let task = self.session.dataTask(with: self.request) { (data, response, error) in
            if let error = error as? URLError {
                self.onFailure?(error)
            } else {
                let _data = self.interceptResponseData(data: data, response: response)
                self.onComplete?(_data, response as! HTTPURLResponse)
            }
        }
        task.resume()
    }
    
    public func executeSynchronous() {
        let (data, response, error) = self.session.synchronousDataTask(with: self.request)
        if let error = error as? URLError {
            self.onFailure?(error)
        } else {
            self.onComplete?(data, response as! HTTPURLResponse)
        }
    }
    
    // MARK:- Request Preprations
    func buildRequest(url: URL, requestConfig: RequestConfig, parameters: [Parameters?]?) -> URLRequest {
        var request  = URLRequest(url: url)
        request.httpMethod =  requestConfig.httpMethod.rawValue
        request.allHTTPHeaderFields = requestConfig.allHTTPHeaderFields
        let requestAfterEncoding = self.encodeParameters(urlRequest: request, with: parameters)
        return requestAfterEncoding
    }
    
    private func encodeParameters(urlRequest: URLRequest, with parameters: [Parameters?]?) -> URLRequest {
        var request = urlRequest
        if self.parameters?.count == self.parameterEncoders.count {
            for i in 0...(self.parameters!.count - 1) {
                request = self.parameterEncoders[i].encode(urlRequest: request, with: self.parameters![i]!)
            }
        }
        return request
    }
}
