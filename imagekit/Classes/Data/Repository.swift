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
    private var uploadUrl: String = "https://upload.imagekit.io/rest/api/image/v2/$"
    
    public func uploadImage(_ image: Data, fileName: String, signature: String, timestamp: Date, useUniqueFilename: Bool = true, tags: Array<String>?, folder: String?) {
        //mRepository.uploadImage(fileName, signature, timestamp, useUniqueFilename, tags, folder, image, imageKitCallback)
    }
    
    
    
    static func makeCallWithJSONandImageUpload<T: Mappable>(method: HTTPMethod, url: String, parameter: [String: AnyObject]? = nil, image: Data, completionHandler: @escaping (_ data: T?,_ error: Error?) -> Void) {
        
        var headers: [String: String]? = nil
        headers = ["Content-Type":"application/json"]
        
        _ = Alamofire.upload(multipartFormData: { (MultipartFormData) in
            MultipartFormData.append(image, withName: "profile_image_url", fileName: "file.png", mimeType: "image/png")
            
            for (key, value) in parameter! {
                if value is String || value is Int {
                    MultipartFormData.append("\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                }
            }
        }, to: url, method: method, headers: headers) { (result) in
            
            print("UPLOAD RESULT - \(result)")
            
            //ApiResponseHandler<T>.handleObjectResponse(response: result., completion: completionHandler)
        }
    }
    
}
