//
//  ImageRotation.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 03/10/23.
//

import Foundation
import UIKit

internal class ImageRotation : Preprocess {
    typealias T = UIImage
    
    private let angle: CGFloat
    
    init(angle: CGFloat) {
        self.angle = angle
    }
    
    func process(source: UIImage) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        var rotatedSize = CGRect(origin: CGPoint.zero, size: source.size).applying(CGAffineTransform(rotationAngle: angle * Double.pi / 180)).size
        rotatedSize.width = floor(rotatedSize.width)
        rotatedSize.height = floor(rotatedSize.height)
        let renderer = UIGraphicsImageRenderer(size: rotatedSize, format: format)
        return renderer.image(actions: { context in
            context.cgContext.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
            context.cgContext.rotate(by: angle * Double.pi / 180)
            source.draw(in: CGRect(x: -source.size.width/2, y: -source.size.height/2, width: source.size.width, height: source.size.height))
        })
    }
}
