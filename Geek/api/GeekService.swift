//
//  GeekService.swift
//  Geek
//
//  Created by Thilak k on 19/05/22.
//

import Foundation

class GeekService {
    public func callAPIGetPeople(onSuccess successCallback: ((_ people: [People]) -> Void)?,
                                 onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APICallManager.instance.callAPIGetPeople(
            onSuccess: { (people) in
                successCallback?(people)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
