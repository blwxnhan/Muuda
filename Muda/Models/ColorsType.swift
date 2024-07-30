//
//  ColorsType.swift
//  Muda
//
//  Created by Bowon Han on 7/30/24.
//

import UIKit

enum ColorsType {
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
}
