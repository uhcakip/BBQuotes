//
//  Production.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/9/27.
//

import Foundation

enum Production: String {
    case breakingBad = "Breaking Bad"
    case betterCallSaul = "Better Call Saul"
    case elCamino = "El Camino"

    private var colorName: String {
        rawValue.replacingOccurrences(of: " ", with: "")
    }

    var backgroundImageName: String {
        rawValue.replacingOccurrences(of: " ", with: "-").lowercased()
    }

    var buttonColorName: String {
        "\(colorName)Button"
    }

    var shadowColorName: String {
        "\(colorName)Shadow"
    }
}
