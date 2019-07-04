//
//  OverlayTextTypography.swift
//  Alamofire
//
//  Created by Akshit New on 04/07/19.
//

import Foundation


enum OverlayTextTypography: String {
    case BOLD = "b"
    case ITALICS = "i"
    case BOLD_ITALICS = "bi"
    
    static func getEnum(string: String) -> OverlayTextTypography {
        switch string {
        case BOLD.rawValue: return OverlayTextTypography.BOLD
        case ITALICS.rawValue: return OverlayTextTypography.ITALICS
        case BOLD_ITALICS.rawValue: return OverlayTextTypography.BOLD_ITALICS
        default: fatalError("OverlayTextTypography string another value except the ones defined in OverlayTextTypography enum")
            break
        }
    }
}
