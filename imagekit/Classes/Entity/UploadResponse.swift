//
//  UploadResponse.swift
//  Alamofire
//
//  Created by Akshit New on 12/07/19.
//

import Foundation
import ObjectMapper

public class UploadResponse: Mappable {
    
    var name: String!
    var imagePath: String!
    var size: Int!
    var height: Int!
    var width: Int!
    var url: String!
    
    init() {
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        imagePath <- map["image_path"]
        
        size <- map["size"]
        height <- map["height"]
        width <- map["width"]
        url <- map["url"]
    }
}
