//
//  ImageKit.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 16/07/20.
//

import Foundation
public let API_VERSION: String? = Bundle(identifier: "org.cocoapods.ImageKit")?.infoDictionary!["CFBundleShortVersionString"] as! String

public struct UserDefaultKeys{
    public static let KEY_CLIENT_PUBLIC_KEY = "IKClientKey"
    public static let KEY_IMAGEKIT_URL_ENDPOINT = "IKURLEndpoint"
    public static let KEY_IMAGEKIT_TRANSFORMATION_POSITION = "IKTransformationPosition"
    public static let KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT = "IKAuthenticationEndpoint"
}

open class ImageKit: NSObject{
    public static var TransformationPostion: TransformationPosition.Type = TransformationPosition.self

    open fileprivate(set) var clientPublicKey: String! = ""
    open fileprivate(set) var imageKitEndpoint: String! = ""
    fileprivate(set) var transformationPosition: TransformationPosition = TransformationPosition.PATH
    open fileprivate(set) var authenticationEndpoint: String? = ""
    
    var configured = false
    lazy var userDefaults = UserDefaults.standard
    
    public static let shared = ImageKit()
    
    public override init(){
        
        super.init()
        
        let clientPublicKey: String = self.userDefaults.string(forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY)!
        let imageKitEndpoint: String = self.userDefaults.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_URL_ENDPOINT)!
        let transformationPosition: String = self.userDefaults.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)!
        let authenticationEndpoint: String = self.userDefaults.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT)!
        
        self.clientPublicKey = clientPublicKey
        self.imageKitEndpoint = imageKitEndpoint
        self.transformationPosition = TransformationPosition.getEnum(string: transformationPosition)
        self.authenticationEndpoint = authenticationEndpoint
        
    }
    
    public init(clientPublicKey: String, imageKitEndpoint: String, transformationPosition: String? = "path", authenticationEndpoint: String? = ""){
        
        if imageKitEndpoint.isEmpty || clientPublicKey.isEmpty {
            fatalError("Missing publicKey/urlEndpoint during initialization")
        }
        
        _ = TransformationPosition.getEnum(string: transformationPosition!)
        
        UserDefaults.standard.set(clientPublicKey, forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY)
        UserDefaults.standard.set(imageKitEndpoint, forKey: UserDefaultKeys.KEY_IMAGEKIT_URL_ENDPOINT)
        UserDefaults.standard.set(transformationPosition, forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)
        UserDefaults.standard.set(authenticationEndpoint, forKey: UserDefaultKeys.KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT)
        
        UserDefaults.standard.synchronize()
    }
    
    public func url(
        urlEndpoint: String = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_URL_ENDPOINT)!,
        path: String,
        transformationPosition: String = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)!
        ) -> ImagekitUrlConstructor{
        return ImagekitUrlConstructor(endpoint: urlEndpoint, imagePath: path, transformationPosition: TransformationPosition.getEnum(string: transformationPosition));
    }
    
    public func url(
        src: String,
        transformationPosition: String = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)!
        ) -> ImagekitUrlConstructor{
        return ImagekitUrlConstructor(src: src, transformationPosition: TransformationPosition.getEnum(string: transformationPosition))
    }
    
    public func uploader() -> ImageKitUploader {
        return ImageKitUploader()
    }
    
}
