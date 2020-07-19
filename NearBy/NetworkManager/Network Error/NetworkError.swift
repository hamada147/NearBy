//
//  NetworkError.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encodeing failed."
    case missingURL = "URL is nil."
}
