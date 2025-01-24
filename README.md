# MImage

A SwiftUI view that provides morphing blur transitions between SF Symbol variants.

## Features

- **Blur Transition**: Smoothly transitions between symbol variants with a configurable blur in/out effect.
- **Environment-Based Duration**: Set the duration once in the environment for consistent animations.
- **Canvas Clipping**: Uses SwiftUI's `Canvas` to alpha-threshold the symbol shape.

## Installation

1. **Swift Package Manager** (Recommended)  
   In Xcode, go to `File → Add Packages...` and use the repository URL:
   https://github.com/flsv/MImage.git
   Then select the "MImage" library for your app target.

2. **Add as a Swift Package** in your `Package.swift`:
```swift
.package(url: "https://github.com/YourUsername/MImage.git", from: "1.0.0"),
```

## Usage
1. **Import the module:**
```swift
import MImage
```

2. **Use MImage in your SwiftUI code:**
```swift
struct ContentView: View {
    // Tracks whether we're using the `.fill` variant
    @State private var useFilledVariant = false
    // Tracks whether color tint is enabled
    @State private var colorEnabled = false
    
    var body: some View {
        VStack(spacing: 20) {
            // The MImage view
            MImage(
                systemName: "heart",
                variant: useFilledVariant ? .fill : .none
            )
            // Set a 2-second blur transition for morphing the symbol variant
            .symbolDuration(2.0)
            // Apply or remove a color tint based on `colorEnabled`
            .foregroundStyle(colorEnabled ? .primary : .secondary)
            .frame(width: 100, height: 100)
            
            // Button to toggle between `.none` and `.fill`
            Button("Toggle Variant") {
                useFilledVariant.toggle()
            }
            
            // Button to enable/disable the color tint
            Button(colorEnabled ? "Disable Color" : "Enable Color") {
                colorEnabled.toggle()
            }
        }
        .padding()
    }
}
```

3. **Morphing: Change variant to e.g. .none, .fill, or .circle.**
    The blur animation triggers automatically.

## Example App

See the Examples/MImageExampleApp folder for a small SwiftUI demo project that showcases how to tap or swipe through different symbols/variants.

## Requirements

• iOS 15+, macOS 11+, watchOS 8+.
• Swift 5.5+.

## Contributing

Feel free to open issues or pull requests!

## License

This library is released under the MIT License. See LICENSE for details.
