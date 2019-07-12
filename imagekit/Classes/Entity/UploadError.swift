//
//  UploadError.swift
//  Alamofire
//
//  Created by Akshit New on 12/07/19.
//

import Foundation
import ObjectMapper

public class UploadError: Mappable {
    
    var exception = false
    var statusNumber: Int = 1500
    var statusCode: String = "SERVER_ERROR"
    var message: String = "Internal server error while uploading the file"
    
    init() {
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        exception <- map["exception"]
        statusNumber <- map["status_number"]
        statusCode <- map["status_code"]
        message <- map["message"]
    }
}



