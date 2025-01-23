//
//  MImageExample.swift
//  Examples
//
//  Created by Sviatoslav Fil on 23/01/2025.
//

import SwiftUI
import MImage

/// An example container showing how to use `MImage` with multiple symbols and variants.
public struct MImageExample: View {

    // MARK: - State
    @State private var variant: SymbolVariants = .none
    @State private var symbolIndex: Int = 0
    @State private var variantIndex: Int = 0
    @State private var tint: Color = .gray

    // MARK: - Constants
    private let variants: [SymbolVariants] = [
        .none, .fill, .slash, .rectangle, .circle, .square
    ]

    private let previewSymbols: [String] = [
        "bookmark", "heart", "star", "hand.thumbsup",
        "square.and.arrow.up", "trash", "arrowshape.right", "person.badge.plus"
    ]

    // MARK: - Body
    public var body: some View {
        VStack(spacing: 0) {
            instructionsView

            // A TabView to swipe between different SF Symbol names
            TabView(selection: $symbolIndex) {
                ForEach(Array(previewSymbols.enumerated()), id: \.element) { (index, symbolName) in
                    VStack(spacing: 12) {
                        // Tap button to move to the next variant
                        Button(action: nextVariant) {
                            MImage(systemName: symbolName, variant: variant)
                                .frame(width: 100, height: 100)
                                .foregroundStyle(tint)
                                .symbolDuration(1.0)
                        }
                        .buttonStyle(.plain)

                        // Show the symbol name below
                        Text(symbolName)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .tag(index)
                    .tabItem {
                        Image(systemName: symbolName)
                    }
                }
            }
            #if os(iOS) || os(watchOS)
            .tabViewStyle(.page(indexDisplayMode: .always))
            #endif
        }
        // Place color selector at the bottom
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                ColorSelector(color: $tint)
                    .frame(height: 50)
                    .padding(.vertical)
            }
        }
    }

    // MARK: - Subviews
    
    /// A small top instruction to guide the user.
    private var instructionsView: some View {
        VStack(spacing: 8) {
            Text("Tap \(Image(systemName: "hand.tap")) to change variant")
            Text("or swipe \(Image(systemName: "hand.draw.fill")) to change symbol")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.lightGray).opacity(0.25))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }

    // MARK: - Actions
    
    /// Cycles to the next variant in the `variants` array.
    private func nextVariant() {
        variantIndex = (variantIndex + 1) % variants.count
        variant = variants[variantIndex]
    }
}

/// A helper view for choosing from a set of colors.
struct ColorSelector: View {
    @Binding var color: Color
    
    private let colors: [Color] = [.gray, .red, .green, .blue, .orange, .black]
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 10) {
                    Spacer().frame(width: (proxy.size.height / 2) - 10)
                    
                    ForEach(colors, id: \.self) { selectedColor in
                        Button {
                            color = selectedColor
                        } label: {
                            Circle()
                                .fill(selectedColor)
                                .overlay(
                                    Circle()
                                        .stroke(
                                            selectedColor == color ? color.opacity(0.5) : Color.clear,
                                            lineWidth: 5
                                        )
                                )
                                .frame(
                                    width: proxy.size.height,
                                    height: proxy.size.height + 5
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MImageExample()
}
