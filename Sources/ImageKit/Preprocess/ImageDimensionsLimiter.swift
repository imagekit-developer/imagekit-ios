//
//  ImageDimensionsLimiter.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 03/10/23.
//

import Foundation
import UIKit

internal class ImageDimensionsLimiter : Preprocess {
    typealias T = UIImage
    
    private let maxWidth: Int
    private let maxHeight: Int
    
    init(maxWidth: Int, maxHeight: Int) {
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
    }
    
    func process(source: UIImage) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        if Int(source.size.width) <= maxWidth && Int(source.size.height) <= maxHeight {
            return source
        }
        let renderer = UIGraphicsImageRenderer(
            size: CGSize(width: maxWidth, height: maxHeight),
            format: format
        )
        return renderer.image(actions: { context in
            source.draw(in: CGRect(x: 0, y: 0, width: maxWidth, height: maxHeight))
        })
    }
}
