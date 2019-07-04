//
//  OverlayFocusType.swift
//  Alamofire
//
//  Created by Akshit New on 04/07/19.
//

import Foundation


enum OverlayFocusType: String {
    case CENTER = "center"
    case TOP = "top"
    case LEFT = "left"
    case BOTTOM = "bottom"
    case RIGHT = "right"
    case TOP_LEFT = "top_left"
    case TOP_RIGHT = "top_right"
    case BOTTOM_LEFT = "bottom_left"
    case BOTTOM_RIGHT = "bottom_right"
    
    static func getEnum(string: String) -> OverlayFocusType {
        switch string {
        case CENTER.rawValue: return OverlayFocusType.CENTER
        case TOP.rawValue: return OverlayFocusType.TOP
        case LEFT.rawValue: return OverlayFocusType.LEFT
        case BOTTOM.rawValue: return OverlayFocusType.BOTTOM
        case RIGHT.rawValue: return OverlayFocusType.RIGHT
        case TOP_LEFT.rawValue: return OverlayFocusType.TOP_LEFT
        case TOP_RIGHT.rawValue: return OverlayFocusType.TOP_RIGHT
        case BOTTOM_LEFT.rawValue: return OverlayFocusType.BOTTOM_LEFT
        case BOTTOM_RIGHT.rawValue: return OverlayFocusType.BOTTOM_RIGHT
        default: fatalError("OverlayFocusType string another value except the ones defined in OverlayFocusType enum")
            break
        }
    }
}
