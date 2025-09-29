//
//  Int+Ext.swift
//  Memorize
//
//  Created by KevinMartinez on 9/29/25.
//

import Foundation

extension Int {
    var adaptiveCardWidth: CGFloat {
        switch self {
        case ...8: return 120
        case 9...16: return 95
        case 17...24: return 75
        default: return 60
        }
    }
}
