//
//  UploadAPIResponse.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 14/08/20.
//

import Foundation

// MARK: - UploadAPIResponse
public struct UploadAPIResponse: Codable {
    let fileId, name, url, filePath, fileType: String
    let height, width: Int?
    let size: Int
    let tags: [String]?
    let isPrivateFile: Bool?
    let customCoordinates, metadata, thumbnailUrl: String?

    enum CodingKeys: String, CodingKey {
        case fileId
        case metadata
        case name, url
        case thumbnailUrl
        case height, width, size, filePath, tags, isPrivateFile, customCoordinates, fileType
    }
}
