//
//  TransformationPosition.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 16/07/20.
//

import Foundation

public enum TransformationPosition: String{
    case PATH = "path"
    case QUERY = "query"
    
    static func getEnum(string: String) -> TransformationPosition{
        switch string {
            case PATH.rawValue: return TransformationPosition.PATH
            case QUERY.rawValue: return TransformationPosition.QUERY
            default: fatalError("Invalid transformationPosition parameter")
                break
        }
    }
    
    static func getRawValue(transformationPostion: TransformationPosition) -> String{
        return transformationPostion.rawValue
    }
    
}
