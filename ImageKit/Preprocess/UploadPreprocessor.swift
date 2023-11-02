//
//  UploadPreprocessor.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 03/10/23.
//

import Foundation

public protocol UploadPreprocessor {
    associatedtype T
    func outputFile(input: T, fileName: String) -> Data
}
