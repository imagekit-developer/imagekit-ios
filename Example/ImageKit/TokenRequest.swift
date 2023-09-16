//
//  TokenRequest.swift
//  ImageKit_Example
//
//  Created by Animesh Verma on 16/09/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

struct TokenRequest {
    let uploadPayload: [String : Any]
    let expire: Int
    let publicKey: String
}
