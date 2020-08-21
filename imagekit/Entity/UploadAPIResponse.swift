//
//  UploadAPIResponse.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 14/08/20.
//

import Foundation

// MARK: - UploadAPIResponse
public struct UploadAPIResponse: Codable {
    let fileId, name: String
    let url, thumbnailUrl: String
    let height, width, size: Int
    let filePath, fileType: String
    let tags: [String]?
    let isPrivateFile: Bool?
    let customCoordinates: String?
    let metadata: String?

    enum CodingKeys: String, CodingKey {
        case fileId
        case metadata
        case name, url
        case thumbnailUrl
        case height, width, size, filePath, tags, isPrivateFile, customCoordinates, fileType
    }
}
