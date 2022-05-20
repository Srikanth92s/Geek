//
//  DataService.swift
//  Geek
//
//  Created by Srikanth S on 20/05/22.
//

import Foundation
import Alamofire

struct DataService {
    
    // MARK: - Singleton
    static let shared = DataService()
        
    
    // MARK: - Services
    func requestFetchMovie(with id: String, completion: @escaping (GeekModel?, Error?) -> ()) {
        
        let url = "\(Api.geekList)\(id)"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseGeekList { response in
                debugPrint(response)

                if let error = response.error {
                    completion(nil, error)
                    return
                }
                if let result = response.result.value {
                    completion(result, nil)
                    return
                }
            }
    }
    
}
