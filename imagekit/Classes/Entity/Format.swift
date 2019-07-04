//
//  Format.swift
//  Alamofire
//
//  Created by Akshit New on 04/07/19.
//

import Foundation


enum Format: String {
    case AUTO = "auto"
    case WEBP = "webp"
    case JPG = "jpg"
    case JPEG = "jpeg"
    case PNT = "pnt"
    
    static func getEnum(string: String) -> Format {
        switch string {
        case AUTO.rawValue: return Format.AUTO
        case WEBP.rawValue: return Format.WEBP
        case JPG.rawValue: return Format.JPG
        case JPEG.rawValue: return Format.JPEG
        case PNT.rawValue: return Format.PNT
        default: fatalError("Format string another value except the ones defined in Format enum")
            break
        }
    }
}
