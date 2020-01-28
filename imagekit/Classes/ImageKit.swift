//
//  ImageKit.swift
//  imagekit
//
//  Created by Akshit New on 03/07/19.
//

import Foundation

struct UserDefaultKeys {
    static let KEY_CLIENT_PUBLIC_KEY = "ImageKit_Client_Key"
    static let KEY_IMAGEKIT_URL_ENDPOINT = "ImageKit_URL_endpoint"
    static let KEY_IMAGEKIT_TRANSFORMATION_POSITION = "ImageKit_transformationPosition"
    static let KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT = "ImageKit_authenticationEndpoint"
}

open class ImageKit: NSObject {
    open fileprivate(set) var clientPublicKey: String!
    open fileprivate(set) var imageKitEndpoint: String!
    fileprivate(set) var transformationPosition: TransformationPosition!
    open fileprivate(set) var authenticationEndpoint: String? = nil
    private var configured = false
    
    lazy var mRepository = Repository()
    lazy var userDefaults = UserDefaults.standard
    
    init(clientPublicKey: String, imageKitEndpoint: String, transformationPosition: TransformationPosition, authenticationEndpoint: String? = nil) {
        super.init()
        
        if !self.configured {
            self.configured = true
            self.clientPublicKey = clientPublicKey
            self.imageKitEndpoint = imageKitEndpoint
            self.transformationPosition = transformationPosition
            self.authenticationEndpoint = authenticationEndpoint
//             self.imageKitId = imageKitId
        } else {
            print("Warning: ImageKit.configure() called multiple times. Ignoring.")
        }
        
        self.userDefaults.set(clientPublicKey, forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY)
        self.userDefaults.set(imageKitEndpoint, forKey: UserDefaultKeys.KEY_IMAGEKIT_URL_ENDPOINT)
        self.userDefaults.set(transformationPosition, forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION)
        self.userDefaults.set(authenticationEndpoint, forKey: UserDefaultKeys.KEY_IMAGEKIT_AUTHENTICATION_ENDPOINT)
        
        userDefaults.synchronize()
        
        
    }
    
    
    
    func url(urlEndpoint: String = UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_URL_ENDPOINT)!, path: String, transformationPosition: TransformationPosition = UserDefaults.standard.object(forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION) as! TransformationPosition) {
//        ImagekitUrlConstructor(context, urlEndpoint, path, transformationPosition)
    }

    func url(
        src: String,
        transformationPosition: TransformationPosition = UserDefaults.standard.object(forKey: UserDefaultKeys.KEY_IMAGEKIT_TRANSFORMATION_POSITION) as! TransformationPosition) {
//        ImagekitUrlConstructor(
//            context,
//            src,
//            transformationPosition
//        )
    }

    func uploader() {
//        mImagekitUploader
    }
}
