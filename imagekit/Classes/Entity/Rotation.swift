//
//  Rotation.swift
//  Alamofire
//
//  Created by Akshit New on 04/07/19.
//

import Foundation


enum Rotation: String {
    case AUTO = "auto"
    case VALUE_0 = "0"
    case VALUE_90 = "90"
    case VALUE_180 = "180"
    case VALUE_270 = "270"
    case VALUE_360 = "360"
    
    static func getEnum(string: String) -> Rotation {
        switch string {
        case AUTO.rawValue: return Rotation.AUTO
        case VALUE_0.rawValue: return Rotation.VALUE_0
        case VALUE_90.rawValue: return Rotation.VALUE_90
        case VALUE_180.rawValue: return Rotation.VALUE_180
        case VALUE_270.rawValue: return Rotation.VALUE_270
        case VALUE_360.rawValue: return Rotation.VALUE_360
        default: fatalError("Rotation string another value except the ones defined in Rotation enum")
            break
        }
    }
}
