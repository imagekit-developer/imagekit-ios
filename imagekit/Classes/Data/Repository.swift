//
//  Repository.swift
//  Alamofire
//
//  Created by Akshit New on 03/07/19.
//

import Foundation
import Alamofire
import ObjectMapper

open class Repository {
    private var uploadUrl: String = "https://upload.imagekit.io/rest/api/image/v2/\(UserDefaults.standard.string(forKey: UserDefaultKeys.KEY_IMAGEKIT_ID_KEY))"
    
    public func uploadImage(_ image: Data, fileName: String, signature: String, timestamp: Date, useUniqueFilename: Bool = true, tags: Array<String>?, folder: String?, completionHandler: @escaping (_ data: UploadResponse?, _ isSuccessful: Bool, _ error: UploadError?) -> Void) {
        
        //mRepository.uploadImage(fileName, signature, timestamp, useUniqueFilename, tags, folder, image, imageKitCallback)
    }
    
    
    
    
    
    func makeCallWithJSON<T: Mappable>(method: HTTPMethod, url: String, parameter: [String: AnyObject]? = nil, image: Data, completion: (_ data: T?, _ isSuccessful: Bool, _ error: UploadError?) -> Void) {
        
        var headers: [String: String]? = nil
        headers = ["accept":"application/json"]
        
        _ = Alamofire.upload(multipartFormData: { (MultipartFormData) in
            MultipartFormData.append(image, withName: "profile_image_url", fileName: "file.png", mimeType: "image/png")
            
            for (key, value) in parameter! {
                if value is String || value is Int {
                    MultipartFormData.append("\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                }
            }
        }, to: url, method: method, headers: headers) { (result) in
            
            print("UPLOAD RESULT - \(result)")
            
            switch result {
            case .success:
                
                let responseDictionary = response.result.value as! NSDictionary
                let successInt = responseDictionary.value(forKey: "response_code") as! Int
                
                var success = false
                if successInt == 80 {
                    success = true
                }
                
                if !success {
                    if let errorObject = Mapper<UploadError>().map(JSON: responseDictionary.value(forKey: "error") as! [String : Any]) {
                        completion(nil, success, errorObject)
                    } else {
                        completion(nil, success, UploadError.init())
                    }
                } else {
                    if let data = Mapper<T>().map(JSON: responseDictionary.value(forKey: "data")! as! [String : Any]){
                        completion(data, success, nil)
                    } else {
                        completion(nil, success, UploadError.init())
                    }
                }
            case .failure(let error):
                
                completion(nil, false, ErrorObject.init())
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
