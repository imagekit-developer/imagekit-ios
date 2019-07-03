//
//  CropType.swift
//  Alamofire
//
//  Created by Akshit New on 03/07/19.
//

import Foundation

enum CropType: String {
    case MAINTAIN_RATIO = "maintain_ratio"
    case FORCE = "force"
    case AT_LEAST = "at_least"
    case AT_MAX = "at_max"

    init(string: String) {
        switch string {
        case MAINTAIN_RATIO.rawValue: return CropType.MAINTAIN_RATIO
        case FORCE.rawValue: return CropType.FORCE
        case AT_LEAST.rawValue: return CropType.AT_LEAST
        case AT_MAX.rawValue: return CropType.AT_MAX
        default: fatalError("CropType string another value except the ones defined in CropType enum")
            break
        }
    }
}
