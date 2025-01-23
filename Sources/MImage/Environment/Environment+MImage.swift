//
//  Environment+MImage.swift
//  MImage
//
//  Created by Sviatoslav Fil on 23/01/2025.
//

import SwiftUI

// MARK: - Environment Keys

/// An environment key for setting the morphing image animation duration.
private struct SymbolDurationKey: EnvironmentKey {
    static let defaultValue: Double = 1.0
}

// MARK: - Environment Values

public extension EnvironmentValues {
    /// The duration (in seconds) of the morphing image’s blur transition.
    var symbolDuration: Double {
        get { self[SymbolDurationKey.self] }
        set { self[SymbolDurationKey.self] = newValue }
    }
}
