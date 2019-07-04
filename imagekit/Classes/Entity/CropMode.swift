//
//  CropMode.swift
//  Alamofire
//
//  Created by Akshit New on 04/07/19.
//

import Foundation

enum CropMode: String {
    case RESIZE = "resize"
    case EXTRACT = "extract"
    case PAD_EXTRACT = "pad_extract"
    case PAD_RESIZE = "pad_resize"
    
    static func getEnum(string: String) -> CropMode {
        switch string {
        case RESIZE.rawValue: return CropMode.RESIZE
        case EXTRACT.rawValue: return CropMode.EXTRACT
        case PAD_EXTRACT.rawValue: return CropMode.PAD_EXTRACT
        case PAD_RESIZE.rawValue: return CropMode.PAD_RESIZE
        default: fatalError("CropMode string another value except the ones defined in CropMode enum")
            break
        }
    }
}
