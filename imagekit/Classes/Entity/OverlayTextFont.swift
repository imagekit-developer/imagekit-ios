//
//  OverlayTextFont.swift
//  Alamofire
//
//  Created by Akshit New on 04/07/19.
//

import Foundation


enum OverlayTextFont: String {
    case ABRIL_FAT_FACE = "AbrilFatFace"
    case AMARANTH = "Amarnath"
    case ARVO = "Arvo"
    case AUDIOWIDE = "Audiowide"
    case EXO = "exo"
    case FREDOKA_ONE = "FredokaOne"
    case KANIT = "Kanit"
    case LATO = "Lato"
    case LOBSTER = "Lobster"
    case LORA = "Lora"
    case MONOTON = "Monoton"
    case MONTSERRAT = "Montserrat"
    case PT_MONO = "PT_Mono"
    case PT_SERIF = "PT_Serif"
    case OPEN_SANS = "OpenSans"
    case ROBOTO = "Roboto"
    case STAG_OLD_STANDARD = "stagOldStandard"
    case UBUNTU = "Ubuntu"
    case VOLLKORN = "Vollkorn"
    
    static func getEnum(string: String) -> OverlayTextFont {
        switch string {
        case ABRIL_FAT_FACE.rawValue: return OverlayTextFont.ABRIL_FAT_FACE
        case AMARANTH.rawValue: return OverlayTextFont.AMARANTH
        case ARVO.rawValue: return OverlayTextFont.ARVO
        case AUDIOWIDE.rawValue: return OverlayTextFont.AUDIOWIDE
        case EXO.rawValue: return OverlayTextFont.EXO
        case FREDOKA_ONE.rawValue: return OverlayTextFont.FREDOKA_ONE
        case KANIT.rawValue: return OverlayTextFont.KANIT
        case LATO.rawValue: return OverlayTextFont.LATO
        case LOBSTER.rawValue: return OverlayTextFont.LOBSTER
        case LORA.rawValue: return OverlayTextFont.LORA
        case MONOTON.rawValue: return OverlayTextFont.MONOTON
        case MONTSERRAT.rawValue: return OverlayTextFont.MONTSERRAT
        case PT_MONO.rawValue: return OverlayTextFont.PT_MONO
        case PT_SERIF.rawValue: return OverlayTextFont.PT_SERIF
        case OPEN_SANS.rawValue: return OverlayTextFont.OPEN_SANS
        case ROBOTO.rawValue: return OverlayTextFont.ROBOTO
        case STAG_OLD_STANDARD.rawValue: return OverlayTextFont.STAG_OLD_STANDARD
        case UBUNTU.rawValue: return OverlayTextFont.UBUNTU
        case VOLLKORN.rawValue: return OverlayTextFont.VOLLKORN
        default: fatalError("OverlayTextFont string another value except the ones defined in OverlayTextFont enum")
            break
        }
    }
}
