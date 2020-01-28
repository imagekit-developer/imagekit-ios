//
//  TransformationPosition.swift
//  imagekit
//
//  Created by Akshit New on 28/01/20.
//

import Foundation

enum TransformationPosition: String {
    case PATH = "path"
    case QUERY = "query"
    
    static func getEnum(string: String) -> TransformationPosition {
        switch string {
        case PATH.rawValue: return TransformationPosition.PATH
        case QUERY.rawValue: return TransformationPosition.QUERY
        default: fatalError("TransformationPosition string another value except the ones defined in TransformationPosition enum")
            break
        }
    }
}
