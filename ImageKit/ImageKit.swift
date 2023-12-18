//
//  ImageKit.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 16/07/20.
//

import Foundation
public var TESTING: Bool = true

public struct UserDefaultKeys {
    public static let KEY_CLIENT_PUBLIC_KEY = "IKClientKey"
    public static let KEY_IMAGEKIT_URL_ENDPOINT = "IKURLEndpoint"
    public static let KEY_IMAGEKIT_TRANSFORMATION_POSITION = "IKTransformationPosition"
}

open class ImageKit: NSObject {

    open fileprivate(set) var clientPublicKey: String! = ""
    open fileprivate(set) var imageKitEndpoint: String! = ""
    fileprivate(set) var transformationPosition: TransformationPosition = TransformationPosition.PATH
    open fileprivate(set) var defaultUploadPolicy: UploadPolicy = UploadPolicy.defaultPolicy()

    var configured = false
    lazy var userDefaults = UserDefaults.standard

    public static let shared = ImageKit()
    
    private let sharedUploader = ImageKitUploader()

    public override init() {

        super.init()

        let clientPublicKey: String = self.userDefaults.string(forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY)!
        let imageKitEndpoint: String = self.userDefaults.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_URL_ENDPOINT)!
        let transformationPosition: TransformationPosition = TransformationPosition(rawValue: self.userDefaults.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)!)!

        self.clientPublicKey = clientPublicKey
        self.imageKitEndpoint = imageKitEndpoint
        self.transformationPosition = transformationPosition

    }
    
    @available(*, deprecated, message: "clientPublicKey Renamed to publicKey")
    public convenience init(clientPublicKey: String = "", imageKitEndpoint: String, transformationPosition: TransformationPosition = TransformationPosition.PATH) {
        self.init(publicKey: clientPublicKey, imageKitEndpoint: imageKitEndpoint, transformationPosition: transformationPosition)
    }
    
    @available(*, deprecated, message: "imageKitEndpoint Renamed to urlEndpoint")
    public convenience init(publicKey: String = "", imageKitEndpoint: String, transformationPosition: TransformationPosition = TransformationPosition.PATH) {
        self.init(publicKey: publicKey, urlEndpoint: imageKitEndpoint, transformationPosition: transformationPosition)
    }

    public init(publicKey: String = "", urlEndpoint: String, transformationPosition: TransformationPosition = TransformationPosition.PATH, defaultUploadPolicy: UploadPolicy = UploadPolicy.defaultPolicy()) {
        if urlEndpoint.isEmpty {
            preconditionFailure("Missing urlEndpoint during initialization")
        }

        UserDefaults.standard.set(publicKey, forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY)
        UserDefaults.standard.set(urlEndpoint, forKey: UserDefaultKeys.KEY_IMAGEKIT_URL_ENDPOINT)
        UserDefaults.standard.set(transformationPosition.rawValue, forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)

        UserDefaults.standard.synchronize()
        ImageKit.shared.defaultUploadPolicy = defaultUploadPolicy
    }

    public func url(
        urlEndpoint: String = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_URL_ENDPOINT)!,
        path: String,
        transformationPosition: TransformationPosition = TransformationPosition(rawValue: UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)!)!
        ) -> ImagekitUrlConstructor {
        return ImagekitUrlConstructor(endpoint: urlEndpoint, imagePath: path, transformationPosition: transformationPosition)
    }

    public func url(
        src: String,
        transformationPosition: TransformationPosition = TransformationPosition(rawValue: UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)!)!
        ) -> ImagekitUrlConstructor {
        return ImagekitUrlConstructor(src: src, transformationPosition: transformationPosition)
    }

    public func uploader() -> ImageKitUploader {
        return sharedUploader
    }

}
