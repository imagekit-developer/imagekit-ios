//
//  UploadAPIResponse.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 14/08/20.
//

import Foundation

// MARK: - UploadAPIResponse
public struct UploadAPIResponse: Codable {
    public let fileId, name, url, filePath, fileType: String?
    public let height, width: Int?
    public let size: Int
    public let tags: [String]?
    public let isPrivateFile: Bool?
    public let customCoordinates, metadata, thumbnailUrl: String?
    public let rawJSON: String

    enum CodingKeys: String, CodingKey {
        case fileId
        case metadata
        case name, url
        case thumbnailUrl
        case height, width, size, filePath, tags, isPrivateFile, customCoordinates, fileType
        case rawJSON
    }
    
    public func getRawResponse() -> String{
        return self.rawJSON
    }
    
    public func getRawJson() -> [String: Any]{
        do {
            return try JSONSerialization.jsonObject(with: self.rawJSON.data(using: .utf8)!, options: []) as! [String: Any]
        } catch {
            return [:]
        }
    }
}
