//
//  UploadAPIError.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 02/09/20.
//

import Foundation

public struct UploadAPIError: Error & Decodable {
    public let message: String
    public let help: String?

}
