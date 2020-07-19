//
//  VenuesExploreAPI.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class VenuesExploreAPI: BaseAPI<VenuesExploreRequest, VenuesExploreResponse, BaseResponse<EmptyResponse>> {
    override var httpMethod: HTTPMethod { return .get }
    
    override var relativeApiPath: String {
        return "venues/explore"
    }
}
