//
//  BaseAPI.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class BaseAPI<RequestModel: CodableEquatable, ResponseModel: CodableEquatable, APIErrorResponse: CodableEquatable>: APIProtocol {
    
    // MARK: Attributes
    var requestDTO: RequestModel?
    var onSuccess: ((ResponseModel?) -> Void)?
    var onAPIError: ((APIErrorResponse) -> Void)?
    var onConnectionError: ((InAPPError) -> Void)?
    var onParsingError: ((Error) -> Void)?
    var paramEncoder: ParameterEncoder
    var session: URLSession
    
    // MARK:- Configurations
    // NOTE: To be overriden if needed
    var httpHeaderFields: [String : String] { return [:] }
    // NOTE: To be overriden if needed
    var httpMethod: HTTPMethod { return .post }
    // NOTE: To be overriden if needed
    var relativeApiPath: String { return "" }
    
    // MARK:- Inits
    public init (requestDTO: RequestModel?, onSuccess: ((ResponseModel?) -> Void)?, onAPIError: ((APIErrorResponse) -> Void)?, onConnectionError: ((InAPPError) -> Void)?, onParsingError: ((Error) -> Void)?) {
        self.requestDTO = requestDTO
        self.onSuccess = onSuccess
        self.onAPIError = onAPIError
        self.onConnectionError = onConnectionError
        self.onParsingError = onParsingError
        self.paramEncoder = URLParameterEncoder()
        self.session = URLSession.shared
    }
    
    public init (requestDTO: RequestModel?, onSuccess: ((ResponseModel?) -> Void)?, onAPIError: ((APIErrorResponse) -> Void)?, onConnectionError: ((InAPPError) -> Void)?, onParsingError: ((Error) -> Void)?, paramEncoder: ParameterEncoder = URLParameterEncoder(), session: URLSession = URLSession.shared) {
        self.requestDTO = requestDTO
        self.onSuccess = onSuccess
        self.onAPIError = onAPIError
        self.onConnectionError = onConnectionError
        self.onParsingError = onParsingError
        self.paramEncoder = paramEncoder
        self.session = session
    }
    
    // MARK:- Helper Functions
    private final func createAPIURL() -> URL {
        return URL(string: self.relativeApiPath, relativeTo: APIManagerConfig.serverUrl!)!
    }
    
    private final func createAPIParameters() -> [String: Any] {
        return self.requestDTO.dictionary ?? [String: Any]()
    }
    
    private final func createRequestConfig() -> RequestConfig {
        return RequestConfig(httpMethod: self.httpMethod, allHTTPHeaderFields: self.httpHeaderFields)
    }
    
    private final func createRequestExecuter(session: URLSession, apiURL: URL, parameters: [String: Any]?, paramEncoder: ParameterEncoder, onComplete: @escaping onComplete, onFailure: @escaping onFailure) -> URLRequestExecuter {
        let requestExecuter = URLSessionRequestExecuter(session: session, url: apiURL, requestConfig: self.createRequestConfig(), parameters: [parameters], parameterEncoders: [paramEncoder], onComplete: onComplete, onFailure: onFailure)
        return requestExecuter
    }
    
    // MARK:- Execute
    // NOTE: This method should not be overriden since it determines the execution pipline
    public final func execute() {
        let apiURL = self.createAPIURL()
        let body = self.createAPIParameters()
        
        let requestExecuter = self.createRequestExecuter(session: self.session, apiURL: apiURL, parameters: body, paramEncoder: self.paramEncoder, onComplete: { (data, response) in
            let decoder = JSONDecoder()
            switch response.statusCode {
            case 200: // OK. The request was executed successfully.
                guard let responseData = data else { return }
                do {
                    let dto = try decoder.decode(ResponseModel.self, from: responseData)
                    self.handleSuccessResponse(response: dto)
                } catch {
                    self.handleResponseParsingError(error: error)
                }
            case 400: // Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter.
                guard let apiErrorData = data else { return }
                do {
                    let apiErrorResponse = try decoder.decode(APIErrorResponse.self, from: apiErrorData)
                    self.handleAPIError(error: apiErrorResponse)
                } catch {
                    self.handleResponseParsingError(error: error)
                }
            case 401: // Unauthorized. Your API key was missing from the request, or wasn't correct.
                self.handleConnectionError(error: InAPPError.NotAuthorizedError)
            case 404:
                self.handleConnectionError(error: InAPPError.NotFoundError)
            case 429: // Too Many Requests.
                self.handleConnectionError(error: InAPPError.TooManyRequestsError)
            case 500: // Server Error
                guard let apiErrorData = data else { return }
                do {
                    let apiErrorResponse = try decoder.decode(APIErrorResponse.self, from: apiErrorData)
                    self.handleAPIError(error: apiErrorResponse)
                } catch {
                    self.handleResponseParsingError(error: error)
                }
            default:
                self.handleConnectionError(error: InAPPError.UnkownError)
            }
        }, onFailure: { (error) in
            self.handleConnectionError(error: ErrorManager.handleURLError(error: error))
        })
        requestExecuter.execute()
    }
    
    // MARK:- Event handlers
    // NOTE: To be overriden if needed
    func handleSuccessResponse(response: ResponseModel?) {
        if let successClosure = self.onSuccess {
            successClosure(response)
        }
    }
    
    final func handleAPIError(error: APIErrorResponse?) {
        if let errorClosure = self.onAPIError, error != nil {
            errorClosure(error!)
        }
    }
    
    // NOTE: To be overriden if needed
    func handleConnectionError(error: InAPPError?) {
        if let errorClosure = self.onConnectionError, error != nil {
            errorClosure(error!)
        }
    }
    
    // NOTE: To be overriden if needed
    func handleResponseParsingError(error: Error?) {
        if let parsingErrorClosure = self.onParsingError, error != nil {
            parsingErrorClosure(error!)
        }
    }
}
