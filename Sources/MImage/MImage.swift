//
//  MImage.swift
//  MImage
//
//  Created by Sviatoslav Fil on 23/01/2025.
//

import SwiftUI

/// A customizable image view that supports morphing animations between SF Symbol variants.
///
/// `MImage` uses a combination of blur and symbol variant transitions to create
/// a morphing effect between different SF Symbol variants of the same base name.
///
public struct MImage: View {
    // MARK: - Public Properties
    
    /// The base SF Symbol name (e.g. `"heart"`, `"star"`).
    private let systemName: String
    
    /// The current symbol variant applied to this image (e.g. `.fill`, `.circle`, etc.).
    private let variant: SymbolVariants

    // MARK: - Environment Values
    
    /// Duration for the blur effect animation. Obtained from the environment.
    @Environment(\.symbolDuration) private var duration
    
    // MARK: - State
    
    /// Local state for controlling the blur radius over time.
    @State private var blurRadius: Double = 0
    
    /// A reference to the ongoing blur task, so it can be canceled if a new variant arrives quickly.
    @State private var currentTask: Task<Void, Never>?

    // MARK: - Initialization

    /// Initializes an `MImage` with a specified SF Symbol name and variant.
    ///
    /// - Parameters:
    ///   - systemName: The base name of the SF Symbol (e.g. "heart", "star").
    ///   - variant: A `SymbolVariants` value that modifies the symbol shape (e.g. `.fill`, `.circle`).
    public init(systemName: String, variant: SymbolVariants) {
        self.systemName = systemName
        self.variant = variant
    }

    // MARK: - Body

    public var body: some View {
        GeometryReader { geometry in
            let dimension = max(geometry.size.width, geometry.size.height)
            let maxBlurRadius = min(dimension * 0.05, 20)

            // Use Canvas to clip to the shape of the SF Symbol based on alpha thresholds.
            Canvas { context, size in
                context.clipToLayer { context in
                    context.addFilter(.alphaThreshold(min: 0.5))
                    context.drawLayer { context in
                        if let resolvedSymbol = context.resolveSymbol(id: 0) {
                            // Draw the symbol at the center of the available canvas area.
                            context.draw(
                                resolvedSymbol,
                                at: CGPoint(x: size.width / 2, y: size.height / 2)
                            )
                        }
                    }
                }
                
                // Fill the clipped region with the current foreground color.
                context.fill(
                    Path(CGRect(origin: .zero, size: size)),
                    with: .foreground
                )
            } symbols: {
                // The actual symbol view is tagged with "0".
                symbol(forSize: geometry.size)
                    .tag(0)
            }
            // Trigger the blur animation whenever the variant changes.
            .onChange(of: variant) { _ in
                animateBlur(to: maxBlurRadius)
            }
        }
    }

    // MARK: - Private Helpers

    /// Returns the symbol view (with the current variant) sized to the container's dimensions.
    private func symbol(forSize size: CGSize) -> some View {
        ZStack(alignment: .center) {
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .symbolVariant(variant)
                .frame(width: size.width, height: size.height, alignment: .center)
                // Using the variant as the ID so SwiftUI can track changes to it.
                .id(variant)
        }
        // Animate the symbol variant change with the environment-based animation.
        .animation(.easeInOut(duration: duration), value: variant)
        // Apply the dynamic blur (animated separately in `animateBlur(to:)`).
        .blur(radius: blurRadius)
    }

    /// Animates a blur in and then back out to create a "morphing" transition effect.
    ///
    /// - Parameter maxBlurRadius: The maximum blur radius to reach at the midpoint of the animation.
    private func animateBlur(to maxBlurRadius: Double) {
        // Cancel any in-progress task if another variant change arrives.
        currentTask?.cancel()

        currentTask = Task {
            let halfDuration = duration / 2

            // Animate the blur in using `.easeIn`.
            withAnimation(.easeIn(duration: halfDuration)) {
                blurRadius = maxBlurRadius
            }

            // Pause for half of the total duration (checking for cancellation).
            do {
                try await Task.sleep(nanoseconds: UInt64(halfDuration * 1_000_000_000))
            } catch {
                // If cancelled, skip the second half.
                return
            }

            // Animate the blur back out using `.easeOut`.
            withAnimation(.easeOut(duration: halfDuration)) {
                blurRadius = 0
            }
        }
    }
}
