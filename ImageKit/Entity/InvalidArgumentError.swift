//
//  InvalidArgumentError.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 13/09/23.
//

import Foundation

public struct InvalidArgumentError: Error & Decodable {
    public let message: String
}
