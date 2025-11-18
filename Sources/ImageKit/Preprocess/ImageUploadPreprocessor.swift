//
//  ImageUploadPreprocessor.swift
//  ImageKitIO
//
//  Created by Animesh Verma on 03/10/23.
//

import Foundation
import UIKit

public final class ImageUploadPreprocessor<I> : UploadPreprocessor<I> {
    private let limit: ImageDimensionsLimiter
    private let cropPoints: ImageCrop?
    private let rotation: ImageRotation
    private let format: OutputFormat
    
    private init(limit: ImageDimensionsLimiter, cropPoints: ImageCrop?, rotation: ImageRotation, format: OutputFormat) {
        self.limit = limit
        self.cropPoints = cropPoints
        self.rotation = rotation
        self.format = format
    }
    
    override func outputFile(input: I, fileName: String) -> Data {
        var image: UIImage
        if input is Data {
            image = UIImage(data: input as! Data)!
        } else {
            image = input as! UIImage
        }
        image = limit.process(source: image)
        image = cropPoints?.process(source: image) ?? image
        image = rotation.process(source: image)
        return format == .JPEG ? image.jpegData(compressionQuality: 1.0)! : image.pngData()!
    }
    
    public enum OutputFormat {
        case JPEG
        case PNG
    }
    
    public class Builder {
        private var maxLimits: (Int, Int) = (Int.max, Int.max)
        private var cropPoints: (CGPoint, CGPoint)? = nil
        private var outputFormat: OutputFormat = .PNG
        private var rotationAngle: CGFloat = 0
        
        public init() {}
        
        public func limit(width: Int, height: Int) -> Builder {
            maxLimits = (width, height)
            return self
        }
        
        public func crop(p1: CGPoint, p2: CGPoint) -> Builder {
            cropPoints = (p1, p2)
            return self
        }
        
        public func rotate(degrees: CGFloat) -> Builder {
            rotationAngle = degrees
            return self
        }

        public func format(format: OutputFormat) -> Builder {
            outputFormat = format
            return self
        }
        
        public func build() -> ImageUploadPreprocessor<I> {
            var cropper: ImageCrop? = nil
            if let cropPoints = cropPoints {
                cropper = ImageCrop(topLeft: cropPoints.0, bottomRight: cropPoints.1)
            }
            return ImageUploadPreprocessor(
                limit: ImageDimensionsLimiter(maxWidth: maxLimits.0, maxHeight: maxLimits.1),
                cropPoints: cropper,
                rotation: ImageRotation(angle: rotationAngle),
                format: outputFormat
            )
        }
    }
}
