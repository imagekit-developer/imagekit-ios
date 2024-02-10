//
//  Preprocess.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 03/10/23.
//

import Foundation

protocol Preprocess {
    associatedtype T
    func process(source: T) -> T
}
