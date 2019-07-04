//
//  ImageKit.swift
//  imagekit
//
//  Created by Akshit New on 03/07/19.
//

import Foundation

struct UserDefaultKeys {
    static let KEY_CLIENT_PUBLIC_KEY = "ImageKit_Client_Key"
    static let KEY_IMAGEKIT_ID_KEY = "ImageKit_ID_Key"
}

@objc open class ImageKit: NSObject {
    open fileprivate(set) var clientPublicKey: String!
    open fileprivate(set) var imageKitId: String!
    private var configured = false
    
    lazy var mRepository = Repository()
    lazy var userDefaults = UserDefaults.standard
    
    public init(clientPublicKey: String, imageKitId: String) {
        super.init()
        
        if !self.configured {
            self.configured = true
            self.clientPublicKey = clientPublicKey
            self.imageKitId = imageKitId
        } else {
            print("Warning: ImageKit.configure() called multiple times. Ignoring.")
        }
        
        self.userDefaults.set(clientPublicKey, forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY)
        self.userDefaults.set(imageKitId, forKey: UserDefaultKeys.KEY_IMAGEKIT_ID_KEY)
        userDefaults.synchronize()
    }
    
    //Upload Image of type Data
    public func uploadImage(_ image: Data, fileName: String, signature: String, timestamp: Date, useUniqueFilename: Bool = true, tags: Array<String>?, folder: String?) {//}, imageKitCallback: ImageKitCallback) {
        let mRepository = Repository.init()
        mRepository.uploadImage(image, fileName: fileName, signature: signature, timestamp: timestamp, tags: tags, folder: folder)
    }
    
    //Upload Image of type URL
    public func uploadFile(_ file: URL, fileName: String, signature: String, timestamp: Date, useUniqueFilename: Bool = true, tags: Array<String>?, folder: String?) {//}, imageKitCallback: ImageKitCallback) {
        let mRepository = Repository.init()
        //mRepository.uploadImage(image, fileName: fileName, signature: signature, timestamp: timestamp, tags: tags, folder: folder)
    }
}
