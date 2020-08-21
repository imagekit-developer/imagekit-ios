//
//  SignatureAPIResponse.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 06/08/20.
//

import Foundation

// MARK: - SignatureAPIResponse
struct SignatureAPIResponse: Codable {
    let signature: String
    let token: String
    let expire: Int
}
