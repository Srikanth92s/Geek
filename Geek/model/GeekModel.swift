//
//  GeekModel.swift
//  Geek
//
//  Created by Srikanth S on 20/05/22.
//


import Foundation
import Alamofire

// MARK: - GeekModel
struct GeekModel: Codable {
    let events: [Event]
   
}

// MARK: - Event
struct Event: Codable {
    let type: String
    let id: Int
    let datetimeUTC: String
    let venue: Venue
    let performers: [Performer]
    let timeTbd: Bool
    let shortTitle, visibleUntilUTC: String


    enum CodingKeys: String, CodingKey {
        case type, id
        case datetimeUTC = "datetime_utc"
        case venue
        case performers
        case timeTbd = "time_tbd"
        case shortTitle = "short_title"
        case visibleUntilUTC = "visible_until_utc"

    }
}

// MARK: - Announcements
struct Announcements: Codable {
}

// MARK: - Performer
struct Performer: Codable {
    let type, name: String
    let image: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case type, name, image, id
    }
}

// MARK: - Venue
struct Venue: Codable {
    let state, nameV2, postalCode, name: String
    let timezone: String
    let url: String
    let score: Double

    let address, country: String
    enum CodingKeys: String, CodingKey {
        case state
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name, timezone, url, score, address, country
    }
}

// MARK: Convenience initializers
extension GeekModel {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(GeekModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Alamofire response handlers
extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseGeekList(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<GeekModel>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
