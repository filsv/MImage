//
//  ViewModifiers+MImage.swift
//  MImage
//
//  Created by Sviatoslav Fil on 23/01/2025.
//

import SwiftUI

// MARK: - View Modifiers

public extension View {
    /// Sets the morphing image blur transition duration within the environment.
    ///
    /// - Parameter duration: The desired blur animation duration (in seconds).
    /// - Returns: A view with the updated environment value.
    func symbolDuration(_ duration: Double) -> some View {
        self.environment(\.symbolDuration, duration)
    }
}
