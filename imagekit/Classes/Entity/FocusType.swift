//
//  FocusType.swift
//  Alamofire
//
//  Created by Akshit New on 04/07/19.
//

import Foundation


enum FocusType: String {
    case CENTER = "center"
    case TOP = "top"
    case LEFT = "left"
    case BOTTOM = "bottom"
    case RIGHT = "right"
    case TOP_LEFT = "top_left"
    case TOP_RIGHT = "top_right"
    case BOTTOM_LEFT = "bottom_left"
    case BOTTOM_RIGHT = "bottom_right"
    case AUTO = "auto"
    
    static func getEnum(string: String) -> FocusType {
        switch string {
        case CENTER.rawValue: return FocusType.CENTER
        case TOP.rawValue: return FocusType.TOP
        case LEFT.rawValue: return FocusType.LEFT
        case BOTTOM.rawValue: return FocusType.BOTTOM
        case RIGHT.rawValue: return FocusType.RIGHT
        case TOP_LEFT.rawValue: return FocusType.TOP_LEFT
        case TOP_RIGHT.rawValue: return FocusType.TOP_RIGHT
        case BOTTOM_LEFT.rawValue: return FocusType.BOTTOM_LEFT
        case BOTTOM_RIGHT.rawValue: return FocusType.BOTTOM_RIGHT
        case AUTO.rawValue: return FocusType.AUTO
        default: fatalError("FocusType string another value except the ones defined in FocusType enum")
            break
        }
    }
}
