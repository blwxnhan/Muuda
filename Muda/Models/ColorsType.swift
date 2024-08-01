//
//  ColorsType.swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import UIKit

enum ColorsType: Codable {
    case first, second, third, fourth, fifth
    
    func toUIColor() -> UIColor {
        switch self {
        case .first:
                .first
        case .second:
                .second
        case .third:
                .third
        case .fourth:
                .fourth
        case .fifth:
                .fifth
        }
    }
    
    static func stringToType(_ text: String) -> ColorsType {
        switch text {
        case "first":
                .first
        case "second":
                .second
        case "third":
                .third
        case "fourth":
                .fourth
        case "fifth":
                .fifth
        default:
                .first
        }
    }
    
    func toString() -> String {
        switch self {
        case .first:
            "first"
        case .second:
            "second"
        case .third:
            "third"
        case .fourth:
            "fourth"
        case .fifth:
            "fifth"
        }
    }
    
    func toInt() -> Int {
        switch self {
        case .first:
            0
        case .second:
            1
        case .third:
            2
        case .fourth:
            3
        case .fifth:
            4
        }
    }
}
