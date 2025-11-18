//
//  ImageCrop.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 03/10/23.
//

import Foundation
import UIKit

internal class ImageCrop : Preprocess {
    typealias T = UIImage
    
    private let topLeft: CGPoint
    private let bottomRight: CGPoint
    
    init(topLeft: CGPoint, bottomRight: CGPoint) {
        self.topLeft = topLeft
        self.bottomRight = bottomRight
    }
    
    func process(source: UIImage) -> UIImage {
        let cropRect = CGRect(x: topLeft.x, y: topLeft.y, width: bottomRight.x - topLeft.x + 1, height: bottomRight.y - topLeft.y + 1)
        let renderer = UIGraphicsImageRenderer(size: cropRect.size)
        return renderer.image(actions: { context in
            source.draw(at: CGPoint(x: -cropRect.origin.x, y: -cropRect.origin.y))
        })
    }
}
