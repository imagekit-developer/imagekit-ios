//
//  UploadPreprocessor.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 03/10/23.
//

import Foundation

public class UploadPreprocessor<T> {
    func outputFile(input: T, fileName: String) -> Data {
        fatalError("Cannot use the base UploadPreprocessor for output.")
    }
}
