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

    enum CodingKeys: String, CodingKey {
        case fileId
        case metadata
        case name, url
        case thumbnailUrl
        case height, width, size, filePath, tags, isPrivateFile, customCoordinates, fileType
    }
}
