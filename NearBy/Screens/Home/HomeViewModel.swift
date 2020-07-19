//
//  HomeViewModel.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    var venues: [VenueModel] = []
    private var networkInProgress = false
    
    override init() {
        self.venues = DBManager().getVenus()
    }
    
    func getVenus(ll: String, onSuccess: @escaping ((Bool) -> Void), onError: ((InAPPError) -> Void)?) {
        if self.networkInProgress {
            return
        }
        self.networkInProgress = true
        let requestDTO = VenuesExploreRequest(ll: ll)
        let request = VenuesExploreAPI(requestDTO: requestDTO, onSuccess: { (response) in
            self.networkInProgress = false
            if let response = response {
                response.response.groups.forEach { (group) in
                    group.items.forEach { (groupItem) in
                        let item = groupItem.venue
                        let desc: String = groupItem.reasons.items.reduce("") { text, item in
                            "\(text)\n\(item.summary)"
                        }
                        DBManager().insertNewVenu(id: item.id, name: item.name, desc: desc)
                    }
                }
                self.venues = DBManager().getVenus()
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }, onAPIError: { (errorResponse) in
            self.networkInProgress = false
            onError?(InAPPError(errorCode: -1, subErrorCode: -1, errorMessage: errorResponse.meta.errorDetail ?? ""))
        }, onConnectionError: { (error) in
            self.networkInProgress = false
            onError?(error)
        }, onParsingError: { (error) in
            self.networkInProgress = false
            onError?(InAPPError(errorCode: -1, subErrorCode: -1, errorMessage: error.localizedDescription))
        })
        request.execute()
    }
}
