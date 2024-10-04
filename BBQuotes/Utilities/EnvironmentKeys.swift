//
//  EnvironmentKeys.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/10/4.
//

import SwiftUI

private struct GeometrySizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var geometrySize: CGSize {
        get { self[GeometrySizeKey.self] }
        set { self[GeometrySizeKey.self] = newValue }
    }
}
