//
//  SharedPref.swift
//  Alamofire
//
//  Created by Akshit New on 04/07/19.
//

import Foundation



//protocol UserDefaultPref {
//    func setClientPublicKey(key: String)
//    func getClientPublicKey() -> String
//    
//    func setImageKitId(key: String)
//    func getImageKitId() -> String
//}

open class SharedPref {
    
    public func getClientPublicKey() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_CLIENT_PUBLIC_KEY) ?? ""
    }
    
    public func getImageKitId() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_ID_KEY) ?? ""
    }
}

